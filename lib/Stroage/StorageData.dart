import 'package:shared_preferences/shared_preferences.dart';

class StorageData{
  static Future<void>storeValue(String key,String value)async {
   SharedPreferences pref=await SharedPreferences.getInstance();
   pref.setString(key, value);
  }
  static Future<String?>getValue(String key)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getString(key);
  }


}