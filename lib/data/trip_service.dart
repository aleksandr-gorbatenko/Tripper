import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TripDto {
  final String id;
  final String from;
  final String to;
  final DateTime start;
  final DateTime end;
  final int travelers;
  final String ownerId;

  TripDto({
    required this.id,
    required this.from,
    required this.to,
    required this.start,
    required this.end,
    required this.travelers,
    required this.ownerId,
  });

  Map<String, dynamic> toMap() => {
    'from': from,
    'to': to,
    'start': Timestamp.fromDate(start),
    'end': Timestamp.fromDate(end),
    'travelers': travelers,
    'ownerId': ownerId,
    'createdAt': FieldValue.serverTimestamp(),
  };

  static TripDto fromDoc(DocumentSnapshot d) {
    final m = d.data() as Map<String, dynamic>;
    return TripDto(
      id: d.id,
      from: m['from'] ?? '',
      to: m['to'] ?? '',
      start: (m['start'] as Timestamp).toDate(),
      end: (m['end'] as Timestamp).toDate(),
      travelers: (m['travelers'] ?? 1) as int,
      ownerId: m['ownerId'] ?? '',
    );
  }
}

class TripService {
  final _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _col => _db.collection('trips');

  Stream<List<TripDto>> watchMyTrips() => _col
      .where('ownerId', isEqualTo: _uid)
      .orderBy('start')
      .snapshots()
      .map((s) => s.docs.map(TripDto.fromDoc).toList());

  Future<void> addTrip({
    required String from,
    required String to,
    required DateTime start,
    required DateTime end,
    required int travelers,
  }) {
    return _col.add(TripDto(
      id: '',
      from: from,
      to: to,
      start: start,
      end: end,
      travelers: travelers,
      ownerId: _uid,
    ).toMap());
  }
}
