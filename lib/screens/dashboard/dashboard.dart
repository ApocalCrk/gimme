import 'package:flutter/material.dart';
import 'package:gimme/screens/dashboard/slicing/dashboard_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:gimme/screens/statistic/statistics_screen.dart';
import 'package:gimme/constants.dart';


class Dashboard extends StatefulWidget {  
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentIndex = 0;
  PageController? _pageController;

  @override
  void initState(){
    super.initState();
    _pageController = PageController(); 
  }

  @override
  void dispose(){
    super.dispose();
  }
  
  var page = [
    DashboardScreen(),
    const StatisticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => currentIndex = index);
          },
          children: page
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        curve: Curves.easeInOut,
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Feed"),
              selectedColor: primary2Color,
              unselectedColor: const Color(0xFF858585)),
          SalomonBottomBarItem(
              icon: const Icon(Icons.bar_chart),
              title: const Text("Statistics"),
              selectedColor: primary2Color,
              unselectedColor: const Color(0xFF858585)),
          SalomonBottomBarItem(
              icon: const Icon(Icons.fitness_center),
              title: const Text("Workouts"),
              selectedColor: primary2Color,
              unselectedColor: const Color(0xFF858585)),
          SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Explore"),
              selectedColor: primary2Color,
              unselectedColor: const Color(0xFF858585)),
          SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: primary2Color,
              unselectedColor: const Color(0xFF858585)),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
        _pageController?.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }
}
