import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Auth/ProfileProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Account/change_language_page.dart';
class MoreOptions extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return ChangeNotifierProvider(
      create: (context) => ProfileProvider(), child: More());
  }
}

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class _MoreState extends State<More> {
loadData() async {
  SharedPreferences pref =await SharedPreferences.getInstance();
  Provider.of<ProfileProvider>(context, listen: false).GetProfileServices(pref.getString("token")!);
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    final profileProvider= Provider.of<ProfileProvider>(context, listen: true);
    var locale = AppLocalizations.of(context)!;
    List<MenuTile> _menu = [
      MenuTile(locale.wallet, locale.quickPayment, Icons.account_balance_wallet,
          () {
        Navigator.pushNamed(context, PageRoutes.walletPage);
      }),
      MenuTile(locale.myOrders, locale.orderStatus, Icons.motorcycle, () {
        Navigator.pushNamed(context, PageRoutes.recentOrder);
      }),
      MenuTile(locale.pillReminder, locale.takePillOnTime,
          Icons.access_alarms_outlined, () {
        Navigator.pushNamed(context, PageRoutes.pillReminder);
      }),
      MenuTile(locale.myAddress, locale.saveAddress, Icons.location_pin, () {
        Navigator.pushNamed(context, PageRoutes.addressesPage);
      }),
      MenuTile(locale.saved, locale.medsAndDoctors, Icons.bookmark_outlined,
          () {
        Navigator.pushNamed(context, PageRoutes.savedPage);
      }),
      MenuTile(locale.changeLanguage, locale.changeLanguage, Icons.language,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeLanguagePage(false)),
            );
      }),
      MenuTile(locale.contactUs, locale.letUsHelpYou, Icons.message_sharp, () {
        Navigator.pushNamed(context, PageRoutes.supportPage);
      }),
      MenuTile(locale.tandc, locale.companyPolicy, Icons.assignment, () {
        Navigator.pushNamed(context, PageRoutes.tncPage);
      }),
      MenuTile(locale.faqs, locale.quickAnswer, Icons.announcement, () {
        Navigator.pushNamed(context, PageRoutes.faqPage);
      }),
      MenuTile(locale.logout, locale.logout, Icons.logout, () {
         logout();
      }),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(locale.account!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: profileProvider.getProfileInfo["id"]==""?Center(child: CircularProgressIndicator(),):ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadedScaleAnimation(
                  Image.asset('assets/userprofile.png', scale: 3.5),
                  durationInMilliseconds: 400,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profileProvider.getProfileInfo["user"]["name"],
                    style:Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 20, height: 2)) ,
                    Text(profileProvider.getProfileInfo["profile"]["contact_number"],style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Theme.of(context).disabledColor, height: 2)
                    )
                ],
                 )

              ],
            ),
          ),
          Container(
            color: Theme.of(context).backgroundColor,
            child: GridView.builder(
                itemCount: _menu.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.7, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _menu[index].onTap as void Function()?,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FadedScaleAnimation(
                            Text(
                              _menu[index].title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            durationInMilliseconds: 400,
                          ),

                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*.3-4,
                                child: Text(
                                  _menu[index].subtitle!,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                _menu[index].iconData,
                                size: 32,
                                color: Theme.of(context).highlightColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
  void logout()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
     pref.remove("user_id");
     pref.remove("token");
     Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
   }
}
