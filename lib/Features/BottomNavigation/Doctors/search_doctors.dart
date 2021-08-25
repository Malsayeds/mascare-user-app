import 'dart:core';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:provider/provider.dart';

class SearchDoctors extends StatefulWidget {
  @override
  _SearchDoctorsState createState() => _SearchDoctorsState();
}

class SearchDoctorTile {
  String image;
  String name;
  String speciality;
  String hospital;
  String experience;
  String fee;
  String reviews;

  SearchDoctorTile(this.image, this.name, this.speciality, this.hospital,
      this.experience, this.fee, this.reviews);
}

class _SearchDoctorsState extends State<SearchDoctors> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorProvider=Provider.of<DoctorProvider>(context, listen: true);
    return Scaffold(
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 14, right: 14),
              child: TextFormField(
                initialValue: '',
                onChanged: (val){
                  doctorProvider.seachDoctor(val);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none),
                    hintText: locale.searchDoc,
                    filled: true,
                    fillColor: Theme.of(context).backgroundColor,
                    prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PageRoutes.searchHistoryPage);
                      },
                    )),
              ),
            ),
            Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              margin: EdgeInsets.only(top: 15),
              child: Text(
                '${doctorProvider.searchDoctorList.length} ' + locale.resultsFound!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            doctorProvider.searchDoctorList.length==0?Container(
              height: 100,
              child: Center(child: Text("No Data",style: Theme.of(context).textTheme.subtitle1,),),
            )   :ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doctorProvider.searchDoctorList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageRoutes.doctorInfo);
                          },
                          child: Row(
                            children: [
                              FadedScaleAnimation(
                                Image.network(
                                  doctorProvider.searchDoctorList[index].user.image==""?Config.doctor_defualt_image:doctorProvider.searchDoctorList[index].user.image,
                                  height: MediaQuery.of(context).size.height*.15,
                                  width: MediaQuery.of(context).size.width*.21,
                                ),
                                durationInMilliseconds: 400,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width*.015,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*.75,
                                    child: Text(doctorProvider.searchDoctorList[index].user.name ,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*.75,
                                    child: Text(doctorProvider.searchDoctorList[index].bio,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          color: Theme.of(context)
                                              .disabledColor,
                                          fontSize: 12),),
                                  ),
                               /*   RichText(
                                      text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                          children: <TextSpan>[
                                        TextSpan(
                                            text: searchList[index].name + '\n',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1),
                                        TextSpan(
                                            text: searchList[index].speciality),
                                        TextSpan(text: locale.at),
                                        TextSpan(
                                            text: searchList[index].hospital),
                                      ])),*/
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        locale.exp!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .disabledColor,
                                                fontSize: 12),
                                      ),
                                      Text(
                                        doctorProvider.searchDoctorList[index].exprience +
                                            locale.years!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        locale.fee!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .disabledColor,
                                                fontSize: 12),
                                      ),
                                      Text(
                                        '\$' +  doctorProvider.searchDoctorList[index].fees,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*.02,
                                      ),
                                      RatingBar.builder(
                                          itemSize: 12,
                                          initialRating: doctorProvider.searchDoctorList[index].reviewsAvgRate,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          }),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '(${ doctorProvider.searchDoctorList[index].reviewsCount})',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .disabledColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 6,
                        thickness: 6,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ],
                  );

                  /*ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                leading: Image.asset('assets/Doctors/doc1.png', height: 100,),
                title: RichText( text: TextSpan(style: Theme.of(context).textTheme.subtitle2, children: <TextSpan>[
                  TextSpan(text: 'Dr. Joseph Williamson\n', style: Theme.of(context).textTheme.subtitle1),
                  TextSpan(text: 'Cardiac Surgeon'),
                  TextSpan(text: ' at '),
                  TextSpan(text: 'Apple Hospital'),
                ])),
                subtitle: Row(children: [
                  Text('Exp. '),
                  Text('22 years'),
                  Spacer(),
                  Text('Fees '),
                  Text('\$30'),
                  Spacer(flex: 2,),
                  RatingBar(
                    itemSize: 12,
                      initialRating: 4,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating){
                    print(rating);
                  })
                ],),
              );*/
                })
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
