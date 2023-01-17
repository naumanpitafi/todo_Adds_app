import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gtd/images/appImages.dart';
import 'package:gtd/providers/themeProvider.dart';
import 'package:gtd/utils/appColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gtd/utils/sharedPref.dart';
import 'package:provider/provider.dart';
import '../box Screen/boxScreen.dart';
import '../inbox Screen/inboxScreen.dart';
import '../search Screen/searchScreen.dart';
import '../setting Screen/Settings.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    InboxScreen(),
    BoxScreen(),
    SearchScreen(),
    Settings(),
  ];
  DarkThemePreference statusHandler = DarkThemePreference();
  bool status = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<DarkThemeProvider>().getdarkTheme();
    return Consumer<DarkThemeProvider>(builder: (context, prov, _) {
      return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  backgroundColor: prov.darkTheme == false
                      ? AppColors.appThemeColor
                      : Colors.black,
                  icon: const FaIcon(
                    FontAwesomeIcons.house,
                  ),
                  label: "inbox"
                  // backgroundColor: Colors.green
                  ),
              BottomNavigationBarItem(
                backgroundColor: prov.darkTheme == false
                    ? AppColors.appThemeColor
                    : Colors.black,
                icon: FaIcon(
                  FontAwesomeIcons.folderOpen,
                ),
                label: 'Box',
                // backgroundColor: Colors.yellow
              ),
              BottomNavigationBarItem(
                backgroundColor: prov.darkTheme == false
                    ? AppColors.appThemeColor
                    : Colors.black,
                // icon: Icon(Icons.person),
                icon: const FaIcon(
                  Icons.search,
                ),
                label: 'Search',
                // backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                backgroundColor: prov.darkTheme == false
                    ? AppColors.appThemeColor
                    : Colors.black,
                icon: const FaIcon(
                  Icons.settings,
                ),
                label: 'Settings',
                // backgroundColor: Colors.blue,
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            unselectedItemColor:
                status == false ? AppColors.unselect : Colors.grey,
            selectedItemColor:
                status == false ? AppColors.textDarkColor : Colors.white,
            iconSize: 30,
            onTap: _onItemTapped,
            elevation: 5),
      );
    });
  }
}
