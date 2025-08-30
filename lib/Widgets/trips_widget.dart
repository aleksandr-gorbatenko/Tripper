import 'package:flutter/cupertino.dart';
import 'card_widget.dart';

class TripsWidget extends StatefulWidget {
  const TripsWidget({super.key});

  @override
  State<TripsWidget> createState() => _TripsWidget();
}

class _TripsWidget extends State<TripsWidget> {
  List<String> trips = ["Barcelona", "Tokyo", "Berlin", "Vienna"];

  Widget _addCard() {
    return BaseCard(
      onTap: () => {
        setState(() {
          trips.add("New Trip");
        }),
      },
      child: const Icon(CupertinoIcons.add),
    );
  }

  Widget _tripCard(String title) {
    return BaseCard(
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: trips.length + 1,
      itemBuilder: (context, index) {
        return index == 0 ? _addCard() : _tripCard(trips[index - 1]);
      },
    );
  }
}
