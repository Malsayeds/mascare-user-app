import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Data/data.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Hospitals/hospital_info.dart';
import 'package:doctoworld_user/Features/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Features/PublicFunction.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Hospital/HospitalProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../hospitals_page.dart';

class HospitalSearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HospitalProvider(), child: SearchHospital());
  }
}
class SearchHospital extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<SearchHospital>{
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var hospitalProvider=    Provider.of<HospitalProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 14, right: 14),
                  child: TextFormField(
                    initialValue: '',
                    onChanged: (val){
                      hospitalProvider.seachHospitals(val);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        hintText: locale.searchDoc,
                        filled: true,
                        fillColor: Theme.of(context).backgroundColor,
                        prefixIcon: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PageRoutes.searchHistoryPage);
                          },
                        )),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    '${hospitalProvider.searchHospitalslist.length} ' + locale.resultsFound!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).disabledColor),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    padding: EdgeInsets.only(bottom: 20),
                    child: ListView.builder(
                      itemCount: hospitalProvider.searchHospitalslist.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HospitalInfo(hospitalsModel:hospitalProvider.searchHospitalslist[index] ,)),
                            );
                          },
                          child: Container(
                            color: Colors.white,

                            child: Column(
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
                                              hospitalProvider.searchHospitalslist[index].name,
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
                                              hospitalProvider.searchHospitalslist[index].type,
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
                                  padding: const EdgeInsets.only(left: 14, right: 16.0, top: 15,bottom: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Theme.of(context).disabledColor,
                                        size: 13,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*.6,
                                        child: Text(
                                          hospitalProvider.searchHospitalslist[index].name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                              fontSize: 13, color: Theme.of(context).disabledColor),
                                        ),
                                      ),
                                      Spacer(),
                                     InkWell(
                                       onTap: (){
                                         PublicFunction.makingPhoneCall( hospitalProvider.searchHospitalslist[index].phone);
                                       },
                                       child: Row(
                                         children: [
                                           Icon(
                                             Icons.call,
                                             color: Theme.of(context).primaryColor,
                                             size: 13,
                                           ),
                                           SizedBox(
                                             width: 10,
                                           ),
                                           Text(
                                             locale.callNow!,
                                             style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                 fontSize: 13, color: Theme.of(context).primaryColor),
                                           ),
                                         ],
                                       ),
                                     )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
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