import 'package:flutter/cupertino.dart';
import 'package:tripper/data/trip_service.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final TripService tripService = TripService();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('email: ${tripService.currentUser?.email}'));
  }
}
