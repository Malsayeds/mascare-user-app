import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctoworld_user/Features/Components/CustomAddressAppBar.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListOffers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<ListOffers>{
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
      body: Column(
        children: [
        //  SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16),
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
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                itemCount: 15,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context,index){
                  return Container(
                    //     width: MediaQuery.of(context).size.width*.9,
                    margin: EdgeInsets.only(bottom: 10),

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
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width*.05,
                            right: MediaQuery.of(context).size.width*.05,

                          ),
                          padding:EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 5,
                              right: 5
                          ) ,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                              border: Border.all(color: Colors.black12,width: 1)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Image.network(Config.doctor_defualt_image,
                                    height: 40,width: 40,fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text("Doctor Name"),
                                SizedBox(width: 5,),
                                Text("-"),
                                SizedBox(width: 5,),
                                Text("10 St Elabysia"),
                              ],),
                              SizedBox(height: 10,),
                              Text("Offers  Name Offers name",style: Theme.of(context).textTheme.subtitle1,),
                              SizedBox(height: 2,),
                              Text("Offers  Description Offers  Description Offers  Description",style: Theme.of(context).textTheme.bodyText2,),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  RatingBar.builder(
                                      itemSize: 15,
                                      initialRating: 4,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, _) =>
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      }),
                                  SizedBox(width: 10,),
                                  Text("(2)",style: Theme.of(context).textTheme.bodyText2,),
                                ],
                              ),
                              SizedBox(height: 2,),
                              Row(children: [
                                Text("1000",style: TextStyle(decoration: TextDecoration.lineThrough),),
                                SizedBox(width: 10,),
                                Text("800"),
                                Expanded(child: SizedBox(),),
                                Container(
                                  width: MediaQuery.of(context).size.width*.2,
                                  height: MediaQuery.of(context).size.height*.04,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: Theme.of(context).primaryColor
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("Book Now",style: TextStyle(fontSize: 12,fontWeight:FontWeight.bold,color: Colors.white),),
                                )
                              ],),
                              SizedBox(height: 2,),
                            ],
                          ),
                        )

                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}