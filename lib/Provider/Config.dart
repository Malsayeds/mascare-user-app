import 'package:shared_preferences/shared_preferences.dart';

class Config{
  static String base_url="https://mas.doctor/api/v1";
  static String doctor_defualt_image="https://tse1.mm.bing.net/th?id=OIP.Al0cj60NO2uwHZoW3z0vrwHaJF&pid=Api&P=0&w=300&h=300";
  static var Header={};
  static var HeaderWithTocken={};
 static Future<Map<String,String>>getHeader()async{
   SharedPreferences pref=await SharedPreferences.getInstance();
   var header={ "Authorization":"Bearer "+pref.getString("token")!};
   return header;
 }
}
