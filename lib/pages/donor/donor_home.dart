/*
  Donor Home Page - displays list of all organizations a donor can donate to
*/
import 'package:flutter/material.dart';
import 'package:my_app/pages/donor/donor_donations.dart';
import 'package:my_app/pages/donor/donor_orglist.dart';
import 'package:my_app/pages/donor/donor_profile.dart';

class DonorHome extends StatefulWidget {
  const DonorHome({super.key});

  @override
  State<DonorHome> createState() => _DonorHomeState();
}

class _DonorHomeState extends State<DonorHome> {
  // 
  static List<Widget> _pages = <Widget>[
    DonorOrgList(),
    DonorDonations(),
    DonorProfile(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_rounded),
            label: 'Donations'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
      ),
    );
  }
}
