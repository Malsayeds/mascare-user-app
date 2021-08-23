import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/medicine_info.dart';
import 'package:doctoworld_user/Features/Components/CustomCartIcon.dart';
import 'package:doctoworld_user/Features/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          CustomCartIcon()
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
    var productProvider=Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
      body:productProvider.productList.length==0?Center(child: Text("No Medicines Found ! ",style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black),),): Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor,
        child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: productProvider.productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductInfo(productDetailModel:productProvider.productList[index] ,)),
                  );
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
                            FadedScaleAnimation(
                                Image.network(productProvider.productList[index].image,
                                height: MediaQuery.of(context).size.height*.135,
                                width: MediaQuery.of(context).size.width*.3,
                                fit: BoxFit.cover,
                                ),
                                durationInMilliseconds: 400,
                              ),
                         /*     Align(
                                      alignment: Alignment.center,
                                      child: FadedScaleAnimation(
                                        Image.network(
                                          productProvider.productList[index].image,
                                          scale: 3,
                                        ),
                                        durationInMilliseconds: 400,
                                      ),
                                    )*/

                          Spacer(),
                          Text(productProvider.productList[index].name,textAlign: TextAlign.start,),
                          SizedBox(height: 25,)
                        ],
                      ),
                    ),

                    Align(
                             alignment: Alignment.bottomRight,
                             child: Row(
                               children: [
                                 CustomAddItemButton(product: productProvider.productList[index],),
                                 Expanded(child: SizedBox()),
                                 Row(
                                   children: [
                                     Text(
                                       '\$ ' + productProvider.productList[index].price,
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
