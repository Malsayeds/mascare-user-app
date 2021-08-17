import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/Hospitals/HospitalsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'about_tab.dart';
import 'departments_tab.dart';

class HospitalInfo extends StatefulWidget {
  HospitalsModel hospitalsModel;
  HospitalInfo({required this.hospitalsModel});
  @override
  _HospitalInfoState createState() => _HospitalInfoState(hospitalsModel: this.hospitalsModel);
}

class _HospitalInfoState extends State<HospitalInfo> {
  HospitalsModel hospitalsModel;
  _HospitalInfoState({required this.hospitalsModel});
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: FadedScaleAnimation(
                    Image.network(
                      hospitalsModel.media[0].url,
                      fit: BoxFit.fill,
                    ),
                    durationInMilliseconds: 400,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: Colors.transparent,
                    unselectedLabelColor: Theme.of(context).disabledColor,
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18),
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18),
                    isScrollable: true,
                    labelPadding: EdgeInsetsDirectional.only(end: 20, top: 5),
                    tabs: [
                      Tab(text: locale!.about),
                      Tab(text: locale.departments),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(children: [
            FadedSlideAnimation(
              About(hospitalsModel: this.hospitalsModel,),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
            FadedSlideAnimation(
              Departments(hospitalsModel: this.hospitalsModel,),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ]),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 148;
  @override
  double get maxExtent => 148;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apple Hospital',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 24, height: 2),
          ),
          Text(
            'General Hospital',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 16,
                color: Theme.of(context).disabledColor,
                height: 2),
          ),
          _tabBar,
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
