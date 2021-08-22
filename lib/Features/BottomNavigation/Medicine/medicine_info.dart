import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Models/Medicine/ProductModel.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Stroage/DbHelper.dart';
import 'package:doctoworld_user/Stroage/Model/CartModelLocal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  final ProductDetailModel productDetailModel;
  ProductInfo({required this.productDetailModel});
  @override
  _ProductInfoState createState() => _ProductInfoState(productDetailModel: this.productDetailModel);
}

class _ProductInfoState extends State<ProductInfo> {
  final ProductDetailModel productDetailModel;
  _ProductInfoState({required this.productDetailModel});
  IconData saved = Icons.bookmark_border;
  DbHelper dbHelper=new DbHelper();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var productProvider=Provider.of<ProductProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              icon: Icon(saved),
              onPressed: () {
                productProvider.addItemToWishlist(productDetailModel.id);
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, PageRoutes.myCartPage);
              }),
        ],
      ),
      body: FadedSlideAnimation(
              Stack(
                children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    children: [
                   
                    
                          Image.network( 
                               productDetailModel.image,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*.5,
                                fit: BoxFit.cover,
                              ),
                      
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                productDetailModel.name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Spacer(),
                              Icon(
                                Icons.star,
                                color: Color(0xffF29F19),
                                size: 16,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${productDetailModel.review.avg}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Color(0xffF29F19), fontSize: 16),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                productDetailModel.category,
                                style:
                                    Theme.of(context).textTheme.subtitle2!.copyWith(
                                          color: Theme.of(context).disabledColor,
                                        ),
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRoutes.reviewsPage);
                                  },
                                  child: Text(
                                    locale.readAll! + ' ${productDetailModel.review.count}  ' + locale.reviews!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: Theme.of(context).disabledColor,
                                        ),
                                  )),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: Theme.of(context).disabledColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                /*      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Text(
                          locale.description!,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),*/
                /*      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),*/
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 4.0, top: 12.0),
                        child: Text(locale.soldBy!),
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          leading: Image.network(productDetailModel.manufacturer.logo==null?Config.company_logo:productDetailModel.manufacturer.logo,
                              width: MediaQuery.of(context).size.width*.2,
                          ),
                          title: Container(
                            width: MediaQuery.of(context).size.width*.7,
                            child: Text(
                              productDetailModel.manufacturer.name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                       /*   subtitle: Column(
                            children: [
                              SizedBox(height: 2,),
                             Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).hintColor,
                                  size: 14,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*.6,
                                  child: Text(
                                    'Willinton Bridge',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                              ],
                            ),
                              SizedBox(height: 2,),
                             Container(
                               width: MediaQuery.of(context).size.width*.7,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRoutes.sellerProfile);
                                  },
                                  child: Text(
                                    locale.viewProfile!,
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Theme.of(context).hintColor,
                                  size: 14,
                                ),
                            ],
                          ),
                             )
                            ],
                          ),*/
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ListTile(
                            title: Text(
                              '\$ ${productDetailModel.price}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(locale.packOf! + ' ${productDetailModel.packing}'),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                         CustomButton(
                            radius: 0,
                            label: locale.addToCart,

                            onTap: ()async {
                                CartMedelLocal p1=new CartMedelLocal({
                                  "id":productDetailModel.id,
                                  "name":productDetailModel.name,
                                  "img":productDetailModel.image,
                                  "category":productDetailModel.category,
                                  "price":double.parse(productDetailModel.price),
                                  "quantity":1,
                                });
                                try
                                {
                                  await dbHelper.addToCart(p1);
                                  Provider.of<GlobalProvider>(context,listen: false).updateCounter();
                                  Navigator.pushNamed(context, PageRoutes.myCartPage);
                                }
                                catch(e)
                                {
                                print(e.toString());
                                 DialogMessages.ErrorMessage(context, "This Product Has Been Added Before");
                                }


                            },
                          )
                      ],
                    ),
                  )
                ],
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),

    );
  }
}
