import 'dart:ui';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class BookAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DoctorProvider(), child: BookAppointmentScreen());
  }
}

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  TextEditingController noteController=new TextEditingController();
  bool loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDoctorInfo();
    getDays();

  }
  Future<void>loadDoctorInfo()async{
    var doctorProvider=Provider.of<DoctorProvider>(context, listen: false);
    await doctorProvider.addavailable(1, DateFormat('yyyy-MM-dd').format(DateTime.now()));
    await  Provider.of<DoctorProvider>(context, listen: false).getDoctInfo(1);
    if(doctorProvider.times.availableTimes.length>0);
    {
      setState(() {
        SelectedTime=doctorProvider.times.availableTimes[0];
      });
    }
    setState(() {
      loading=false;
    });

  }
   List<daysModel> days=[];
  String month="";
  String year="";
 late String SelectedTime;
 late String SelectedDate;
  getDays(){
   for(int i=0;i<31-DateTime.now().day;i++){
     var date = DateTime.now().add(Duration(days: i));
     daysModel d=new daysModel(date: DateFormat('d').format(date), day: DateFormat('EEEE').format(date),apiDate: DateFormat('yyyy-MM-dd').format(date));
     days.add(d);
   }
   setState(() {
     month=DateFormat('MMM').format(DateTime.now());
     SelectedDate=DateFormat('yyyy-MM-dd').format(DateTime.now());
     year=DateTime.now().year.toString();
   });
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorProvider= Provider.of<DoctorProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.selectDateAndTime!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          //onPressed: Navigator.pop(),
        ),
      ),
      body: loading?Center(child: CircularProgressIndicator.adaptive(),):FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 5),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: FadedScaleAnimation(
                            Image.network(
                              doctorProvider.doctorInfo.singleDoctor.user.image==null?Config.doctor_defualt_image:doctorProvider.doctorInfo.singleDoctor.user.image,
                              width: MediaQuery.of(context).size.width*.5,
                            ),
                            durationInMilliseconds: 400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 22),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.subtitle2,
                              children: [
                                TextSpan(
                                    text: '${doctorProvider.doctorInfo.singleDoctor.user.name}\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            height: 1.4)),
                                TextSpan(
                                    text: '${doctorProvider.doctorInfo.singleDoctor.specifications[0].name} \n' /*+
                                        locale.at! +
                                        '${doctorProvider.doctorInfo.singleDoctor.about}',*/,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color:
                                                Theme.of(context).disabledColor,
                                            fontSize: 18,
                                            height: 1.6))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        locale.selectDate!,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 22),
                      ),
                      Spacer(flex: 1),
                      Text(
                        '${month} ${year}',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: kMainTextColor, fontSize: 22),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  Container(
                    height: 65,
                    margin: EdgeInsets.only(top: 15),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              doctorProvider.addavailable(1, days[index].apiDate);
                              setState(() {
                                SelectedDate=days[index].apiDate;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                                width: width / 8,
                                decoration: BoxDecoration(
                                  color: SelectedDate==days[index].apiDate?Theme.of(context).primaryColor:Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                     days[index].day.substring(0,3),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color:
                                              SelectedDate==days[index].apiDate?Colors.white: Theme.of(context).disabledColor,
                                              fontSize: 12,
                                              height: 2),
                                    ),
                                    Text(
                                      days[index].date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: kMainTextColor,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            height: 1.4,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.selectTime!,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  Container(
                    height: width / 8,
                    margin: EdgeInsets.only(top: 15),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: doctorProvider.times.availableTimes.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: (){
                              setState(() {
                                SelectedTime=doctorProvider.times.availableTimes[i];
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                                width: width / 3.5,
                                decoration: BoxDecoration(
                                  color:SelectedTime==doctorProvider.times.availableTimes[i]?Theme.of(context).primaryColor: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    doctorProvider.times.availableTimes[i].substring(0,5),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color:SelectedTime==doctorProvider.times.availableTimes[i]?Colors.white: kMainTextColor,
                                          fontSize: 23,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.appointmentFor!,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: noteController,
                    decoration: InputDecoration(
                        hintText: 'eg. Heart pain, Body ache, etc.',
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: ()async {
                 await  doctorProvider.addAppointMent("1", "10:30:00", "2021-08-16", "9", noteController.text);
                   if(doctorProvider.appointInfo["singleAppointment"]!=null)
                  Navigator.pushNamed(context, PageRoutes.appointmentBooked);
                   else
                     DialogMessages.ErrorMessage(context, "Un Available AppointMent");
                },
                label: locale.confirmAppointment,
                radius: 0,
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
class daysModel{
  final String date;
  final String day;
  String apiDate;
  daysModel({required this.date,required this.day,required this.apiDate});
}
