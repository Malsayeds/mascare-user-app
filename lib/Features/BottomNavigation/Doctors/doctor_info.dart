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
import 'package:provider/provider.dart';
class DoctorInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DoctorProvider(), child: DoctorInfoScreen());
  }
}

class DoctorInfoScreen extends StatefulWidget {
  @override
  _DoctorInfoScreenState createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  bool loading =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDoctorInfo();

  }
  Future<void>loadDoctorInfo()async{
  await  Provider.of<DoctorProvider>(context, listen: false).getDoctInfo(1);
  setState(() {
    loading=false;
  });
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorProvider=Provider.of<DoctorProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: ()async {
                 await  doctorProvider.addItemToWishlist(doctorProvider.doctorInfo.singleDoctor.id);
                 if(doctorProvider.addToWishlist==200){
                   DialogMessages.SuccessMessage(context, "This Docter Added To Wishlist");
                 }else{
                   DialogMessages.ErrorMessage(context, "This Docter Has Been Added Before To Wishlist");
                 }
                },
                icon: Icon(Icons.bookmark_outline_outlined),
              )
            ],
          )
        ],
      ),
      body:loading?Center(child: CircularProgressIndicator.adaptive(),): FadedSlideAnimation(
        Stack(
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: FadedScaleAnimation(
                                Image.network(
                                  doctorProvider.doctorInfo.singleDoctor.user.image==null?Config.doctor_defualt_image:doctorProvider.doctorInfo.singleDoctor.user.image,
                                  width: MediaQuery.of(context).size.width*.5,
                                ),
                                durationInMilliseconds: 400,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 45,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      children: [
                                        TextSpan(
                                            text: locale.experience,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize: 13,
                                                )),
                                        TextSpan(
                                            text: doctorProvider.doctorInfo.singleDoctor.experience + locale.years!,
                                            style: TextStyle(height: 1.4))
                                      ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      children: [
                                        TextSpan(
                                            text: locale.consulFees,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                    fontSize: 13)),
                                        TextSpan(
                                            text: '\$${doctorProvider.doctorInfo.singleDoctor.fees}',
                                            style: TextStyle(height: 1.4))
                                      ]),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    children: [
                                      TextSpan(
                                          text: '${doctorProvider.doctorInfo.singleDoctor.user.name}\n\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(fontSize: 26)),
                                      TextSpan(
                                          text: "${doctorProvider.doctorInfo.singleDoctor.specifications[0].name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize: 13))
                                    ]),
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    locale.feedback!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color:
                                                Theme.of(context).disabledColor,
                                            fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PageRoutes.doctorReviewPage);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: starColor,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          doctorProvider.doctorInfo.singleDoctor.reviewsAvgRate.round().toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontSize: 15,
                                                  color: starColor),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          '(${doctorProvider.doctorInfo.singleDoctor.reviewsCount})',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color:
                                              Theme.of(context).disabledColor,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                          /*        Row(
                                    children: [
                                      Text(
                                        locale.availability!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .disabledColor,
                                                fontSize: 15),
                                      ),
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).disabledColor,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        children: [
                                          TextSpan(
                                              text: '12:00 ' +
                                                  locale.to! +
                                                  ' 13:00',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(fontSize: 14))
                                        ]),
                                  ),*/
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.only(
                        top: 10, left: 20, bottom: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.servicesAt!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Theme.of(context).disabledColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                           shrinkWrap: true,
                            primary: false,
                            itemCount: doctorProvider.doctorInfo.hotspitals.length,
                            itemBuilder: (context,i){
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(doctorProvider.doctorInfo.hotspitals[i].hospital.name),
                            subtitle: Text(doctorProvider.doctorInfo.hotspitals[i].hospital.description),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          );
                        }),
                        Text(
                          '+1 ' + locale.more!,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              height: 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.only(
                        top: 10, left: 20, bottom: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.servicesAt!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Theme.of(context).disabledColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                        shrinkWrap: true,primary: false,
                        itemCount: doctorProvider.doctorInfo.services.length
                        ,itemBuilder: (context,indexx){
                          return Text(
                            doctorProvider.doctorInfo.services[indexx].service[0].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 18, height: 2),
                          );
                        }),

                        Text(
                          '+5 ' + locale.more!,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              height: 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.only(top: 10, left: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.specifications!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Theme.of(context).disabledColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                       ListView.builder(
                         shrinkWrap: true,primary: false,
                         itemCount: doctorProvider.doctorInfo.singleDoctor.specifications.length,
                           itemBuilder: (context,index){
                           return   Text(
                             doctorProvider.doctorInfo.singleDoctor.specifications[index].name,
                            style: Theme.of(context)
                               .textTheme
                               .bodyText2!
                               .copyWith(fontSize: 18, height: 2),
                         );
                       }),
                        Text(
                          '+1 ' + locale.more!,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              height: 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PageRoutes.bookAppointment);
                      },
                      icon: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: locale.bookAppointmentNow,
                      radius: 0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
