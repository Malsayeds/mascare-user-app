import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/LocationProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Address {
  final IconData icon;
  final String? addressType;
  final String address;

  Address(this.icon, this.addressType, this.address);
}
class SavedAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
      Navigator.pushNamedAndRemoveUntil(context, "account", (route) => false);
      return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.savedAddresses!),
            textTheme: Theme.of(context).textTheme,
            centerTitle: true,
          ),
          body: FadedSlideAnimation(
            SavedAddresses(),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),

            slideCurve: Curves.linearToEaseOut,
          )),
    );
  }

}

class SavedAddresses extends StatefulWidget {
  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  bool loading=true;
  @override
  void initState() {
    super.initState();
    getAddress();
  }
  getAddress()async{
    await Provider.of<LocationProvider>(context, listen: false).getAddresses();
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: true);
    return loading?Center(child: CircularProgressIndicator.adaptive(),):
    locationProvider.addresseslist==0?Center(
      child: Text("No Addresses For You "),
    ):
    Container(
      color: Theme.of(context).dividerColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: locationProvider.addresseslist.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 6.0),color: Colors.white,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      tileColor: Theme.of(context).scaffoldBackgroundColor,
                      leading: Icon(
                        locationProvider.addresseslist[index].name=="Home"?Icons.home:locationProvider.addresseslist[index].name=="Office"?Icons.business:Icons.assistant,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(locationProvider.addresseslist[index].name),
                      ),
                      subtitle: Text(
                        locationProvider.addresseslist[index].detailedAddress,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 11.7),
                      ),
                    ),
                  );
                }),
          ),
          CustomButton(
            icon: Icon(Icons.add, color: Colors.white),
            label: AppLocalizations.of(context)!.addNewAddress,
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onTap: () => Navigator.pushNamed(context, PageRoutes.locationPage),
          ),
        ],
      ),
    );
  }
}
