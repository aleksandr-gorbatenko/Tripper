// lib/screens/main_app_screen.dart
import 'package:flutter/cupertino.dart';
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
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _navBar() {
    final icons = [
      CupertinoIcons.person_alt_circle_fill,
      CupertinoIcons.home,
      CupertinoIcons.star_circle,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemTeal,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(icons.length, (index) {
          final bool isActive = _currentIndex == index;
          return GestureDetector(
            onTap: () => _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive
                    ? CupertinoColors.systemGrey5
                    : CupertinoColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icons[index]),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _navBar(),
            const SizedBox(height: 12),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentIndex = i),
                children: [
                  ProfileWidget(),
                  TripsWidget(),
                  OffersWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

