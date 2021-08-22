import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/medicine_info.dart';
import 'package:doctoworld_user/Features/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'medicines.dart';
class MedicineSearchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SearchMedicine();
  }
}
class SearchMedicine extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<SearchMedicine>{
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var productProvider=Provider.of<ProductProvider>(context, listen: true);
   return SafeArea(
     child: Scaffold(
       body: Container(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.only(top: 20.0, left: 14, right: 14),
               child: TextFormField(
                 initialValue: '',
                 onChanged: (val){
                   if(val.isNotEmpty)
                     productProvider.search(val);
                 },
                 decoration: InputDecoration(
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(8),
                         borderSide: BorderSide.none),
                     hintText: locale.searchMedicines,
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
                 '${productProvider.searchProductList.length} ' + locale.resultsFound!,
                 style: Theme.of(context)
                     .textTheme
                     .bodyText1!
                     .copyWith(color: Theme.of(context).disabledColor),
               ),
             ),
             Expanded(
               child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                 color: Theme.of(context).backgroundColor,
                 child: GridView.builder(
                     padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                     shrinkWrap: true,
                     primary: false,
                     itemCount: productProvider.searchProductList.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         childAspectRatio: 0.8,
                         crossAxisSpacing: 12,
                         mainAxisSpacing: 12),
                     itemBuilder: (context, index) {
                       return GestureDetector(
                         onTap: () {
                          // Navigator.pushNamed(context, PageRoutes.medicineInfo);
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => ProductInfo(productDetailModel:productProvider.searchProductList[index] ,)),
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
                                     Image.network(productProvider.searchProductList[index].image,
                                       height: MediaQuery.of(context).size.height*.135,
                                       width: MediaQuery.of(context).size.width*.3,
                                       fit: BoxFit.cover,
                                     ),
                                     durationInMilliseconds: 400,
                                   ),
                                   Spacer(),
                                   Text(productProvider.searchProductList[index].name,textAlign: TextAlign.start,),
                                   SizedBox(height: 25,)
                                 ],
                               ),
                             ),

                             Align(
                               alignment: Alignment.bottomRight,
                               child: Row(
                                 children: [
                                   CustomAddItemButton(product: productProvider.searchProductList[index],),
                                   SizedBox(width: MediaQuery.of(context).size.width*.19,),
                                   Row(
                                     children: [
                                       Text(
                                         '\$ ' + productProvider.searchProductList[index].price,
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
             )
           ],
         ),
       )
     ),
   );
  }
}