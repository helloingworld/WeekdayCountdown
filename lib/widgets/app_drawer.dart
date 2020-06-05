import 'package:flutter/material.dart';
import 'package:weekday_countdown/common/app_strings.dart';
import 'package:weekday_countdown/models/weekday.dart';

import 'color_list_tile.dart';

/// Drawer extra actions enumeration.
enum DrawerExtraActions { settings, help, rate }

class AppDrawer extends StatelessWidget {
  /// Creates an app drawer widget.
  const AppDrawer({
    Key key,
    @required this.title,
    @required this.selectedDay,
    this.onSelected,
    this.onExtraSelected,
  })  : assert(title != null),
        super(key: key);

  /// The title of the drawer displayed in the drawer header.
  final String title;

  /// The current counter type.
  final Weekday selectedDay;

  /// Called when the user taps a drawer list tile.
  final void Function(Weekday day) onSelected;

  /// Called when the user taps a drawer list tile.
  final void Function(DrawerExtraActions value) onExtraSelected;

  void _onExtraActionTap(BuildContext context, DrawerExtraActions action) {
    Navigator.pop(context);
    if (onExtraSelected != null) onExtraSelected(action);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        selectedColor: Colors.black,
        child: ListView(
          children: <Widget>[
            _buildDrawerHeader(context),
            ...Weekday.values.map((day) => _buildWeekdayTile(day)),
            Divider(),
            _buildExtraTile(context, DrawerExtraActions.settings),
            _buildExtraTile(context, DrawerExtraActions.help),
            _buildExtraTile(context, DrawerExtraActions.rate),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight + 8.0,
      child: DrawerHeader(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  Widget _buildWeekdayTile(Weekday day) {
    return ColorListTile(
      color: Weekdays.colorOf(day),
      title: Weekdays.nameOf(day),
      selected: selectedDay == day,
      onTap: () => onSelected?.call(day),
    );
  }

  Widget _buildExtraTile(BuildContext context, DrawerExtraActions action) {
    const Map<DrawerExtraActions, IconData> drawerExtraIcons = {
      DrawerExtraActions.settings: Icons.settings,
      DrawerExtraActions.help: Icons.help_outline,
      DrawerExtraActions.rate: Icons.rate_review,
    };

    return ListTile(
      leading: Icon(drawerExtraIcons[action]),
      title: Text(AppStrings.drawerExtraTitles[action]),
      onTap: () => _onExtraActionTap(context, action),
    );
  }
}
