import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/order_card_model.dart';
import 'package:doctoworld_user/Features/BottomNavigation/More/Order/order_info.dart';
import 'package:doctoworld_user/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';

class RecentOrdersPage extends StatelessWidget {
  final List<OrderCardModel> inProcessOrders = [
    OrderCardModel("assets/SellerImages/4.png", 'Well Life Store 0',
        'In transit', '11 June, 11: 20 am', '18.00', 'COD', [
      'Salosir 100mg Tablet',
      'Salosir 100mg Tablet',
      'Salosir 100mg Tablet'
    ]),
    OrderCardModel("assets/SellerImages/1.png", 'Well Life Store 1',
        'confirmed', '11 June, 11: 20 am', '18.00', 'PayPal', [
      'Salosir 100mg Tablet',
      'Salosir 100mg Tablet',
      'Salosir 100mg Tablet'
    ]),
  ];

  final List<OrderCardModel> pastOrders = [
    OrderCardModel(
        "assets/SellerImages/2.png",
        'Well Life Store 2',
        'delivered',
        '11 June, 11: 20 am',
        '18.00',
        'COD',
        ['Salosir 100mg Tablet']),
    OrderCardModel(
        "assets/SellerImages/3.png",
        'Well Life Store 3',
        'delivered',
        '11 June, 11: 20 am',
        '18.00',
        'COD',
        ['Salosir 100mg Tablet']),
    OrderCardModel(
        "assets/SellerImages/4.png",
        'Well Life Store 4',
        'delivered',
        '11 June, 11: 20 am',
        '18.00',
        'COD',
        ['Salosir 100mg Tablet']),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.recentOrders!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                locale.inProcess!,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              color: Theme.of(context).dividerColor,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: inProcessOrders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  OrderCard(inProcessOrders[index]),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                locale.past!,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              color: Theme.of(context).dividerColor,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: pastOrders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => OrderCard(pastOrders[index]),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderCardModel orderCard;

  OrderCard(this.orderCard);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderInfoPage(orderCard: orderCard)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset(orderCard.image, height: 40),
            title: Row(
              children: [
                Text(orderCard.storeName),
                Spacer(),
                Text(
                  orderCard.status.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: orderCard.status.toLowerCase() == 'in transit'
                          ? inProcessColor
                          : orderCard.status.toLowerCase() == 'confirmed'
                              ? kMainColor
                              : kMainTextColor),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Text(
                  orderCard.date,
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                Text(
                  '\$' + orderCard.totalPrice + ' | ' + orderCard.paymentType,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: orderCard.medicines.length,
            padding: EdgeInsetsDirectional.fromSTEB(72, 0, 0, 20),
            shrinkWrap: true,
            itemBuilder: (context, innerIndex) => Text(
              orderCard.medicines[innerIndex],
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(height: 1.5),
            ),
          ),
          if (orderCard.status.toLowerCase() == 'delivered')
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, PageRoutes.reviewOrderPage),
                    child: Text(
                      locale!.reviewNow!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor),
                    )
                ),
              ),
            ),
          Divider(thickness: 6, height: 0),
        ],
      ),
    );
  }
}
