import 'dart:core';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DoctorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DoctorProvider(), child: Doctorspage2());
  }
}

class Doctorspage2 extends StatefulWidget {

  @override
  _Doctorspage2State createState() => _Doctorspage2State();
}

class _Doctorspage2State extends State<Doctorspage2> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    //  var doctorSpeialistProvider=    Provider.of<DoctorSpeialistProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(locale.cardio!),
          textTheme: Theme
              .of(context)
              .textTheme,
          actions: [
            Stack(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.sort),
                      color: Theme
                          .of(context)
                          .disabledColor,
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.sortFilterPage);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.map),
                      color: Theme
                          .of(context)
                          .disabledColor,
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutes.doctorMapView);
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        body: DoctorsList());
  }
}

class DoctorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DoctorsListScreen();
  }
}

class DoctorsListScreen extends StatefulWidget {
  @override
  _DoctorsListScreenState createState() => _DoctorsListScreenState();
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

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctorSpecialist();
  }

  Future<void> getDoctorSpecialist() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<DoctorProvider>(context, listen: false)
        .getDoctorBySpecialist(4);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var doctorSpeialistProvider = Provider.of<DoctorProvider>(
        context, listen: true);
    print(doctorSpeialistProvider.doctors.length);
    print("lengthtttttttttttttttttttttttttttttttttttttttttttttt");
    List<SearchDoctorTile> searchList = [
      SearchDoctorTile(
          'assets/Doctors/doc1.png',
          'Dr. Joseph Williamson',
          'Cardiac Surgeon',
          'Apple Hospital',
          '22',
          '30',
          '152'),
      SearchDoctorTile(
          'assets/Doctors/doc2.png',
          'Dr. Anglina Taylor',
          'Cardiac Surgeon',
          'Operum Clinics',
          '22',
          '30',
          '201'),
      SearchDoctorTile(
          'assets/Doctors/doc3.png',
          'Dr. Anthony Peterson',
          'Cardiac Surgeon',
          'Opus Hospital',
          '22',
          '30',
          '135'),
      SearchDoctorTile(
          'assets/Doctors/doc4.png',
          'Dr. Elina George',
          'Cardiac Surgeon',
          'Lismuth Hospital',
          '22',
          '30',
          '438'),
      SearchDoctorTile(
          'assets/Doctors/doc1.png',
          'Dr. Joseph Williamson',
          'Cardiac Surgeon',
          'Apple Hospital',
          '22',
          '30',
          '152'),
      SearchDoctorTile(
          'assets/Doctors/doc2.png',
          'Dr. Anglina Taylor',
          'Cardiac Surgeon',
          'Operum Clinics',
          '22',
          '30',
          '201'),
      SearchDoctorTile(
          'assets/Doctors/doc3.png',
          'Dr. Anthony Peterson',
          'Cardiac Surgeon',
          'Opus Hospital',
          '22',
          '30',
          '135'),
      SearchDoctorTile(
          'assets/Doctors/doc4.png',
          'Dr. Elina George',
          'Cardiac Surgeon',
          'Lismuth Hospital',
          '22',
          '30',
          '438'),
    ];
    return Scaffold(
      body: isLoading ? Center(
        child: CircularProgressIndicator.adaptive(),) : doctorSpeialistProvider
          .doctors.isEmpty ? Center(
        child: Text('No Data'),
      ) : FadedSlideAnimation(
        Container(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Divider(
                thickness: 6,
                height: 6,
                color: Theme
                    .of(context)
                    .backgroundColor,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doctorSpeialistProvider.doctors.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 18.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageRoutes.doctorInfo);
                          },
                          child: Row(
                            children: [
                              FadedScaleAnimation(
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Image.network(
                                    doctorSpeialistProvider.doctors[index].user
                                        .image =="" ? Config.doctor_defualt_image
                                        : doctorSpeialistProvider.doctors[index]
                                        .user.image,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .15,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .2,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                durationInMilliseconds: 400,
                              ),
                              SizedBox(width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .015,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .7,
                                    child: Text(
                                        doctorSpeialistProvider.doctors[index]
                                            .user.name,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .7,
                                    child: Text(doctorSpeialistProvider
                                        .SelectedSpecialist,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          color: Theme
                                              .of(context)
                                              .disabledColor,
                                          fontSize: 12),),
                                  ),
                                  /*    Container(
                                    width: MediaQuery.of(context).size.width*.7,

                                    child: RichText(
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
                                            text: searchList[index].speciality,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12),
                                          ),
                                          TextSpan(
                                            text: locale!.at,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    color: kButtonTextColor,
                                                    fontSize: 10),
                                          ),
                                          TextSpan(
                                            text: searchList[index].hospital,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12),
                                          ),
                                        ])),
                                  ),*/
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        locale!.exp!,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                            color: Theme
                                                .of(context)
                                                .disabledColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        doctorSpeialistProvider.doctors[index]
                                            .exprience +
                                            locale.years!,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .025,
                                      ),
                                      Text(
                                        locale.fee!,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                            color: Theme
                                                .of(context)
                                                .disabledColor,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '\$' + doctorSpeialistProvider
                                            .doctors[index].fees.toString(),
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .025,
                                      ),
                                      RatingBar.builder(
                                          itemSize: 12,
                                          initialRating: 4,
                                          direction: Axis.horizontal,
                                          itemCount: doctorSpeialistProvider
                                              .doctors[index].reviewsAvgRate.round(),
                                          itemBuilder: (context, _) =>
                                              Icon(
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
                                        '(${doctorSpeialistProvider
                                            .doctors[index].reviewsCount})',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                            fontSize: 10,
                                            color: Theme
                                                .of(context)
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
                        color: Theme
                            .of(context)
                            .backgroundColor,
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
                },
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
