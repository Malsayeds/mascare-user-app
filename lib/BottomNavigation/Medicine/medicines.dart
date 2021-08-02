import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicinesPage extends StatefulWidget {
  @override
  _MedicinesPageState createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.heathCare!),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pushNamed(context, PageRoutes.myCartPage);
                  },
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  top: 8,
                  end: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 5.5,
                    child: Center(
                        child: Text(
                      '1',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 9),
                    )),
                  ),
                )
              ],
            )
          ],
        ),
        body: FadedSlideAnimation(
          Medicines(),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}

class Medicines extends StatefulWidget {
  @override
  _MedicinesState createState() => _MedicinesState();
}

class MedicineInfo {
  String image;
  String name;
  String price;
  bool prescription;

  MedicineInfo(this.image, this.name, this.price, this.prescription);
}

class _MedicinesState extends State<Medicines> {
  @override
  Widget build(BuildContext context) {
    List<MedicineInfo> _myItems = [
      MedicineInfo(
          'assets/Medicines/11.png', 'Salospir 100mg\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/22.png', 'Xenical 120mg\nTablet', '3.00', false),
      MedicineInfo('assets/Medicines/33.png', 'Allergy Relief\nTopcare Tablet',
          '4.00', false),
      MedicineInfo(
          'assets/Medicines/44.png', 'Arber OTC\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/55.png', 'Non Drosy\nLartin Tablet', '3.50', false),
      MedicineInfo(
          'assets/Medicines/66.png', 'Coricidin 100mg\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/11.png', 'Salospir 100mg\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/22.png', 'Xenical 120mg\nTablet', '3.00', false),
      MedicineInfo('assets/Medicines/33.png', 'Allergy Relief\nTopcare Tablet',
          '4.00', false),
      MedicineInfo(
          'assets/Medicines/44.png', 'Arber OTC\nTablet', '3.50', true),
      MedicineInfo(
          'assets/Medicines/55.png', 'Non Drosy\nLartin Tablet', '3.50', false),
      MedicineInfo(
          'assets/Medicines/66.png', 'Coricidin 100mg\nTablet', '3.50', true),
    ];
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        color: Theme.of(context).backgroundColor,
        child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _myItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageRoutes.medicineInfo);
                },
                child: Stack(
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                            children: [
                              FadedScaleAnimation(
                                Image.asset(_myItems[index].image),
                                durationInMilliseconds: 400,
                              ),
                              _myItems[index].prescription
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: FadedScaleAnimation(
                                        Image.asset(
                                          'assets/ic_prescription.png',
                                          scale: 3,
                                        ),
                                        durationInMilliseconds: 400,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          Spacer(),
                          Text(_myItems[index].name,textAlign: TextAlign.start,),
                          SizedBox(height: 25,)
                        ],
                      ),
                    ),

                       Align(
                         alignment: Alignment.bottomRight,
                         child: Row(
                           children: [
                             CustomAddItemButton(),
                             SizedBox(width: MediaQuery.of(context).size.width*.19,),
                             Row(
                               children: [
                                 Text(
                                   '\$ ' + _myItems[index].price,
                                   style: Theme.of(context).textTheme.subtitle1,
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),

                  ],
                ),
              );
            }),
      ),
    );
  }
}
//done
