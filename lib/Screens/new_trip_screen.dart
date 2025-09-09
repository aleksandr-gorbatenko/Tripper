import 'package:flutter/cupertino.dart';
import 'package:tripper/data/trip_service.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  final TripService tripService = TripService();

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _saveTrip() async {
    if (_fromController.text.isEmpty || _toController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text("Error"),
          content: Text("Fill Data"),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    final trip = TripDto(
      from: _fromController.text,
      to: _toController.text,
      tripId: '',
    );

    await tripService.addTrip(trip);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("New Trip")),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              CupertinoTextField(
                controller: _fromController,
                placeholder: "From",
              ),
              SizedBox(height: 12),
              CupertinoTextField(
                controller: _toController,
                placeholder: "To",
                maxLines: 3,
              ),
              SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: _saveTrip,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
