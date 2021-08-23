import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoosePaymentMethod extends StatefulWidget {
  @override
  _ChoosePaymentMethodState createState() => _ChoosePaymentMethodState();
}

class PaymentType {
  String icon;
  String? title;

  PaymentType(this.icon, this.title);
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaymentMethod();
  }
  var loading=true;
  Future<void>getPaymentMethod()async{
    await Provider.of<ProductProvider>(context, listen: false).getPaymentMethod();
    print("ddddddddddddddddddddddd");
    setState(() {
      loading=false;
    });
    print("afterrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var productProvider=Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          locale.selectPaymentMethod!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),
      body:loading?Center(child: CircularProgressIndicator.adaptive(),): FadedSlideAnimation(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 20),
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: locale.amountToPay!.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).hintColor, height: 1.4)),
                TextSpan(
                    text: '\n\$ 20.00',
                    style: Theme.of(context).textTheme.headline4)
              ])),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Text(
                locale.paymentModes!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            ListView.builder(
                itemCount: productProvider.paymentMethodList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, PageRoutes.orderPlacedPage);
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        leading:  FadedScaleAnimation(
                                Image.network(
                                  productProvider.paymentMethodList[index].logo,
                                  scale: 3,
                                ),
                                durationInMilliseconds: 400,
                              ),
                        title: Text(
                           productProvider.paymentMethodList[index].name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Divider(
                        thickness: 4,
                        height: 4,
                      ),
                    ],
                  );
                }),
            Expanded(
                child: Container(
              color: Theme.of(context).backgroundColor,
            )),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
//done
