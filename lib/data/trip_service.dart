import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TripService {
  static final TripService _singleton = TripService._internal();

  factory TripService() => _singleton;

  TripService._internal();

  final auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentUser => auth.currentUser;

  String? get userId => currentUser?.uid;

  Future<void> onAnanym() async {
    try {
      final credential = await FirebaseAuth.instance.signInAnonymously();
      final user = credential.user;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'isGuest': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      print("Auth error: ${e.code}");
    }
  }

  Future<void> onRegister({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        await _db.collection('users').doc(user.uid).set({
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseAuthException catch (e) {
      print("Auth error: ${e.code}");
    }
  }

  Future<void> onLogin({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.code}");
    }
  }

  Future<void> logOut() async {
    await auth.signOut();
  }

  Stream<List<TripDto>> getTrips() {
    if (userId == null) return const Stream.empty();

    return _db
        .collection('users')
        .doc(userId)
        .collection('trips')
        .snapshots()
        .map((s) => s.docs.map((doc) => TripDto.fromFirestore(doc)).toList());
  }

  Future<void> addTrip(TripDto trip) async {
    if (userId == null) return;
    await _db
        .collection('users')
        .doc(userId)
        .collection('trips')
        .add(trip.toMap());
  }
}

class TripDto {
  final String from;
  final String to;

  TripDto({required this.from, required this.to});

  Map<String, dynamic> toMap() => {
    'from': from,
    'to': to,
    'createdAt': FieldValue.serverTimestamp(),
  };

  factory TripDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TripDto(from: data['from'] ?? '', to: data['to'] ?? '');
  }
}
