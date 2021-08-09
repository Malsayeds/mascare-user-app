import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Stroage/DbHelper.dart';
import 'package:doctoworld_user/Stroage/Model/CartModelLocal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product {
  Product(this.img, this.name, this.category, this.price);
  String img;
  String name;
  String category;
  String price;
//  int count;
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> count = [1, 1, 1];
  DbHelper db=new DbHelper();
  List dataLocal=[];
  int totalquantity=0;
  double allPrice=0.0;
  loadData() async{
    dataLocal=await db.allProduct();
    setState(() {
    });
    print(dataLocal.length.toString());
    print("ssssssssssssssssssssss.....................................");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    getTotal();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    // bool _isPromoApplied = false;
    List<Product> items = [
      Product("assets/Medicines/11.png", 'Salospir 100mg Tablet',
          'Operum England', '\$32.00'),
      Product("assets/Medicines/22.png", 'Non Drosy Laritin Tablet',
          'Operum England', '\$44.00'),
      Product("assets/Medicines/33.png", 'Xenical 120mg Tablet',
          'Operum England', '\$14.00'),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          locale.myCart!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder(
                      future: db.allProduct(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        else{
                          return snapshot.data.length==0?Container(
                              padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.15),child: Center(
                            child: Column(
                              children: [
                                Icon(Icons.shopping_cart,size: 150,color: Theme.of(context).primaryColor,),
                                SizedBox(height: MediaQuery.of(context).size.height*.035,),
                                Text("No Items In Shopping Cart",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),),
                                SizedBox(height: MediaQuery.of(context).size.height*.035,),
                              ],
                            ),
                          )):
                          ListView.builder(
                              primary: false,
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                CartMedelLocal c=new CartMedelLocal.fromMap(snapshot.data[index]);
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 12),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            c.img,
                                            height: MediaQuery.of(context).size.height*.15,
                                            width: MediaQuery.of(context).size.width*.25,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*.02,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*.6-28,
                                                child: Text(
                                                  c.name,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                  Theme.of(context).textTheme.subtitle1,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width*.6-28,
                                                child: Text(
                                                  c.category,
                                                  style:
                                                  Theme.of(context).textTheme.subtitle2,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width*.6-28,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: ()async{
                                                            CartMedelLocal cartLDBModel = CartMedelLocal({
                                                              'id':c.id,
                                                              'name': c.name,
                                                              'img':  c.img,
                                                              'price': c.price,
                                                              'category':c.category,
                                                              'quantity': c.quantity-1,
                                                            });

                                                            setState(() {
                                                              db.updateCourse(cartLDBModel);
                                                              updateTotal(-1, -c.price);
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.only(left: 10,right: 10),
                                                            child: Icon(
                                                                Icons.remove),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5,),

                                                        Text('${c.quantity}',
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .subtitle1),
                                                        SizedBox(width: 5,),
                                                        InkWell(
                                                            onTap: ()async{
                                                              CartMedelLocal cartLDBModel = CartMedelLocal({
                                                                'id':c.id,
                                                                'name': c.name,
                                                                'img':  c.img,
                                                                'price': c.price,
                                                                'category':c.category,
                                                                'quantity': c.quantity+1,
                                                              });

                                                              setState(() {
                                                                db.updateCourse(cartLDBModel);
                                                                updateTotal(1, c.price);
                                                              });
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.only(left: 10,right: 10),
                                                                child: Icon(Icons.add))),
                                                        SizedBox(
                                                          width: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.height*.15,
                                            padding: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.height*.02
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                   DeleteFromCart(context, c.id, c.quantity, c.price);
                                                  },
                                                  child: Container(
                                                      padding: EdgeInsets.all(3),
                                                      child: Icon(Icons.delete,color: Theme.of(context).primaryColor,)),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(c.price.toString(),
                                                        textAlign: TextAlign.right,
                                                        style:
                                                        Theme.of(context).textTheme.subtitle1),
                                                    SizedBox(width: 10,)
                                                  ],
                                                )
                                              ],
                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      }),
                  SizedBox(height: 20),
                ],
              ),
            ),
           dataLocal.length==0?SizedBox():
           Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 12),
                            hintText: locale.addPromoCode,
                            fillColor: Colors.grey[100],
                            filled: true,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, PageRoutes.offersPage);
                                  },
                                  child: Text(
                                    locale.viewOffers!.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // _isPromoApplied = true;
                                    });
                                    // Scaffold.of(context).showSnackBar(new SnackBar(
                                    //     content: new Text('Promo Code Applied!')
                                    // ));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            bottomRight: Radius.circular(4))),
                                    child: Icon(
                                      Icons.check,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Column(
                        children: [
                          buildAmountRow(context, locale.subTotal!, allPrice.toString()),
                          buildAmountRow(
                              context, locale.promoCodeApplied!, '-2.0'),
                          buildAmountRow(context, locale.serviceCharge!, '4.0'),
                          buildAmountRow(context, locale.amountPayable!, '20.0'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _prescriptionRequired(context),
                        );
                      },
                      radius: 0,
                      label: locale.checkout,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 14,
                      ),
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
  getTotal() async {
    //totalquantity=0;
    //allPrice=0.0;
    List product=await db.allProduct();
    for(int i=0;i<product.length;i++){
      CartMedelLocal c=new CartMedelLocal.fromMap(product[i]);
      totalquantity=totalquantity+int.parse(c.quantity.toString());
      allPrice=allPrice+double.parse((c.price*c.quantity).toString());
      print(totalquantity);
      print("qqqqqqqqqqqqqqqq");
      setState(() {
      });
    }
    print(totalquantity);
    print("00000000000000000000000");
  }
  DeleteFromCart(BuildContext context,id,int quantity,double price) {
    double totalPrice=price*quantity;
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10
            ),
            height: 110.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12,width: 2.0)
            ),
            child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center
                ,crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(alignment: Alignment.center,child: Text("Are You Sure Delete",style: TextStyle(color:Colors.black,fontSize: 16),textAlign: TextAlign.center,)),
                  SizedBox(height: 25,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Theme.of(context).accentColor
                            ),
                            height: MediaQuery.of(context).size.height*.035,
                            width: MediaQuery.of(context).size.width*.27,
                            alignment: Alignment.center,
                            child:   Text("Cancel",style: TextStyle(color:Colors.white,fontSize: 12),),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:Theme.of(context).primaryColor
                            ),
                            height: MediaQuery.of(context).size.height*.035,
                            width: MediaQuery.of(context).size.width*.27,
                            alignment: Alignment.center,
                            child:   Text("Confirm",style: TextStyle(color:Colors.white,fontSize: 12),),
                          ),
                          onTap: () async {
                            print(totalPrice*quantity);
                            setState(() {
                              db.delete(id);
                            });
                            loadData();
                            updateTotal(-quantity, -totalPrice);
                            Navigator.pop(context);

                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),


            ],),
          ),
        ));
  }
  updateTotal(int quantity,double price){
    totalquantity+=quantity;
    allPrice+=price;
    setState(() {
    });
  }
  Padding buildAmountRow(BuildContext context, String title, String amount) {
    var locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            width: 4,
          ),
          title == locale.amountPayable
              ? GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.error_outline,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ))
              : SizedBox.shrink(),
          Spacer(),
          Text(
            '\$ ' + amount,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
  GestureDetector buildIconButton(IconData icon, int index, items, count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (icon == Icons.remove) {
            if (count[index] > 0) count[index]--;
          } else {
            count[index]++;
          }
        });
      },
      child: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 16,
      ),
    );
  }
  Widget _prescriptionRequired(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: FadedSlideAnimation(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadedScaleAnimation(
              Image.asset(
                'assets/upload prescription.png',
                scale: 3.5,
              ),
              durationInMilliseconds: 400,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              locale.prescriptionRequire!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: 20,
            ),
            Text(locale.yourOrderContains2items!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 35,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, PageRoutes.confirmOrderPage);
                },
                child: Text(
                  locale.uploadPrescription!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  locale.cancel!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).primaryColor),
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
