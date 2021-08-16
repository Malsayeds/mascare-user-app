import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Hospitals/SearchHospitals.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Hospital/HospitalProvider.dart';
import 'package:doctoworld_user/Provider/LocationProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'Data/data.dart';
class HospitalsHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HospitalProvider(), child: HospitalsScreen());
  }
}
class HospitalsScreen extends StatefulWidget {
  @override
  _HospitalsScreenState createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HospitalProvider>(context, listen: false).getHospitals(30,30);
    Provider.of<LocationProvider>(context, listen: false).getAddresses();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var locationProvider=    Provider.of<LocationProvider>(context, listen: true);
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
              locale.hello! + ', ${Docto.username}',
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => HospitalSearchScreen()));
              },
              readOnly: true,
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
    var hospitalProvider=    Provider.of<HospitalProvider>(context, listen: true);
    return ListView.builder(
      itemCount: hospitalProvider.hospitalslist.length,
      padding: EdgeInsets.only( bottom: 30),
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
                      Container(
                        width: MediaQuery.of(context).size.width / 2-16,
                        child: Text(
                          hospitalProvider.hospitalslist[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 20, height: 1.5),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2-16,
                        child: Text(
                          hospitalProvider.hospitalslist[index].type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 16,
                              color: Theme.of(context).disabledColor,
                              height: 1.5),
                        ),
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
                      itemCount: hospitalProvider.hospitalslist[index].specifications.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            //  Navigator.pushNamed(context, PageRoutes.medicines);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: FadedScaleAnimation(
                                  Container(
                                    height: 50,
                                    // padding: EdgeInsets.only(left: 10),
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Theme.of(context).primaryColor,
                                        image: DecorationImage(
                                            image: NetworkImage(hospitalProvider.hospitalslist[index].specifications[i].media[0].url),
                                            fit: BoxFit.contain)
                                    ),
                                    child: FadedScaleAnimation(
                                      Column(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 100,
                                              padding: EdgeInsets.only(left: 3,right: 3),
                                              //width: MediaQuery.of(context).size.width*.3,
                                              alignment: Alignment.center,
                                              child: Text(hospitalProvider.hospitalslist[index].specifications[i].name,overflow: TextOverflow.fade,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)),
                                        ],
                                      ),
                                      durationInMilliseconds: 300,
                                    ),
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
                  Container(
                    width: MediaQuery.of(context).size.width*.6,
                    child: Text(" "+
                      hospitalProvider.hospitalslist[index].area.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 13, color: Theme.of(context).disabledColor),
                    ),
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
