import 'package:flutter/cupertino.dart';
import '../Screens/trip_page.dart';
import 'card_widget.dart';
import 'package:tripper/data/trip_service.dart';

class TripsWidget extends StatefulWidget {
  const TripsWidget({super.key});

  @override
  State<TripsWidget> createState() => _TripsWidgetState();
}

class _TripsWidgetState extends State<TripsWidget> {
  final TripService tripService = TripService();

  void _goToTripPage(String tripId) {
    Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (_) => TripPage(tripId: tripId)));
  }

  Widget _tripCard(TripDto trip) {
    return BaseCard(
      child: Center(
        child: Text(
          "${trip.where} → ${trip.to}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      onTap: () => _goToTripPage(trip.tripId),
    );
  }

  @override
  Widget build(context) {
    return StreamBuilder<List<TripDto>>(
      stream: tripService.getTrips(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        }

        final trips = snapshot.data!;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(12, 32, 12, 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return _tripCard(trips[index]);
          },
        );
      },
    );
  }
}
