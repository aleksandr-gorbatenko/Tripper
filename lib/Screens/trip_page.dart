import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripper/Widgets/card_widget.dart';
import 'package:tripper/Widgets/hotel_widget.dart';
import 'package:tripper/data/trip_service.dart';

class TripPage extends StatefulWidget {
  final String tripId;

  const TripPage({super.key, required this.tripId});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  TripService tripService = TripService();

  void _goToHotel() {
    Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (_) => HotelSearchPage()));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6D5DF6),
                  Color(0xFF4AC0E0),
                  Color(0xFF41E09E),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          StreamBuilder<TripDto>(
            stream: tripService.getTrip(widget.tripId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CupertinoActivityIndicator());
              }

              final trip = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Icon(Icons.image, size: 200)),
                  /*Image.asset(
                      "assets/trip.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),*/

                  Divider(
                    color: CupertinoColors.white.withOpacity(0.3),
                    thickness: 1,
                    height: 32,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("${trip.where} -> ${trip.to}"),
                  ),

                  SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "${trip.from} -> ${trip.till}",
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white.withOpacity(0.8),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "This is a description of the trip. You can write the route details here.,"
                      "notes and other information.",
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 24),


                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BaseCard(
                              child: Text("Find Hotel"),
                              onTap: () => _goToHotel(),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: BaseCard(child: Text("Find Tickets")),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: BaseCard(child: Text("Notes"))),
                          SizedBox(width: 8),
                          Expanded(child: BaseCard(child: Text("Empty"))),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
