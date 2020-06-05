import 'package:shared_preferences/shared_preferences.dart';

enum CountdownFormat { duration, days, hours, minutes, seconds }

class AppSettings {
  CountdownFormat _countdownFormat = CountdownFormat.duration;

  CountdownFormat get countdownFormat => _countdownFormat;

  set countdownFormat(CountdownFormat value) {
    _countdownFormat = value;
    _saveCountdownFormat();
  }

  static const String _countdownFormatKey = 'CountdownFormat';

  /// Saves the countdown format to persistent storage.
  Future<void> _saveCountdownFormat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_countdownFormatKey, _countdownFormat.index);
  }

  /// Loads app settings from persistent storage.
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _countdownFormat = CountdownFormat.values[prefs.getInt(_countdownFormatKey) ?? 0];
  }
}
