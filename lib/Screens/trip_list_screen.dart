import 'package:flutter/material.dart';
import 'package:tripper/data/trip_service.dart';
import 'new_trip_screen.dart';

class TripListScreen extends StatelessWidget {
  const TripListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final svc = TripService();

    return Scaffold(
      appBar: AppBar(title: const Text('My Trips')),
      body: StreamBuilder<List<TripDto>>(
        stream: svc.watchMyTrips(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final trips = snap.data ?? const [];
          if (trips.isEmpty) {
            return const Center(child: Text('No trips yet. Tap + to create.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: trips.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final t = trips[i];
              final date = '${_fmt(t.start)} — ${_fmt(t.end)}';
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.flight_takeoff),
                  title: Text('${t.from} → ${t.to}'),
                  subtitle: Text('$date • ${t.travelers} traveler${t.travelers > 1 ? "s" : ""}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const NewTripScreen()),
        ),
        icon: const Icon(Icons.add), 
        label: const Text('New Trip'),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
