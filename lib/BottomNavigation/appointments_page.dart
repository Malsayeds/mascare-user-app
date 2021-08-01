import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:doctoworld_user/Locale/locale.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
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

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<Appointments> upcomingAppointments = [
      Appointments('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '12 June 2020', '12:00 pm'),
      Appointments('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '14 June 2020', '2:30 pm'),
    ];
    List<Appointments> pastAppointments = [
      Appointments('assets/Doctors/doc3.png', 'Dr. Anthony Peterson',
          'Cardiac Surgeon', 'Opus Hospital', '28 May 2020', '3:00 pm'),
      Appointments('assets/Doctors/doc4.png', 'Dr. Elina George',
          'Cardiac Surgeon', 'Lismuth Hospital', '11 May 2020', '2:30 pm'),
      Appointments('assets/Doctors/doc1.png', 'Dr. Joseph Williamson',
          'Cardiac Surgeon', 'Apple Hospital', '26 April 2020', '10:00 am'),
      Appointments('assets/Doctors/doc2.png', 'Dr. Anglina Taylor',
          'Cardiac Surgeon', 'Operum Clinics', '22 April 2020', '11:00 am'),
    ];
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
      body: Container(
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: upcomingAppointments.length,
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
                                  Image.asset(
                                    upcomingAppointments[index].image,
                                    scale: 2.5,
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
                                      upcomingAppointments[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(height: 1.5, fontSize: 16),
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            children: <TextSpan>[
                                          TextSpan(
                                            text: upcomingAppointments[index]
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
                                          ),
                                        ])),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          upcomingAppointments[index].date +
                                              ' | ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 13),
                                        ),
                                        Text(
                                          upcomingAppointments[index].time,
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
                            bottom: 0,
                            end: 0,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //     context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(
                                  width: 18,
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: pastAppointments.length,
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
                                  Image.asset(
                                    pastAppointments[index].image,
                                    scale: 2.5,
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
                                      pastAppointments[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(height: 1.5, fontSize: 16),
                                    ),
                                    RichText(
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
                                        ])),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          pastAppointments[index].date + ' | ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 13),
                                        ),
                                        Text(
                                          pastAppointments[index].time,
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
                            bottom: 0,
                            end: 0,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //     context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.message,
                                    color: Theme.of(context).primaryColor,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, PageRoutes.doctorChat);
                                  },
                                ),
                                SizedBox(
                                  width: 18,
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
          ],
        ),
      ),
    );
  }
}
