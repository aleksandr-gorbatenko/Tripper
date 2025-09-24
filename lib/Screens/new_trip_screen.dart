import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:tripper/data/trip_service.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final _whereController = TextEditingController();
  final _toController = TextEditingController();
  final _fromController = TextEditingController();
  final _tillController = TextEditingController();
  String _group = 'solo';

  final TripService tripService = TripService();

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
      where: _whereController.text,
      to: _toController.text,
      from: _fromController.text,
      till: _tillController.text,
      group: _group,
      tripId: '',
    );

    await tripService.addTrip(trip);
    if (!mounted) return;
    Navigator.pop(context);
  }

  Widget _pageName(String name) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: CupertinoColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CupertinoColors.white.withOpacity(0.3),
              width: 1.2,
            ),
            gradient: LinearGradient(
              colors: [
                CupertinoColors.white.withOpacity(0.25),
                CupertinoColors.white.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(child: Text(name)),
        ),
      ),
    );
  }

  Widget _field(Widget child1, Widget child2) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
            color: CupertinoColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CupertinoColors.white.withOpacity(0.3),
              width: 1.2,
            ),
            gradient: LinearGradient(
              colors: [
                CupertinoColors.white.withOpacity(0.25),
                CupertinoColors.white.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(child: child1),
              Expanded(child: child2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _switch() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CupertinoColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: CupertinoColors.white.withOpacity(0.3),
              width: 1.2,
            ),
            gradient: LinearGradient(
              colors: [
                CupertinoColors.white.withOpacity(0.25),
                CupertinoColors.white.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: CupertinoSegmentedControl<String>(
            padding: EdgeInsets.all(8),
            groupValue: _group,
            unselectedColor: CupertinoColors.transparent,
            selectedColor: CupertinoColors.transparent,
            borderColor: null,
            children: {
              "solo": Text(
                "Solo",
                style: TextStyle(color: CupertinoColors.white),
              ),
              "group": Text(
                "Group",
                style: TextStyle(color: CupertinoColors.white),
              ),
            },
            onValueChanged: (val) {
              setState(() {
                _group = val;

              });
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _pageName('New Trip'),
          _field(
            CupertinoTextField(
              controller: _whereController,
              placeholder: "Where",
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  bottom: BorderSide(color: CupertinoColors.transparent),
                ),
                color: CupertinoColors.transparent,
              ),
            ),
            CupertinoTextField(
              controller: _toController,
              placeholder: "To",
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  bottom: BorderSide(color: CupertinoColors.transparent),
                ),
                color: CupertinoColors.transparent,
              ),
            ),
          ),
          _field(
            CupertinoTextField(
              controller: _fromController,
              placeholder: "From",
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  bottom: BorderSide(color: CupertinoColors.transparent),
                ),
                color: CupertinoColors.transparent,
              ),
            ),
            CupertinoTextField(
              controller: _tillController,
              placeholder: "Till",
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  bottom: BorderSide(color: CupertinoColors.transparent),
                ),
                color: CupertinoColors.transparent,
              ),
            ),
          ),
          _switch(),
          CupertinoButton.filled(onPressed: _saveTrip, child: Text("Save")),
        ],
      ),
    );
  }
}
