import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Features/PublicFunction.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/Hospitals/HospitalsModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Hospital/HospitalProvider.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
class Departments extends StatelessWidget {
  HospitalsModel hospitalsModel;
  Departments({required this.hospitalsModel});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HospitalProvider(), child: DepartmentScreeen(hospitalsModel: this.hospitalsModel,));
  }
}

class DepartmentScreeen extends StatefulWidget {
  HospitalsModel hospitalsModel;
  DepartmentScreeen({required this.hospitalsModel});
  @override
  _DepartmentScreeenState createState() => _DepartmentScreeenState(hospitalsModel: this.hospitalsModel);
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

class _DepartmentScreeenState extends State<DepartmentScreeen> {
  HospitalsModel hospitalsModel;
  _DepartmentScreeenState({required this.hospitalsModel});
int selectedId=-1;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var hospitalProvider=Provider.of<HospitalProvider>(context, listen: true);
    List<SearchDoctorTile> searchList = [
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
      SearchDoctorTile('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '22', '30', '152'),
      SearchDoctorTile('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22', '30', '201'),
      SearchDoctorTile('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '22', '30', '135'),
      SearchDoctorTile('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '22', '30', '438'),
    ];
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: hospitalsModel.specifications.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(
                      thickness: 4,
                      color: Theme.of(context).backgroundColor,
                    ),
                    ListTile(
                      onTap: () {
                        if( selectedId==hospitalsModel.specifications[index].id){
                          setState(() {
                            selectedId=-1;
                          });
                        }
                        else{
                          hospitalProvider.getDoctorBySpecificationId(hospitalsModel.specifications[index].id);
                          setState(() {
                            selectedId=hospitalsModel.specifications[index].id;
                          });
                        }
                      },
                      title: Text(
                        hospitalsModel.specifications[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      dense: true,
                    ),
                    selectedId==hospitalsModel.specifications[index].id?
                AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.only(top: 4),
                      child: Container(
                        child: ListView(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: hospitalProvider.doctorsList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 18.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          //Navigator.pushNamed(context, PageRoutes.doctorInfo);
                                        },
                                        child: Row(
                                          children: [
                                            Image.network(
                                              hospitalProvider.doctorsList[index].user.image==""?Config.doctor_defualt_image: hospitalProvider.doctorsList[index].user.image,
                                              height: 80,
                                              width: 80,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle2,
                                                        children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                          hospitalProvider.doctorsList[index].user
                                                                      .name +
                                                                  '\n',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1),
                                                /*      TextSpan(
                                                        text: "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                                fontSize: 12),
                                                      ),*/
                                                 /*     TextSpan(
                                                        text: locale.at,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                color:
                                                                    kButtonTextColor,
                                                                fontSize: 10),
                                                      ),
                                                      TextSpan(
                                                        text: searchList[index]
                                                            .hospital,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                                fontSize: 12),
                                                      ),*/
                                                    ])),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*.7,
                                                  child: Text(hospitalProvider.doctorsList[index].bio,maxLines: 2,style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                      color: Theme.of(
                                                          context)
                                                          .disabledColor,
                                                      fontSize: 12),),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      locale.exp!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor,
                                                              fontSize: 12),
                                                    ),
                                                    Text(
                                                      hospitalProvider.doctorsList[index].exprience +
                                                          locale.years!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontSize: 12),
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor,
                                                              fontSize: 12),
                                                    ),
                                                    Text(
                                                      '\$' +
                                                          hospitalProvider.doctorsList[index].fees,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    RatingBar.builder(
                                                        itemSize: 12,
                                                        initialRating: 4,
                                                        direction:
                                                            Axis.horizontal,
                                                        itemCount: hospitalProvider.doctorsList[index].reviewsAvgRate.round(),
                                                        itemBuilder: (context,
                                                                _) =>
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                        }),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      '(${hospitalProvider.doctorsList[index].reviewsCount})',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                              fontSize: 10,
                                                              color: Theme.of(
                                                                      context)
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
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ):SizedBox(),
                  ],
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              onTap: () {
                PublicFunction.makingPhoneCall(hospitalsModel.phone);
              },
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 16,
              ),
              label: locale.callNow,
              radius: 0,
            ),
          ),
        ],
      ),
    );
  }
}
