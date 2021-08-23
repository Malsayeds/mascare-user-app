import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Doctors/list_of_doctors.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/medicines.dart';
import 'package:doctoworld_user/Features/BottomNavigation/hospitals_page.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Doctor/DoctorProvider.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishlist();
  }
  Future<void>getWishlist()async{
    Provider.of<ProductProvider>(context, listen: false).getWishlist();
    Provider.of<DoctorProvider>(context, listen: false).getWishlist();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale.saved!),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor.withOpacity(0.4),
            labelStyle: Theme.of(context).textTheme.subtitle1,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(text: locale.medicine),
              Tab(text: locale.doctors),
            //  Tab(text: locale.hospitals),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FadedSlideAnimation(
              Medicines(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            FadedSlideAnimation(
              DoctorsList(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
           /* FadedSlideAnimation(
              HospitalsList(),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),*/
          ],
        ),
      ),
    );
  }
}
