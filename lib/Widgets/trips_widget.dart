import 'package:flutter/cupertino.dart';

class TripsWidget extends StatefulWidget {
  const TripsWidget({super.key});

  @override
  State<TripsWidget> createState() => _TripsWidget();
}

class _TripsWidget extends State<TripsWidget>{

  @override
  Widget build( context) {
    return TripsGrid(
      trips: [
        "Barcelona",
        "Tokyo",
        "Berlin",
        "Vienna",
      ],
    );;
  }


}

class TripsGrid extends StatelessWidget {
  final List<String> trips;

  const TripsGrid({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _TripCard(title: " ");
        }
        return _TripCard(title: trips[index]);
      },
    );
  }
}

class _TripCard extends StatelessWidget {
  final String title;

  const _TripCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}