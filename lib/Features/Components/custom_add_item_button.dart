import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Models/Medicine/ProductModel.dart';
import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:doctoworld_user/Stroage/DbHelper.dart';
import 'package:doctoworld_user/Stroage/Model/CartModelLocal.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:provider/provider.dart';

class CustomAddItemButton extends StatelessWidget {
  ProductDetailModel product;
  CustomAddItemButton({required this.product});
   DbHelper dbHelper=new DbHelper();
  @override
  Widget build(BuildContext context) {
    var productProvider=Provider.of<ProductProvider>(context, listen: true);
    return  Consumer<GlobalProvider>(
        builder:  (context,globalProvider,child){
      return GestureDetector(
        onTap: ()async {
          CartMedelLocal p1=new CartMedelLocal({
            "id":product.id,
            "name":product.name,
            "img":product.image,
            "category":product.category,
            "price":double.parse(product.price),
            "quantity":1,
          });
          try
          {
           // await  productProvider.addUpdateCart(product.id, 1);
           await dbHelper.addToCart(p1);
           Provider.of<GlobalProvider>(context,listen: false).updateCounter();
            Navigator.pushNamed(context, PageRoutes.myCartPage);
          }
          catch(e)
          {
            print(e.toString());
            DialogMessages.ErrorMessage(context, "Product Has Been Added Befor");
          }

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
