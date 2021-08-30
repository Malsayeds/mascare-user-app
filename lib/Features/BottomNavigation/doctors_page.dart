import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctoworld_user/Features/Components/CustomAddressAppBar.dart';
import 'package:doctoworld_user/Features/Components/CustomCartIcon.dart';
import 'package:doctoworld_user/Features/PublicFunction.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'Data/data.dart';
class DoctorsHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  DoctorScreesn();
  }
}

class DoctorScreesn extends StatefulWidget {
  @override
  _DoctorScreesnState createState() => _DoctorScreesnState();
}

class _DoctorScreesnState extends State<DoctorScreesn> {
  bool loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  loadData()async{
  await  Provider.of<DoctorProvider>(context, listen: false).getDoctorAdds();
  setState(() {
    loading=false;
  });
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorSpeialistProvider=    Provider.of<DoctorProvider>(context, listen: true);
    String? value = 'Wallington';

    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
          title: CustomAddressAppBar()
          /*DropdownButton(
            value: value,
            iconSize: 0.0,
            // style: inputTextStyle.copyWith(
            //     fontWeight: FontWeight.bold,
            //     color: Theme.of(context).secondaryHeaderColor),
            underline: Container(
              height: 0,
            ),
            onChanged: (String? newValue) {
              setState(() {
                value = newValue;
              });
              // if (value == 'appLocalization.setLocation')
              //   Navigator.pushNamed(context, PageRoutes.locationPage);
            },
            items: <String?>[
              'Wallington',
              locale.office,
              locale.other,
              locale.setLocation
            ].map<DropdownMenuItem<String>>((address) {
              return DropdownMenuItem<String>(
                value: address,
                child: Text(
                  address!,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          )*/,
          actions: <Widget>[
            CustomCartIcon()
          ],
        ),
        body:loading?Center(child: CircularProgressIndicator(),) :DoctorsBody());
  }
}

class DoctorsBody extends StatefulWidget {
  @override
  _DoctorsBodyState createState() => _DoctorsBodyState();
}

