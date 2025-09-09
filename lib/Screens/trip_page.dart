import 'package:flutter/cupertino.dart';
import 'package:tripper/Widgets/card_widget.dart';
import 'package:tripper/data/trip_service.dart';

class TripPage extends StatefulWidget {
  final String tripId;

  const TripPage({super.key, required this.tripId});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  TripService tripService = TripService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Trip details"),
      ),
      child: SafeArea(
        child: StreamBuilder<TripDto>(
          stream: tripService.getTrip(widget.tripId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CupertinoActivityIndicator());
            }

            final trip = snapshot.data!;

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemTeal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text("${trip.from} -> ${trip.to}")),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        BaseCard(child: Text("Find Hotel")),
                        BaseCard(child: Text("Find Tickets")),
                        BaseCard(child: Text("Notes")),
                        BaseCard(child: Text("Empty")),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
