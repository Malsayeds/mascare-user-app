import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/LocationProvider.dart';
import 'package:doctoworld_user/Provider/Product/CartProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatefulWidget {
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class CartItem {
  String name;
  int quantity;
  String amount;
  bool presReq;

  CartItem(this.name, this.quantity, this.amount, this.presReq);
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  var loading =true;
  int selectAddressId=0;
  getAddress()async{
    await Provider.of<LocationProvider>(context, listen: false).getAddresses();
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var cartProvider=Provider.of<CartProvider>(context, listen: false);
    var addressProvider=Provider.of<LocationProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locale.confirmOrder!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body: loading?Center(child: CircularProgressIndicator.adaptive(),):FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Divider(
                  thickness: 6,
                  height: 6,
                ),
                buildCustomContainer(context, locale.deliveryAt!),
                 ListView.builder(
                 shrinkWrap: true,
                 primary: false,
                 itemCount: addressProvider.addresseslist.length,
                 itemBuilder: (context,index){
                   return  Container(
                     decoration: BoxDecoration(
                       color:selectAddressId==addressProvider.addresseslist[index].id? Colors.black12:Colors.white
                     ),
                     child: ListTile(
                       onTap: (){
                         cartProvider.setAddressId(addressProvider.addresseslist[index].id);
                         setState(() {
                           selectAddressId=addressProvider.addresseslist[index].id;
                         });
                       },
                       contentPadding:
                       EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                       leading: Icon(
                         addressProvider.addresseslist[index].name=="Home"?Icons.home:addressProvider.addresseslist[index].name=="Office"?Icons.business:Icons.assistant,
                         color: Theme.of(context).primaryColor,
                       ),
                       title: Text(
                         addressProvider.addresseslist[index].name + '\n',
                         style: Theme.of(context)
                             .textTheme
                             .subtitle1!
                             .copyWith(height: 0.6),
                       ),
                       subtitle: Text(
                         addressProvider.addresseslist[index].detailedAddress,
                         style: Theme.of(context).textTheme.subtitle2,
                       ),
                     ),
                   );
                 })
               /* buildCustomContainer(context, locale.itemsInCart!),*/
                /*ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              cartItems[index].name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            cartItems[index].presReq
                                ? SizedBox(
                                    width: 10,
                                  )
                                : SizedBox.shrink(),
                            cartItems[index].presReq
                                ? Image.asset(
                                    'assets/ic_prescription.png',
                                    scale: 3,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            // Text(cartItems[index].quantity.toString() + ' '+locale.pack , style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).hintColor),),
                            cartItems[index].quantity > 1
                                ? Text(
                                    cartItems[index].quantity.toString() +
                                        ' ' +
                                        locale.packs!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: Theme.of(context).hintColor))
                                : Text(
                                    cartItems[index].quantity.toString() +
                                        ' ' +
                                        locale.pack!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: Theme.of(context).hintColor),
                                  ),
                            Spacer(),
                            Text(
                              '\$6.00',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      );
                    }),*/
             /*   Divider(
                  thickness: 6,
                  height: 6,
                  color: Theme.of(context).backgroundColor,
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/ic_prescription.png',
                    scale: 3,
                  ),
                  title: Text(
                    locale.prescriptionUploaded!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  trailing: Icon(
                    Icons.remove_red_eye,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Divider(
                  thickness: 6,
                  height: 6,
                  color: Theme.of(context).backgroundColor,
                ),
                SizedBox(
                  height: 200,
                ),*/
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Column(
                        children: [
                          buildAmountRow(context, locale.subTotal!, cartProvider.total.toString()),
                          buildAmountRow(
                              context, locale.promoCodeApplied!, '-2.0'),
                          buildAmountRow(context, locale.serviceCharge!, '4.0'),
                          buildAmountRow(context, locale.amountToPay!, '20.0'),
                        ],
                      ),
                    ),
                    CustomButton(
                      radius: 0,
                      label: locale.continueToPay,
                      onTap: () {
                     if(selectAddressId!=0){
                       Navigator.pushNamed(
                           context, PageRoutes.choosePaymentMethod);
                     }
                     else{
                       DialogMessages.ErrorMessage(context, "Please Select Delivery Address");
                     }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Container buildCustomContainer(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Padding buildAmountRow(BuildContext context, String title, String amount) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: title == locale.amountToPay
                    ? FontWeight.w500
                    : FontWeight.w400,
                fontSize: title != locale.amountToPay ? 15 : 16),
          ),
          SizedBox(
            width: 4,
          ),
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.error_outline,
                size: 16,
                color: Theme.of(context).primaryColor,
              )),
          Spacer(),
          Text(
            '\$ ' + amount,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 16.5,
                fontWeight: title == locale.amountToPay
                    ? FontWeight.w500
                    : FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
