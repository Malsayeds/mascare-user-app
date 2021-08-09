import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Stroage/DbHelper.dart';
import 'package:doctoworld_user/Stroage/Model/CartModelLocal.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:provider/provider.dart';

class CustomAddItemButton extends StatelessWidget {
   DbHelper dbHelper=new DbHelper();
  @override
  Widget build(BuildContext context) {
    return  Consumer<GlobalProvider>(
        builder:  (context,globalProvider,child){
      return GestureDetector(
        onTap: ()async {
          CartMedelLocal p1=new CartMedelLocal({
            "id":2,
            "name":"product test",
            "img":'assets/SellerImages/1a.png',
            "category":"category",
            "price":5.0,
            "quantity":1,
          });
          try
          {
            await dbHelper.addToCart(p1);
            Provider.of<GlobalProvider>(context,listen: false).updateCounter();
            print("success");
          }
          catch(e)
          {
            print(e.toString());
            print("fail");
          }
          Navigator.pushNamed(context, PageRoutes.myCartPage);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
            color: Theme.of(context).primaryColor,
          ),
          height: 30,
          width: 30,
          child: Icon(
            Icons.add,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      );}
    );
  }
}
