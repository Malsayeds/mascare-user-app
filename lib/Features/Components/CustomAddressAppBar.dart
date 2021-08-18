import 'package:doctoworld_user/Features/Components/CustomCartIcon.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAddressAppBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<CustomAddressAppBar>{
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    String? value = 'Wallington';
    return AppBar(
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
        CustomCartIcon()
      ],
    );
  }
}