class _DoctorsBodyState extends State<DoctorsBody> {
  bool clinicLoading=false;
  bool homeloading=false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorProvider=    Provider.of<DoctorProvider>(context, listen: true);
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text(
              locale.hello! + ', ${Docto.username}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
       /*   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FadedScaleAnimation(
              Text(
                locale.findDoctors!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              durationInMilliseconds: 400,
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: TextFormField(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.searchDoctors);
              },
              readOnly: true,
              decoration: InputDecoration(
                  hintText: locale.searchDoctors,
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none)),
            ),
          ),
          /*Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              children: [
                Text(
                  locale.findBySpecialities!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async{
                    await getDoctorSpecialist(0);
                    Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);
                  },
                  child: Text(
                    locale.viewAll!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),*/
          /*Container(
            height: 123.3,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctorProvider.doctorSpeiaList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                      doctorProvider.SetSelectedSpecialist(doctorProvider.doctorSpeiaList[index].id,doctorProvider.doctorSpeiaList[index].name);
                      await getDoctorSpecialist(doctorProvider.doctorSpeiaList[index].id);
                       Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);

                    },
                    child: Row(
                      children: [
                        Container(
                         // padding: EdgeInsets.only(left: 10),
                          height: 123.3,
                          width: MediaQuery.of(context).size.width*.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).primaryColor,
                              image: doctorProvider.doctorSpeiaList[index].media.length>0?
                              DecorationImage(
                                  image: NetworkImage(doctorProvider.doctorSpeiaList[index].media[0].url),
                                  fit: BoxFit.contain):
                              DecorationImage(
                                  image: NetworkImage(Config.doctor_defualt_image),
                                  fit: BoxFit.contain)
                          ),
                          child: FadedScaleAnimation(
                            Column(
                              children: [
                                SizedBox(height: 15,),
                                Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    alignment: Alignment.center,
                                    child: Text(doctorProvider.doctorSpeiaList[index].name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),)),
                              ],
                            ),
                            durationInMilliseconds: 300,
                          ),
                        ),
                        SizedBox(width: 10,)
                      ],
                    ),
                  );
                }),
          ),*/
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, PageRoutes.offers);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.27,
                    height: MediaQuery.of(context).size.height*.13,
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
                            child: Image.network(Config.offerIcon,
                              width: MediaQuery.of(context).size.width*.2,
                              height: MediaQuery.of(context).size.height*.08,
                              fit: BoxFit.cover,))),
                        SizedBox(height: 3,),
                        Text(locale.offers!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                   Navigator.pushNamed(context, PageRoutes.findMedicinesPage);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.27,
                    height: MediaQuery.of(context).size.height*.13,
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
                            child: Image.asset('assets/FooterIcons/ic_medicineact.png',
                              width: MediaQuery.of(context).size.width*.2,
                              height: MediaQuery.of(context).size.height*.08,
                              fit: BoxFit.cover,))),
                        SizedBox(height: 3,),
                        Text(locale.medicine!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                    setState(() {
                      clinicLoading=true;
                    });
                    await  doctorProvider.getDoctorSpecialist(0);
                    doctorProvider.type=0;
                    Navigator.pushNamed(context, "specification");
                    setState(() {
                      clinicLoading=false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.27,
                    height: MediaQuery.of(context).size.height*.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:clinicLoading?Colors.black12: Colors.white,
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
                            child: Image.network(Config.doctor_defualt_image,
                              width: MediaQuery.of(context).size.width*.2,
                              height: MediaQuery.of(context).size.height*.08,
                              fit: BoxFit.cover,))),
                        SizedBox(height: 3,),
                        Text("Clinic Care",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    // Navigator.pushNamed(context, "listOffers");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.27,
                    height: MediaQuery.of(context).size.height*.13,
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
                            child: Image.network(Config.test,
                              width: MediaQuery.of(context).size.width*.2,
                              height: MediaQuery.of(context).size.height*.08,
                              fit: BoxFit.cover,))),
                        SizedBox(height: 3,),
                        Text("Medical tests",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    //Navigator.pushNamed(context, "listOffers");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.27,
                    height: MediaQuery.of(context).size.height*.13,
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
                            child: Image.network(Config.exmination,
                              width: MediaQuery.of(context).size.width*.2,
                              height: MediaQuery.of(context).size.height*.08,
                              fit: BoxFit.cover,))),
                        SizedBox(height: 3,),
                        Text("Examination",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                    setState(() {
                      homeloading=true;
                    });
                    await  doctorProvider.getDoctorSpecialist(1);
                    doctorProvider.type=1;
                    Navigator.pushNamed(context, "specification");
                    setState(() {
                      homeloading=false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*.27,
                    height: MediaQuery.of(context).size.height*.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: homeloading?Colors.black12:Colors.white,
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
                            child: Image.network(Config.home_care,
                              width: MediaQuery.of(context).size.width*.2,
                              height: MediaQuery.of(context).size.height*.08,
                              fit: BoxFit.cover,))),
                        SizedBox(height: 3,),
                        Text("Home Care",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ////////////////////////////////////////////////////
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
              locale.sponsorAd!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ),
          Container(
            height: 110,
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctorProvider.addsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      PublicFunction.launchURL(doctorProvider.addsList[index].link);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: FadedScaleAnimation(
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            doctorProvider.addsList[index].image,
                            width: 250,
                            fit: BoxFit.fill,
                          ),
                        ),
                        durationInMilliseconds: 300,
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
             "Last Offers ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ),
  /*        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: doctorProvider.doctorSpeiaList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      doctorProvider.doctorSpeiaList[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Theme.of(context).disabledColor,
                    ),
                  ],
                ),
              );
              *//*ListTile(
                contentPadding: EdgeInsets.symmetric(),
                title: Text('Addiction psychiatrist'),
                trailing: Icon(Icons.arrow_forward_ios, size: 15,),
              );*//*
            },
          ),*/
          ListView.builder(
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
              })
        ],
      ),
    );
  }
  Future<void> getDoctorSpecialist(int id) async {
    await Provider.of<DoctorProvider>(context, listen: false)
        .getDoctorBySpecialist(id);
  }
}
