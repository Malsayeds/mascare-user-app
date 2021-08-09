import 'dart:async';
import 'package:doctoworld_user/Locale/language_cubit.dart';
import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Stroage/StorageData.dart';
import 'package:doctoworld_user/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<Splash>{
  var lang;
  var user_id;
  Future<void>setlangauge()async{
    late LanguageCubit _languageCubit=BlocProvider.of<LanguageCubit>(context);
    lang=(await StorageData.getValue("lang")==null?"":await StorageData.getValue("lang"))!;
    user_id=(await StorageData.getValue("user_id")==null?"":await StorageData.getValue("user_id"))!;
    Docto.username= (await StorageData.getValue("user_name"))!;
    setState(() {
    });
    if(lang=="en"){
      _languageCubit.selectEngLanguage();
    }
    else{
      _languageCubit.selectArabicLanguage();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setlangauge();
  }
  @override
  Widget build(BuildContext context) {
     Provider.of<GlobalProvider>(context,listen: false).setcounter();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context)
          .pushNamedAndRemoveUntil(lang==""?"language_page":user_id==""?"login":"bottom_navigation",
              (Route<dynamic> route) => false);
      // Phoenix.rebirth(context);
    });
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.15),
          Image.asset('assets/logo_user.png', scale: 3),
          Image.asset('assets/hero_image.png'),
          Spacer(),
          Text("Please Wait Until App loading ",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold)),
          SizedBox(height: 5,),
          Text("من فضلك انتظر تحميل التطبيق ",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}