import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Data/data.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Medicine/SearchMedicine.dart';
import 'package:doctoworld_user/Features/Components/CustomAddressAppBar.dart';
import 'package:doctoworld_user/Features/Components/CustomCartIcon.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Features/Components/title_row.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Provider/LocationProvider.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:doctoworld_user/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:provider/provider.dart';

class MedicinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FindMedicine();
  }
}

class FindMedicine extends StatefulWidget {
  @override
  _FindMedicineState createState() => _FindMedicineState();
}

class _FindMedicineState extends State<FindMedicine> {
  bool loading =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductCategory();
  }
  getProductCategory()async{
   await Provider.of<ProductProvider>(context, listen: false).getCategories();
   setState(() {
     loading=false;
   });
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var productProvider=Provider.of<ProductProvider>(context, listen: true);
    String? value = 'Wallington';
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).primaryColor,
        ),
        title: CustomAddressAppBar()
        /*DropdownButton(
          value: value,
          iconSize: 0.0,
          // style: inputTextStyle.copyWith(
          //     fontWeight: FontWeight.bold,
          //     color: Theme.of(context).secondaryHeaderColor),
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            setState(() {
              value = newValue;
            });
            // if (value == 'appLocalization.setLocation')
            //   Navigator.pushNamed(context, PageRoutes.locationPage);
          },
          items: <String?>[
            'Wallington',
            locale.office,
            locale.other,
            locale.setLocation
          ].map<DropdownMenuItem<String>>((address) {
            return DropdownMenuItem<String>(
              value: address,
              child: Text(
                address!,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
        )*/,
        actions: <Widget>[
          CustomCartIcon()
        ],
      ),
      body: loading?Center(child: CircularProgressIndicator.adaptive(),):ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text(
              locale.hello! + ', ${Docto.username}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FadedScaleAnimation(
              Text(
                locale.findYourMedicines!,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              durationInMilliseconds: 400,
            ),
          ),
          FadedScaleAnimation(
             Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: EntryField(
                  onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineSearchScreen()));
                  },
                  readOnly: true,
                  hint: locale.searchMedicines,
                  prefixIcon: Icon(Icons.search,color:Theme.of(context).primaryColor)
                ),
              ),

            durationInMilliseconds: 300,
          ),
          TitleRow(
              locale.shopByCategory,
              () => Navigator.pushNamed(
                    context,
                    PageRoutes.shopByCategory,
                  )),
          Container(
            height: 124,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: productProvider.CategoryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      getProductByCategory(productProvider.CategoryList[index].id);
                       Navigator.pushNamed(context, PageRoutes.medicines);
                    },
                    child: Container(
                      height: 124,
                      width: MediaQuery.of(context).size.width*.3,
                      padding: EdgeInsetsDirectional.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage(productProvider.CategoryList[index].image)
                        ),
                        color: Theme.of(context).primaryColor
                      ),
                      child: FadedScaleAnimation(
                        Text(productProvider.CategoryList[index].name,style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white,fontSize: 14
                        ),),
                        durationInMilliseconds: 300,
                      ),
                    ),
                  );
                }),
          ),
          TitleRow(locale.offers,
              () => Navigator.pushNamed(context, PageRoutes.offersPage)),
          Container(
            height: 108,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: banner.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.only(end: 20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageRoutes.offersPage);
                        },
                        child: FadedScaleAnimation(
                          Image.asset(banner[index], fit: BoxFit.fill),
                          durationInMilliseconds: 300,
                        )),
                  );
                }),
          ),
          TitleRow(locale.sellerNearYou, null),
          Container(
            height: 156,
            child: GridView.builder(
              itemCount: stores.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                childAspectRatio: 0.38,
              ),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  quickGrid(context, stores[index]),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> getProductByCategory(int id) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .getProductByCategory(id);
  }

  Widget quickGrid(BuildContext context, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageRoutes.sellerProfile);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadedScaleAnimation(
            Image(
              image: AssetImage(image),
              height: 54,
            ),
            durationInMilliseconds: 300,
          ),
          SizedBox(width: 13.3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Well Life Store',
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Theme.of(context).hintColor,
                    size: 12,
                  ),
                  Text(' ' + 'Willington Bridge',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontSize: 10.0)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
