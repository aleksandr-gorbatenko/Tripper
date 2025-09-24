// lib/screens/main_app_screen.dart
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:tripper/Screens/new_trip_screen.dart';
import '../Widgets/card_widget.dart';
import '../Widgets/trips_widget.dart';
import '../Widgets/offers_widget.dart';
import '../Widgets/profile_widget.dart';

class MainAppPages extends StatefulWidget {
  const MainAppPages({super.key});

  @override
  State<MainAppPages> createState() => _MainAppPagesState();
}

class _MainAppPagesState extends State<MainAppPages> {
  PageController _pageController = PageController();
  int _currentIndex = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  void _onTapAdd() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 34, 10, 26),
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
              child: Center(child: NewTripScreen()),
            ),
          ),
        );
      },
    );
  }

  Widget _navBar() {
    final icons = [
      CupertinoIcons.house_fill,
      CupertinoIcons.person_alt_circle_fill,
      CupertinoIcons.flame_fill,
      CupertinoIcons.add,
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          margin: EdgeInsets.all(24),
          height: 90,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(icons.length, (index) {
              final bool isActive = _currentIndex == index;
              return BaseCard(
                onTap: () =>  index == 3 ?
                _onTapAdd() :
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Icon(icons[index], color: CupertinoColors.black, size: 50),
                ),
              );
            }),
          ),
        ),
      ),
    );
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
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentIndex = i),
              children: [TripsWidget(), ProfileWidget(), OffersWidget()],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _navBar()
          ),
        ],
      ),
    );
  }
}
