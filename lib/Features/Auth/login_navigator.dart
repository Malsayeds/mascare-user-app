/*
import 'package:doctoworld_user/Features/Auth/Login/UI/login_ui.dart';
import 'package:doctoworld_user/Features/BottomNavigation/More/change_language_page.dart';
import 'package:doctoworld_user/Locale/language_cubit.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Stroage/StorageData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login/UI/login_page.dart';
import 'Registration/UI/registration_page.dart';
import 'Verification/UI/verifiaction_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginRoutes {
  static const String root = 'language/';
  static const String loginRoot = 'login/';
  static const String registration = 'login/registration';
  static const String verification = 'login/verification';
}

class LoginNavigator extends StatefulWidget {
  @override
  _LoginNavigatorState createState() => _LoginNavigatorState();
}

class _LoginNavigatorState extends State<LoginNavigator> {
  String lang="";
  Future<void>setlangauge()async{
    late LanguageCubit _languageCubit=BlocProvider.of<LanguageCubit>(context);
    lang=(await StorageData.getValue("lang")==null?"":await StorageData.getValue("lang"))!;
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
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState!.canPop();
        if (canPop) {
          navigatorKey.currentState!.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: LoginRoutes.root,
        onGenerateRoute: (RouteSettings settings) {
          late WidgetBuilder builder;
          switch (settings.name) {
            case LoginRoutes.root:
              builder = (BuildContext _) => lang==""?ChangeLanguagePage():LoginUI();
              break;
         case LoginRoutes.loginRoot:
              builder = (BuildContext _) => LoginUI();
              break;
          */
/*     case LoginRoutes.registration:
              builder = (BuildContext _) =>
                  RegistrationPage(settings.arguments as String?);
              break;
            case LoginRoutes.verification:
              builder = (BuildContext _) => VerificationPage(() {
                    Navigator.pushNamed(context, PageRoutes.bottomNavigation);
                  });
              break;*//*

          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}
*/
