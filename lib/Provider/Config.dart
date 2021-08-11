import 'package:shared_preferences/shared_preferences.dart';

class Config{
  static String base_url="https://mas.doctor/api/v1";
  static var Header={};
  static var HeaderWithTocken={};
 static Future<Map<String,String>>getHeader()async{
   SharedPreferences pref=await SharedPreferences.getInstance();
   var header={ "Authorization":"Bearer "+pref.getString("token")!};
   return header;
 }
}
