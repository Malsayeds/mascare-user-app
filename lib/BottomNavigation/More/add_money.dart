import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Components/entry_field.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class PaymentType {
  String icon;
  String? title;

  PaymentType(this.icon, this.title);
}

class _AddMoneyState extends State<AddMoney> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<PaymentType> paymentModes = [
      PaymentType('', locale.wallet),
      PaymentType('assets/PaymentIcons/payment_cod.png', locale.cashOnDelivery),
      PaymentType('assets/PaymentIcons/payment_paypal.png', locale.payPal),
      PaymentType('assets/PaymentIcons/payment_payu.png', locale.payUMoney),
      PaymentType('assets/PaymentIcons/payment_stripe.png', locale.stripe),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.addMoney!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FadedSlideAnimation(
        Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: EntryField(
                  label: locale.enterMoneyToAdd,
                  hint: '\$500',
                ),
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
                  itemCount: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, PageRoutes.orderPlacedPage);
                          },
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                          leading: index == 0
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey[50],
                                  child: Icon(
                                    Icons.credit_card,
                                    size: 20,
                                    color: Colors.lightGreen,
                                  ))
                              : FadedScaleAnimation(
                                  Image.asset(
                                    paymentModes[index].icon,
                                    scale: 3,
                                  ),
                                  durationInMilliseconds: 400,
                                ),
                          title: Text(
                            index == 0
                                ? locale.wallet!
                                : paymentModes[index].title!,
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
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
