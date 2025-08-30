// lib/screens/main_app_screen.dart
import 'package:flutter/cupertino.dart';

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

  Widget _tripsPage() {
    return TripsGrid(
      trips: [
        "Barcelona",
        "Tokyo",
        "Berlin",
        "Vienna",
      ],
    );
  }

  Widget _offersPage() {
    return Text("data");
  }

  Widget _friendsPage() {
    return Text("data");
  }

  Widget _page(String label) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
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
                  //_friendsPage(),
                  _page("1"),
                  _tripsPage(),
                  _page("3"),
                  //_offersPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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