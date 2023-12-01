import 'package:flutter/material.dart';
import 'package:gimme/screens/dashboard/slicing/dashboard_screen.dart';
import 'package:gimme/screens/profile/profile_screen.dart';
import 'package:gimme/screens/explore/explore_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:gimme/screens/statistic/statistics_screen.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/profile/profile_screen.dart';

import 'package:gimme/screens/workouts/workouts_sreen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:gimme/screens/dashboard/slicing/panel.dart';

class Dashboard extends StatefulWidget {  
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = ScrollController(); 

  var currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); 
    readDataShortcuts();
  }

  readDataShortcuts() async {
    var start = await SharedPref.readPrefStr("shortcuts");
    Map<int, Map<dynamic, String>> dataTemp = convertJsonToMap(start);
    setState(() {
      dataUser['shortcuts'] = dataTemp;
    });
  }

  var page = [
    const DashboardScreen(),
    const StatisticsScreen(),
    const WorkoutsScreen(),
    const ExploreScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlidingUpPanel(
        controller: panelController,
        minHeight: 0,
        maxHeight: 280,
        defaultPanelState: PanelState.CLOSED,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        backdropEnabled: true,
        backdropOpacity: 0.3,
        backdropTapClosesPanel: true,
        backdropColor: Colors.black.withOpacity(0.5),
        panelBuilder: (controller) {
          return Panel(
            controller: controller,
            panelController: panelController,
          );
        },
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: page
          ),
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
