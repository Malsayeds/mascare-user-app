import 'package:doctoworld_user/Features/BottomNavigation/Offers/offers.dart';
import 'package:doctoworld_user/Features/BottomNavigation/doctors_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/hospitals_page.dart';
import 'package:doctoworld_user/Features/BottomNavigation/appointments_page.dart';
import 'package:doctoworld_user/Features/Location/location_page.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'medicine_find_page.dart';
import 'more_options.dart';

class BottomNavigation extends StatefulWidget {
  final int index;
  BottomNavigation({required this.index});
  @override
  _BottomNavigationState createState() => _BottomNavigationState(currentIndex: this.index);
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex ;
  _BottomNavigationState({required this.currentIndex});
  double start = 0;

  final List<Widget> _children = [
    DoctorsHome(),
    MedicinePage(),
    Offers(),
    AppointmentPage(),
    MoreOptions(),
  ];

  @override
  Widget build(BuildContext context) {
    start = MediaQuery.of(context).size.width *
        currentIndex /
        _children.length;
    var locale = AppLocalizations.of(context)!;
    final List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_doctors.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_doctorsact.png')),
        label: locale.home,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_medicine.png')),
        activeIcon:
        ImageIcon(AssetImage('assets/FooterIcons/ic_medicineact.png')),
        label: locale.medicine,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_hospitals.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_hospitalsact.png')),
        label: locale.offers,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_appointments.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/FooterIcons/ic_appointmentsact.png')),
        label: locale.appointments,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/FooterIcons/ic_more.png')),
        activeIcon: ImageIcon(AssetImage('assets/FooterIcons/ic_moreact.png')),
        label: locale.account,
      ),
    ];
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _children[currentIndex],
          AnimatedPositionedDirectional(
            bottom: 0,
            start: start,
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 2,
              width: MediaQuery.of(context).size.width / 5,
            ),
            duration: Duration(milliseconds: 200),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 20.0,
        type: BottomNavigationBarType.fixed,
        iconSize: 22.0,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        unselectedItemColor: Theme.of(context).disabledColor,
        items: _bottomBarItems,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            start = MediaQuery.of(context).size.width *
                index /
                _bottomBarItems.length;
          });
        },
      ),
    );
  }
}
