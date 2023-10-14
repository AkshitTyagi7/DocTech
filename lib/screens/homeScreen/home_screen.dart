import 'package:doctech/screens/homeScreen/home_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/emergency.svg',
              color: _selectedIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/aidoctor.svg',
              color: _selectedIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
            ),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/emergency.svg',
              color: _selectedIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
            ),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
/*       NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/icons/emergency.svg',
              color: Theme.of(context).primaryColor,
            ),
            icon: SvgPicture.asset('assets/icons/emergency.svg'),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              'assets/icons/aidoctor.svg',
              color: Theme.of(context).primaryColor,
            ),
            icon: SvgPicture.asset('assets/icons/aidoctor.svg'),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.school),
            icon: Icon(Icons.school_outlined),
            label: 'School',
          ),
        ],
      ), */
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        DoctoListingScreen(),
        Image.asset('assets/profile.png'),
      ][_selectedIndex],
    );
  }
}
