import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:provider/provider.dart';
class AppointmentPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DoctorProvider(), child: AppointmentScreen());
  }
}

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class Appointments {
  String image;
  String name;
  String speciality;
  String hospital;
  String date;
  String time;
  String? reviews;

  Appointments(this.image, this.name, this.speciality, this.hospital, this.date,
      this.time);
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool loading=true;
  loadData() async {
   await  Provider.of<DoctorProvider>(context, listen: false).getMyAppointMent();
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    final doctorProvider= Provider.of<DoctorProvider>(context, listen: true);
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FadedScaleAnimation(
          Text(
            locale.myAppointments!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
          ),
          durationInMilliseconds: 400,
        ),
        centerTitle: true,
      ),
      body:loading?Center(child: CircularProgressIndicator.adaptive(),): Container(
        child: ListView(
          //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 10),
              color: Theme.of(context).backgroundColor,
              height: 50,
              child: Text(locale.upcoming!,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 20, color: Theme.of(context).disabledColor)),
            ),
            Divider(
              thickness: 6,
              height: 6,
              color: Theme.of(context).backgroundColor,
            ),
            doctorProvider.myAppointment.commingAppointments.length==0?Container(
                height: 100,
                child: Center(child: Text("No Upcommint Appointment",style: Theme.of(context).textTheme.subtitle1,),)):
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorProvider.myAppointment.commingAppointments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageRoutes.appointmentDetail);
                            },
                            child: Row(
                              children: [
                                FadedScaleAnimation(
                                  Image.network(
                                    doctorProvider.myAppointment.commingAppointments[index].doctor.user.image==null?Config.doctor_defualt_image:doctorProvider.myAppointment.commingAppointments[index].doctor.user.image,
                                    width: MediaQuery.of(context).size.width*.25,
                                    height: MediaQuery.of(context).size.height*.17,
                                    fit: BoxFit.fill,
                                  ),
                                  durationInMilliseconds: 400,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      doctorProvider.myAppointment.commingAppointments[index].doctor.user.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(height: 1.5, fontSize: 16),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.65,
                                      child: Text( doctorProvider.myAppointment.commingAppointments[index].doctor.bio,   style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          color: Theme.of(context)
                                              .disabledColor,
                                          fontSize: 12,
                                          height: 1.5),),
                                    ),
                                  /*  RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            children: <TextSpan>[
                                          TextSpan(
                                            text: doctorProvider.myAppointment.commingAppointments[index].doctor.bio,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12,
                                                    height: 1.5),
                                          ),
                                    *//*      TextSpan(
                                            text: locale.at,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    color: kButtonTextColor,
                                                    fontSize: 10,
                                                    height: 1.5),
                                          ),
                                          TextSpan(
                                            text: upcomingAppointments[index]
                                                .hospital,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12,
                                                    height: 1.5),
                                          ),*//*
                                        ])),*/
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          doctorProvider.myAppointment.commingAppointments[index].date.toString().substring(0,10) +
                                              ' | ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 13),
                                        ),
                                        Text(
                                          doctorProvider.myAppointment.commingAppointments[index].time.toString().substring(0,5),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        PositionedDirectional(
                          top: 0,
                          end: -5,
                          child: IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                size: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {}),
                        ),
                        PositionedDirectional(
                            bottom: 7,
                            end: 5,
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(width: 13,),
                                InkWell(
                                  child: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ))
                      ],
                    ),
                    Divider(
                      height: 6,
                      thickness: 6,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ],
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 15, left: 10),
              color: Theme.of(context).backgroundColor,
              height: 50,
              child: Text(locale.past!,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 20, color: Theme.of(context).disabledColor)),
            ),
            doctorProvider.myAppointment.pastAppointments.length==0?Container(
                height: 100,
                child: Center(child: Text("No Past Appointment",style: Theme.of(context).textTheme.subtitle1,),)):ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorProvider.myAppointment.pastAppointments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, left: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PageRoutes.appointmentDetail);
                            },
                            child: Row(
                              children: [
                                FadedScaleAnimation(
                                  Image.network(
                                    doctorProvider.myAppointment.pastAppointments[index].doctor.user.image==null?Config.doctor_defualt_image:doctorProvider.myAppointment.commingAppointments[index].doctor.user.image,
                                    width: MediaQuery.of(context).size.width*.25,
                                    height: MediaQuery.of(context).size.height*.17,
                                    fit: BoxFit.fill,
                                  ),
                                  durationInMilliseconds: 400,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      doctorProvider.myAppointment.pastAppointments[index].doctor.user.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(height: 1.5, fontSize: 16),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*.65,
                                      child: Text( doctorProvider.myAppointment.commingAppointments[index].doctor.bio,   style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                          color: Theme.of(context)
                                              .disabledColor,
                                          fontSize: 12,
                                          height: 1.5),),
                                    ),
                               /*     RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            children: <TextSpan>[
                                          TextSpan(
                                            text: pastAppointments[index]
                                                .speciality,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12,
                                                    height: 1.5),
                                          ),
                                          TextSpan(
                                            text: locale.at,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    color: kButtonTextColor,
                                                    fontSize: 10,
                                                    height: 1.5),
                                          ),
                                          TextSpan(
                                            text: pastAppointments[index]
                                                .hospital,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 12,
                                                    height: 1.5),
                                          ),
                                        ])),*/
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          doctorProvider.myAppointment.commingAppointments[index].date.toString().substring(0,11) + ' | ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 13),
                                        ),
                                        Text(
                                          doctorProvider.myAppointment.commingAppointments[index].time.toString().substring(0,5),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        PositionedDirectional(
                            bottom: 7,
                            end: 5,
                            child: Row(
                              children: [
                                InkWell(
                                  child: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(width: 13,),
                                InkWell(
                                  child: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            )),
                      ],
                    ),
                    Divider(
                      height: 6,
                      thickness: 6,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
