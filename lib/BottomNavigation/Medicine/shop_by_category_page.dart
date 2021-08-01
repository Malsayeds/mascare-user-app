import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/BottomNavigation/Data/category_data_list.dart';
import 'package:doctoworld_user/BottomNavigation/Data/data.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doctoworld_user/Routes/routes.dart';

class ShopByCategoryPage extends StatefulWidget {
  @override
  _ShopByCategoryPageState createState() => _ShopByCategoryPageState();
}

class _ShopByCategoryPageState extends State<ShopByCategoryPage> {
  int? _currentIndex;
  late List<String> subCategories;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    subCategories = getSubcategories(0);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.shopByCategory!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).dividerColor,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                          subCategories = getSubcategories(index);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Stack(
                          children: [
                            FadedScaleAnimation(
                              Image.asset(
                                categories[index],
                                height: 130,
                                fit: BoxFit.fill,
                              ),
                              durationInMilliseconds: 400,
                            ),
                            _currentIndex == index
                                ? Container(
                                    height: 130,
                                    padding: EdgeInsets.only(bottom: 4),
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.0),
                                            Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.6),
                                            Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.9)
                                          ],
                                          stops: [
                                            0.3,
                                            0.65,
                                            0.9
                                          ]),
                                    ),
                                    child: Icon(Icons.arrow_forward_ios),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: subCategories.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsetsDirectional.only(start: 16, bottom: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.medicines);
                    },
                    child: ListTile(
                      title: FadedScaleAnimation(
                        Text(subCategories[index]),
                        durationInMilliseconds: 400,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//done
