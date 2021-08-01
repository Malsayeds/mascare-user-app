import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Data/data.dart';

class HospitalsHome extends StatefulWidget {
  @override
  _HospitalsHomeState createState() => _HospitalsHomeState();
}

class _HospitalsHomeState extends State<HospitalsHome> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    String? value = 'Wallington';

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).primaryColor,
        ),
        title: DropdownButton(
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
        ),
      ),
      body: HospitalsBody(),
    );
  }
}

class HospitalsBody extends StatefulWidget {
  @override
  _HospitalsBodyState createState() => _HospitalsBodyState();
}

class HospitalDetail {
  String image;
  String name;
  String type;
  String location;

  HospitalDetail(this.image, this.name, this.type, this.location);
}

class _HospitalsBodyState extends State<HospitalsBody> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text(
              locale.hello! + ', Sam Smith,',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 20, color: Theme.of(context).disabledColor),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 25, left: 20, right: 20),
            child: FadedScaleAnimation(
              Text(
                locale.findHospital!,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              durationInMilliseconds: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: TextFormField(
              onTap: () {
                //Navigator.pushNamed(context, PageRoutes.searchDoctors);
              },
              decoration: InputDecoration(
                  hintText: locale.searchHospital,
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              children: [
                Text(
                  locale.searchByCategory!,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).disabledColor, fontSize: 20),
                ),
                Spacer(),
                Text(
                  locale.viewAll!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).primaryColor, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            height: 123.3,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctorCategories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.medicines);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: FadedScaleAnimation(
                        Image.asset(
                          doctorCategories[index],
                          // height: 100,
                          width: 95,
                          fit: BoxFit.fill,
                        ),
                        durationInMilliseconds: 300,
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Row(
              children: [
                Text(
                  locale.hospitalsNearYou!,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).disabledColor, fontSize: 20),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.map,
                      color: Theme.of(context).disabledColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, PageRoutes.hospitalMapView);
                    })
              ],
            ),
          ),
          HospitalsList(),
        ],
      ),
    );
  }
}

class HospitalsList extends StatelessWidget {
  final List<HospitalDetail> _hospitals = [
    HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
        'General Hospital', 'Jespora Bridge, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'Apple Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'City Light Eye Care',
        'General Hospital', 'Jespora Bridge, Wallington, New York.'),
    HospitalDetail('assets/ProfilePics/dp1.png', 'Silver Soul Hospital',
        'General Hospital', 'Walter street, Wallington, New York.'),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: _hospitals.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Divider(
              color: Theme.of(context).backgroundColor,
              thickness: 6,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 16),
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hospitals[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20, height: 1.5),
                      ),
                      Text(
                        _hospitals[index].type,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).disabledColor,
                            height: 1.5),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: doctorCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            //  Navigator.pushNamed(context, PageRoutes.medicines);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: FadedScaleAnimation(
                              Image.asset(
                                doctorCategories[index],
                                // height: 100,
                                width: 90,
                                fit: BoxFit.fill,
                              ),
                              durationInMilliseconds: 300,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 16.0, top: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Theme.of(context).disabledColor,
                    size: 13,
                  ),
                  Text(
                    _hospitals[index].location,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 13, color: Theme.of(context).disabledColor),
                  ),
                  Spacer(),
                  Icon(
                    Icons.call,
                    color: Theme.of(context).primaryColor,
                    size: 13,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    locale!.callNow!,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 13, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
//done
