import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCartIcon extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _state();
  }
}
class _state extends State<CustomCartIcon>{
var  globalProvider=GlobalProvider();
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<GlobalProvider>(context,listen: false).getCounter();
   return   Stack(
       children: [
         IconButton(
           icon: Icon(Icons.shopping_cart),
           onPressed: () {
             Navigator.pushNamed(context, PageRoutes.myCartPage);
           },
         ),
         Positioned.directional(
           textDirection: Directionality.of(context),
           top: 4,
           end: 10,
           child: CircleAvatar(
             backgroundColor: Colors.red,
             radius: 7,
             child: Center(
                 child:  Text(
                       counter.toString(),
                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
                           color: Theme.of(context).scaffoldBackgroundColor,
                           fontSize: 9,fontWeight: FontWeight.bold),
                     ),
                              ),
           ),
         )
       ],
     );
  }
}
