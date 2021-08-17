import 'package:url_launcher/url_launcher.dart';
class PublicFunction{

 static void launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
 static Future<void> makingPhoneCall(var number) async {
   var url = 'tel:$number';
   if (await canLaunch(url)) {
     await launch(url);
   } else {
     throw 'Could not launch $url';
   }
 }

}