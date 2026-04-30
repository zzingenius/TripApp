import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {

  SharedPrefsService._init();
  static final SharedPrefsService instance = SharedPrefsService._init();

  static SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async{
    if (_preferences != null) return _preferences!;
    _preferences = await SharedPreferences.getInstance();
    return _preferences!;
  }

  Future<void> save(List<String> history) async{
    final pref =  await preferences;
    await pref.setStringList('history', history);
  }

  Future<List<String>> loadHistory() async{
    final pref = await preferences;
    return pref.getStringList('history') ?? [];
  }
}