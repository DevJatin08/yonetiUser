import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:userapp/Constant/ConstantValues.dart';
import 'package:userapp/Screen/NavigationScreens/Bookmark/Bookmark.dart';
import 'package:userapp/Screen/NavigationScreens/Home/HomeLocation.dart';
import 'package:userapp/Screen/NavigationScreens/Profile/ProfileScreen.dart';
import 'package:userapp/Screen/NavigationScreens/Yoneti/TopYoneti.dart';

import 'Discovery/Discovery.dart';

class BaseHomeWidget extends StatefulWidget {
  @override
  _BaseHomeWidgetState createState() => _BaseHomeWidgetState();
}

class _BaseHomeWidgetState extends State<BaseHomeWidget> {
  int currentIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    final bottomBarIcon = 30.0;
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(child: pageRedirect()),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.white,
                textTheme:
                    Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white))),
            child: Material(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 01),
                child: BottomNavigationBar(
                  showUnselectedLabels: true,
                  currentIndex: currentIndex,
                  onTap: (i) {
                    currentIndex = i;
                    setState(() {});
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedIconTheme: IconThemeData(
                    color: primaryColor,
                  ),
                  selectedItemColor: primaryColor,
                  unselectedItemColor: Colors.grey,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  iconSize: 30,
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            currentIndex == 0 ? 'assets/SVG/homefilled.svg' : 'assets/SVG/home.svg',
                            color: currentIndex == 0 ? primaryColor : Color(0xffdcdcdc),
                            height: 25,
                            width: 30,
                            semanticsLabel: 'Home'),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            currentIndex == 1
                                ? 'assets/SVG/LocationFilled.svg'
                                : 'assets/SVG/Location.svg',
                            color: currentIndex == 1 ? primaryColor : Color(0xffdcdcdc),
                            height: 25,
                            width: 30,
                            semanticsLabel: 'Location'),
                        label: "Discovery"),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            currentIndex == 2
                                ? 'assets/SVG/OrdersFillled.svg'
                                : 'assets/SVG/Orders.svg',
                            color: currentIndex == 2 ? primaryColor : Color(0xffdcdcdc),
                            height: 25,
                            width: 30,
                            semanticsLabel: 'Bookmark'),
                        label: "Bookmark"),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            currentIndex == 3
                                ? 'assets/SVG/ServicesFilled.svg'
                                : 'assets/SVG/Services.svg',
                            color: currentIndex == 3 ? primaryColor : Color(0xffdcdcdc),
                            height: 25,
                            width: 30,
                            semanticsLabel: 'Top Yoneti'),
                        label: "Top Yoneti"),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            currentIndex == 4
                                ? 'assets/SVG/ProfileFilled.svg'
                                : 'assets/SVG/Profile.svg',
                            color: currentIndex == 4 ? primaryColor : Color(0xffdcdcdc),
                            height: 25,
                            width: 30,
                            semanticsLabel: 'Profile'),
                        label: "Profile"),
                  ],
                ),
              ),
            )));
  }

  Widget pageRedirect() {
    if (currentIndex == 1) {
      return Discovery();
    }
    //
    else if (currentIndex == 2) {
      return Bookmark();
    } else if (currentIndex == 3) {
      return TopFinder();
    }

    if (currentIndex == 4) {
      return ProfileScreen();
    }

    return HomeScreen();
  }
}
