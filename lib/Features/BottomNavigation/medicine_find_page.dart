import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/BottomNavigation/Data/data.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Features/Components/title_row.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';

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
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    String? value = 'Wallington';
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).primaryColor,
        ),
        title: DropdownButton(
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
        ),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, PageRoutes.myCartPage);
                },
              ),
              Positioned.directional(
                textDirection: Directionality.of(context),
                top: 8,
                end: 12,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 5.5,
                  child: Center(
                      child: Text(
                    '1',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 9),
                  )),
                ),
              )
            ],
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
            child: Text(
              locale.hello! + ', Sam Smith,',
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
                hint: locale.searchMedicines,
                prefixIcon: Icons.search,
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
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.medicines);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: FadedScaleAnimation(
                        Image.asset(
                          categories[index],
                          width: 96,
                          fit: BoxFit.fill,
                        ),
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
