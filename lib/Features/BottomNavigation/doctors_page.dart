import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/CustomAddressAppBar.dart';
import 'package:doctoworld_user/Features/Components/CustomCartIcon.dart';
import 'package:doctoworld_user/Features/PublicFunction.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'Data/data.dart';
class DoctorsHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  DoctorScreesn();
  }
}

class DoctorScreesn extends StatefulWidget {
  @override
  _DoctorScreesnState createState() => _DoctorScreesnState();
}

class _DoctorScreesnState extends State<DoctorScreesn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).getDoctorSpecialist();
    Provider.of<DoctorProvider>(context, listen: false).getDoctorAdds();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorSpeialistProvider=    Provider.of<DoctorProvider>(context, listen: true);
    String? value = 'Wallington';

    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
          title: CustomAddressAppBar()
          /*DropdownButton(
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
          )*/,
          actions: <Widget>[
            CustomCartIcon()
          ],
        ),
        body:doctorSpeialistProvider.doctorSpeiaList.length==0?Center(child: CircularProgressIndicator(),) :DoctorsBody());
  }
}

class DoctorsBody extends StatefulWidget {
  @override
  _DoctorsBodyState createState() => _DoctorsBodyState();
}

class _DoctorsBodyState extends State<DoctorsBody> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var doctorProvider=    Provider.of<DoctorProvider>(context, listen: true);
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text(
              locale.hello! + ', ${Docto.username}',
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
              readOnly: true,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              children: [
                Text(
                  locale.findBySpecialities!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async{
                    await getDoctorSpecialist(0);
                    Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);
                  },
                  child: Text(
                    locale.viewAll!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
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
                itemCount: doctorProvider.doctorSpeiaList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                      doctorProvider.SetSelectedSpecialist(doctorProvider.doctorSpeiaList[index].id,doctorProvider.doctorSpeiaList[index].name);
                      await getDoctorSpecialist(doctorProvider.doctorSpeiaList[index].id);
                       Navigator.pushNamed(context, PageRoutes.listOfDoctorsPage);

                    },
                    child: Row(
                      children: [
                        Container(
                         // padding: EdgeInsets.only(left: 10),
                          height: 123.3,
                          width: MediaQuery.of(context).size.width*.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).primaryColor,
                              image: doctorProvider.doctorSpeiaList[index].media.length>0?
                              DecorationImage(
                                  image: NetworkImage(doctorProvider.doctorSpeiaList[index].media[0].url),
                                  fit: BoxFit.contain):
                              DecorationImage(
                                  image: NetworkImage(Config.doctor_defualt_image),
                                  fit: BoxFit.contain)
                          ),
                          child: FadedScaleAnimation(
                            Column(
                              children: [
                                SizedBox(height: 15,),
                                Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    alignment: Alignment.center,
                                    child: Text(doctorProvider.doctorSpeiaList[index].name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),)),
                              ],
                            ),
                            durationInMilliseconds: 300,
                          ),
                        ),
                        SizedBox(width: 10,)
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
              locale.sponsorAd!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ),
          Container(
            height: 110,
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: doctorProvider.addsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      PublicFunction.launchURL(doctorProvider.addsList[index].link);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: FadedScaleAnimation(
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            doctorProvider.addsList[index].image,
                            width: 250,
                            fit: BoxFit.fill,
                          ),
                        ),
                        durationInMilliseconds: 300,
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Text(
              locale.listOfSpec!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: doctorProvider.doctorSpeiaList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      doctorProvider.doctorSpeiaList[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Theme.of(context).disabledColor,
                    ),
                  ],
                ),
              );
              /*ListTile(
                contentPadding: EdgeInsets.symmetric(),
                title: Text('Addiction psychiatrist'),
                trailing: Icon(Icons.arrow_forward_ios, size: 15,),
              );*/
            },
          ),
        ],
      ),
    );
  }
  Future<void> getDoctorSpecialist(int id) async {
    await Provider.of<DoctorProvider>(context, listen: false)
        .getDoctorBySpecialist(id);
  }
}
