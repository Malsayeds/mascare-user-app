import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctoworld_user/Features/Components/CustomAddressAppBar.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Offers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _state();
  }
}
class _state extends State<Offers>{
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
     return Scaffold(
       appBar: AppBar(
           leading: Icon(
             Icons.location_on,
             color: Theme.of(context).primaryColor,
           ),
           title:CustomAddressAppBar()
       ),
       body: ListView(
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
             child: TextFormField(
               onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalSearchScreen()));
               },
               readOnly: true,
               decoration: InputDecoration(
                   hintText: locale.viewOffers,
                   prefixIcon: Icon(Icons.search),
                   filled: true,
                   fillColor: Theme.of(context).backgroundColor,
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(8),
                       borderSide: BorderSide.none)),
             ),
           ),
           Container(
             height: MediaQuery.of(context).size.height * .18,
             width: MediaQuery.of(context).size.width * .9,
             color: Colors.white,
             child: CarouselSlider.builder(
               itemCount: 15,
               itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                   Container(
                       height: MediaQuery.of(context).size.height * .18,
                       width: MediaQuery.of(context).size.width * .9,
                       child: Image.network("https://mortjnlt5153.weebly.com/uploads/5/6/8/3/56839853/4013269_orig.jpeg"),
                   ), options: CarouselOptions(
               autoPlay: true,
               autoPlayAnimationDuration: Duration(milliseconds: 300),
               enlargeCenterPage: true,
               viewportFraction: 0.9,
               aspectRatio: 2.0,
               initialPage: 2,
             ),
             ),
           ),
           SizedBox(height: 10,),
           Container(
             width: MediaQuery.of(context).size.width,
             child: GridView.builder(
               padding: EdgeInsets.only(
                   left: MediaQuery.of(context).size.width * .03,
                   right: MediaQuery.of(context).size.width * .03,
                   bottom: 20),
               primary: false,
               shrinkWrap: true,
               itemCount: 8,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 4,
                   mainAxisSpacing: 10,
                   crossAxisSpacing: 10,
                   childAspectRatio: 1 / 1.1),
               itemBuilder: (context, index) {
                 return Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                     color: Colors.white,
                     boxShadow:[
                       BoxShadow(
                       color: Colors.grey.withOpacity(0.1), //color of shadow
                       spreadRadius: 1, //spread radius
                       blurRadius: 1, // blur radius
                       offset: Offset(2, 2), // changes position of shadow
                     ),
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.1), //color of shadow
                         spreadRadius: 1, //spread radius
                         blurRadius: 1, // blur radius
                         offset: Offset(-2, -2), // changes position of shadow
                       ),
                     ],
                   ),
                   padding: EdgeInsets.all(2),
                   child: Column(
                     children: [
                       Expanded(child: ClipRRect(
                           borderRadius: BorderRadius.all(Radius.circular(10)),
                           child: Image.network("https://pbs.twimg.com/media/ETP7yvbXQAIRe7q.jpg",fit: BoxFit.cover,))),
                       Text("ليزك",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                     ],
                   ),
                 );
               },
             ),
           ),
           Container(
               padding: EdgeInsets.only(
                 left: MediaQuery.of(context).size.width*.05,
                 right: MediaQuery.of(context).size.width*.05
               ),
               child: Row(
                 children: [
                   Text("More Seller",style: Theme.of(context).textTheme.subtitle1,)
                 ],
               )
           ),
           SizedBox(height: 10,),
           ListView.builder(
             padding: EdgeInsets.only(
               bottom: 20,
             ),
           itemCount: 1,
           shrinkWrap: true,
           primary: false,
           itemBuilder: (context,index){
             return Container(
               child: Column(
                 children: [
                   Container(
                     height: MediaQuery.of(context).size.height * .15,
                     width: MediaQuery.of(context).size.width ,
                     color: Colors.white,
                     child: CarouselSlider.builder(
                       itemCount: 15,
                       itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                           Container(
                             child: Image.network("https://i.ytimg.com/vi/X7qdgjBDwnk/maxresdefault.jpg",
                               height: MediaQuery.of(context).size.height * .15,
                               width: MediaQuery.of(context).size.width ,
                               fit: BoxFit.cover,
                             ),
                           ),
                       carouselController: CarouselController(),
                       options: CarouselOptions(
                       autoPlay: false,
                       enlargeCenterPage: true,
                       viewportFraction: 0.9,
                       aspectRatio: 2.0,
                       initialPage: 2,
                     ),
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width,
                     padding: EdgeInsets.only(
                       left: MediaQuery.of(context).size.width*.05,
                       right: MediaQuery.of(context).size.width*.05,
                       top: 5
                     ),
                     child: Column(
                       children: [
                         Row(children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(1000),
                             child: Image.network(Config.doctor_defualt_image,
                               height: 40,width: 40,fit: BoxFit.cover,
                             ),
                           )
                         ],)
                       ],
                     ),
                   )

                 ],
               ),
             );
           })
         ],
       ),
     );
  }
}