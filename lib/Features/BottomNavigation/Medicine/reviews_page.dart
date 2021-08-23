import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class ReviewDetail {
  String image;
  String name;
  String? disease;
  double rating;
  String date;

  ReviewDetail(this.image, this.name, this.disease, this.rating, this.date);
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var productProvider=    Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.reviews!,
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.sellerProfile);
              },
              title: Row(
                children: [
                  Text(
                   productProvider.reviews.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xffF29F19),
                        size: 16,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${productProvider.reviews.avg}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Color(0xffF29F19), fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    locale.averageReviews!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 14, height: 1.8),
                  ),
                  Spacer(),
                  Text(
                    locale.avgReview!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 14, height: 1.8),
                  ),
                ],
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: productProvider.reviews.reviews.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Divider(
                        color: Theme.of(context).backgroundColor,
                        thickness: 6,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(productProvider.reviews.reviews[index].image==""?Config.user_defualt_image:productProvider.reviews.reviews[index].image),
                        ),
                        title: Row(
                          children: [
                            Text(
                              productProvider.reviews.reviews[index].username,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  productProvider.reviews.reviews[index].rate.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 10),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: List.generate(
                                    productProvider.reviews.reviews[index].rate.floor(),
                                    (index) => Icon(
                                      Icons.star,
                                      size: 12,
                                      color: Color(0xffF29F19),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5 - productProvider.reviews.reviews[index].rate.floor(),
                                    (index) => Icon(
                                      Icons.star,
                                      size: 12,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    /*    subtitle: Row(
                          children: [
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: locale.for1! + ' ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                      fontSize: 9,
                                      color: Theme.of(context).disabledColor,
                                    ),
                              ),
                              TextSpan(
                                text: locale.coldFever,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 10),
                              ),
                            ])),
                            Spacer(),
                            Text(
                              productProvider.reviews.reviews[index].date,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontSize: 10),
                            )
                          ],
                        ),*/
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                        child: Text(productProvider.reviews.reviews[index].review),
                      )
                    ],
                  );
                })
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
