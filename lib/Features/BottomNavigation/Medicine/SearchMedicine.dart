import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:doctoworld_user/Features/Components/custom_add_item_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
   return SafeArea(
     child: Scaffold(
       body: Container(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.only(top: 20.0, left: 14, right: 14),
               child: TextFormField(
                 initialValue: 'Surgeon',
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
                 '27 ' + locale.resultsFound!,
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
             )
           ],
         ),
       )
     ),
   );
  }
}