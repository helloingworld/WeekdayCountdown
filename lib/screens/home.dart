// Copyright 2020 Appliberated. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:weekday_countdown/common/app_settings.dart';
import 'package:weekday_countdown/utils/utils.dart';
import 'package:weekday_countdown/widgets/app_drawer.dart';
import 'package:weekday_countdown/common/app_strings.dart';
import 'package:weekday_countdown/models/weekday.dart';
import 'package:weekday_countdown/widgets/countdown_display.dart';
import 'package:weekday_countdown/screens/settings_screen.dart';

/// Overflow menu items enumeration.
enum MenuAction { share }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// The AppBar's action needs this key to find its own Scaffold.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// The map of counters for each counter type.
//  final Counters _counters = Counters();
  Weekday selectedDay = Weekday.monday;

  /// The current app settings.
  final AppSettings _appSettings = AppSettings();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  /// Loads counter values from persistent storage.
  Future<void> _loadSettings() async {
//    await _counters.load();
    await _appSettings.load();
    setState(() {
      /* Refresh after loading counters. */
    });
  }

  /// Performs the tasks of the popup menu items (reset, share, rate, and help).
  void popupMenuSelection(MenuAction item) {
    switch (item) {
//      case MenuAction.reset:
//        break;
      case MenuAction.share:
        // Share the current counter value using the platform's share sheet.
//        final String name = _counters.current.name;
//        final String value = toDecimalString(context, _counters.current.value);
//        Share.share(AppStrings.shareText(name, value), subject: name);
        break;
    }
  }

  /// Select and display the specified counter when its drawer list tile is tapped.
  void _drawerTileSelected(Weekday day) {
    setState(() => selectedDay = day);
    Navigator.pop(context);
  }

  void _drawerExtraSelected(DrawerExtraActions item) {
    switch (item) {
      case DrawerExtraActions.settings:
        // Load the Settings screen
        _loadSettingsScreen();
        break;
      case DrawerExtraActions.help:
        // Launch the app online help url
        launchUrl(_scaffoldKey.currentState, AppStrings.helpURL);
        break;
      case DrawerExtraActions.rate:
        // Launch the Google Play Store page to allow the user to rate the app
        launchUrl(_scaffoldKey.currentState, AppStrings.rateAppURL);
        break;
    }
  }

  /// Navigates to the Settings screen, and refreshes on return.
  Future<void> _loadSettingsScreen() async {
    await Navigator.push<void>(context,
        MaterialPageRoute(builder: (context) => SettingsScreen(appSettings: _appSettings)));
    setState(() {
      /* Refresh after returning from Settings screen. */
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortrait = MediaQuery.of(context).size.height >= 500;

    final CountdownDisplay countdownDisplay = CountdownDisplay(
      countdown: Weekdays.countdownTo(selectedDay.index + 1),
      countdownFormat: _appSettings.countdownFormat,
      color: Weekdays.colorOf(selectedDay),
      isPortrait: isPortrait,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: countdownDisplay,
//      floatingActionButton: !(_appSettings.counterTapMode) ? _buildFABs(isPortrait) : null,
    );
  }

  /// Builds the app bar with the popup menu items.
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppStrings.appBarTitle(Weekdays.nameOf(selectedDay))),
      actions: <Widget>[
        PopupMenuButton<MenuAction>(
          onSelected: popupMenuSelection,
          itemBuilder: _buildMenuItems,
        ),
      ],
    );
  }

  /// Builds the popup menu items for the app bar.
  List<PopupMenuItem<MenuAction>> _buildMenuItems(BuildContext context) {
    return MenuAction.values
        .map(
          (item) => PopupMenuItem<MenuAction>(
            value: item,
            child: Text(AppStrings.menuActions[item]),
          ),
        )
        .toList();
  }

  /// Builds the main drawer that lets the user switch between color counters.
  Widget _buildDrawer() {
    return AppDrawer(
      selectedDay: selectedDay,
      title: AppStrings.drawerTitle,
      onSelected: _drawerTileSelected,
      onExtraSelected: _drawerExtraSelected,
    );
  }
}
