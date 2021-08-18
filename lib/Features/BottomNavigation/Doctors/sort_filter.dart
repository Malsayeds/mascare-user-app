import 'dart:core';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SortFilter extends StatefulWidget {
  @override
  _SortFilterState createState() => _SortFilterState();
}

enum RadioList { consultancyfee, ratings, distance }

class _SortFilterState extends State<SortFilter> {
  RadioList? _character = RadioList.consultancyfee;
  int fees_from=0;
  int fees_to=0;
  int rate_to=0;
  int rate_from=0;
  String? _selectedRadioButton = 'Consultancy fees';
  RangeValues _currentRangeValues = RangeValues(1, 900);
  RangeValues _currentRangeRate = RangeValues(1, 4);
  bool? maleValue = false;
  bool? femaleValue = false;
  var  gender="gender";

bool fees=true;
  Future<void> getDoctorSpecialist() async {
 var doctorProvider=Provider.of<DoctorProvider>(context, listen: false);
    await doctorProvider.getFilterDoctor(doctorProvider.SelectedSpecialistId, fees_from, fees_to, gender, rate_from, rate_to);
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorProvider=Provider.of<DoctorProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(locale.sortFilter!),
        textTheme: Theme.of(context).textTheme,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _character = RadioList.consultancyfee;
                _selectedRadioButton = locale.consultancyFees;
                maleValue = false;
                femaleValue = false;
                _currentRangeValues = RangeValues(40, 80);
              });
            },
            child: Text(
              locale.reset!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
            ),
          ),
        ],
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              color: Theme.of(context).backgroundColor,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            locale.sortBy!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 20),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            locale.consultancyFees!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20),
                          ),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.consultancyfee,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.consultancyFees;
                                fees=true;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            locale.rating!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20),
                          ),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.ratings,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.rating;
                                fees=false;
                              });
                            },
                          ),
                        ),
                  /*      ListTile(
                          title: Text(
                            locale.distance!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontSize: 20),
                          ),
                          trailing: Radio(
                            activeColor: Colors.amber,
                            value: RadioList.distance,
                            groupValue: _character,
                            onChanged: (RadioList? value) {
                              setState(() {
                                _character = value;
                                _selectedRadioButton = locale.distance;
                              });
                            },
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            _selectedRadioButton!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 20),
                          ),
                        ),
                        fees?     Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              fees_from==0?'1 \$':'${fees_from} \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 20),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                             fees_to==0? '900 \$':'${fees_to} \$',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ):
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                             rate_from==0? '1':rate_from.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 20),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              rate_to==0?'4':rate_to.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      fees?
                      SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.amber,
                              activeTrackColor: Theme.of(context).primaryColor),
                          child: RangeSlider(
                            inactiveColor: Theme.of(context).backgroundColor,
                            values: _currentRangeValues,
                            min: 1,
                            max: 1000,
                            divisions: 99,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                                 fees_from=values.start.round();
                                 fees_to=values.end.round();
                              });
                            },
                          ),
                        ):
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbColor: Colors.amber,
                            activeTrackColor: Theme.of(context).primaryColor),
                        child: RangeSlider(
                          inactiveColor: Theme.of(context).backgroundColor,
                          values: _currentRangeRate,
                          min: 1,
                          max: 5,
                          divisions: 5,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                             // _currentRangeValues = values;
                              rate_from=values.start.round();
                              rate_to=values.end.round();

                            });
                          },
                        ),
                      ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            locale.gender!,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 20),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // [Monday] checkbox
                            SizedBox(
                              width: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: maleValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      maleValue = value;
                                      gender="male";
                                    });
                                  },
                                ),
                                Text(
                                  locale.male!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            // [Tuesday] checkbox
                            Spacer(
                              flex: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Colors.amber,
                                  value: femaleValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      femaleValue = value;
                                      gender="female";
                                    });
                                  },
                                ),
                                Text(
                                  locale.female!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            Spacer(
                              flex: 3,
                            ),
                            // [Wednesday] checkbox
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () async{
                await  getDoctorSpecialist();
                  Navigator.pop(context);
                //  Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);
                },
                label: locale.applyNow,
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
//done
