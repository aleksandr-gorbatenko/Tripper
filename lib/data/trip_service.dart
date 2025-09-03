import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TripService {
  static final TripService _singleton = TripService._internal();
  factory TripService() => _singleton;
  TripService._internal();

  final auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get _col => _db.collection('users');

  onListenUser(void Function(User?)? doListen) {
    auth.authStateChanges().listen(doListen);
  }

  onRegister({required String email, required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  onLogin({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  logOut() async {
    await auth.signOut();
  }

  Stream<List<TripDto>> getTrips() {
    final userDoc = _col.doc(userId);
    return userDoc.collection('trips')
        .snapshots()
        .map((s) => s.docs.map((doc) => TripDto.fromFirestore(doc)).toList());
  }

  Future<void> addTrip(TripDto trip) async {
    final userDoc = _col.doc(userId);

    await userDoc.collection('trips').add(trip.toMap());
  }
}

class TripDto {
  final String from;
  final String to;

  TripDto({
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toMap() => {
    'from': from,
    'to': to,
    'createdAt': FieldValue.serverTimestamp(),
  };

  factory TripDto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TripDto(
      from: data['from'] ?? '',
      to: data['to'] ?? '',
    );
  }
}
