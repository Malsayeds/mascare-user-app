import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Data/data.dart';
import 'package:doctoworld_user/Features/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../hospitals_page.dart';
import 'doctor_map_view.dart';

class DoctorSearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SearchDoctor();
  }
}
class SearchDoctor extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<SearchDoctor>{
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
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
    return SafeArea(
      child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
                  child: Text(
                    locale!.hello! + ', Sam Smith,',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Padding(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: TextFormField(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.searchDoctors);
                    },
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
                Expanded(
                  child: Container(
                    // color: Theme.of(context).backgroundColor,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchList.length,
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
                                      Image.asset(
                                        searchList[index].image,
                                        height: MediaQuery.of(context).size.height*.15,
                                        width: MediaQuery.of(context).size.width*.2,
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
                                          width: MediaQuery.of(context).size.width*.7,
                                          child: Text(searchList[index].name ,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*.7,
                                          child: Text(searchList[index].speciality,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                color: Theme.of(context)
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
                                              searchList[index].experience +
                                                  locale.years!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width:MediaQuery.of(context).size.width*.025,
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
                                              '\$' + searchList[index].fee,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*.025,
                                            ),
                                            RatingBar.builder(
                                                itemSize: 12,
                                                initialRating: 4,
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
                                              '(${searchList[index].reviews})',
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
                      },
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}