import 'package:shared_preferences/shared_preferences.dart';

class Config{
  static String base_url="https://mas.doctor/api/v1";
  static String doctor_defualt_image="https://tse1.mm.bing.net/th?id=OIP.Al0cj60NO2uwHZoW3z0vrwHaJF&pid=Api&P=0&w=300&h=300";
 static String user_defualt_image="http://www.filecluster.com/howto/wp-content/uploads/2014/07/User-Default.jpg";
 static String company_logo="https://tse2.mm.bing.net/th?id=OIP.NaBOIeSbFmBd4AHl4puLCwHaH0&pid=Api&P=0&w=300&h=300";
 static String home_care="https://british-american.com/wp-content/uploads/2019/01/Home-fix-980x481-1-768x377.png";
 static String offerIcon="https://cdn0.iconfinder.com/data/icons/shopping-3-13/68/104-512.png";
 static String test="https://tse3.mm.bing.net/th?id=OIP.4uOhlK3mTqkdhnXtaNzQugHaGi&pid=Api&P=0&w=198&h=176";
 static String exmination="https://tse4.mm.bing.net/th?id=OIP.pUo0YR2pr6fJ4OnURqRoYAHaHa&pid=Api&P=0&w=300&h=300";
 static String no_image_found="https://tse2.mm.bing.net/th?id=OIP.hV6MoBaE8NYeMCugmhd7_QHaEo&pid=Api&P=0&w=255&h=160";
  static var Header={};
  static var HeaderWithTocken={};
 static Future<Map<String,String>>getHeader()async{
   SharedPreferences pref=await SharedPreferences.getInstance();
   var header={ "Authorization":"Bearer "+pref.getString("token")!};
   return header;
 }
  static Future<Map<String,String>>getHeaderWithjson()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    var header={
      "Content-Type":"application/json",
      "Authorization":"Bearer "+pref.getString("token")!
    };
    return header;
  }
}
