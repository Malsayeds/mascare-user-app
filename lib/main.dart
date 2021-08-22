import 'package:doctoworld_user/Features/Auth/login_navigator.dart';
import 'package:doctoworld_user/Features/Splash.dart';
import 'package:doctoworld_user/Provider/GlobalProvider.dart';
import 'package:doctoworld_user/Provider/LocationProvider.dart';
import 'package:doctoworld_user/Provider/Product/ProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'Features/BottomNavigation/Doctors/SearchDoctor.dart';
import 'Features/BottomNavigation/Hospitals/SearchHospitals.dart';
import 'Features/BottomNavigation/Medicine/SearchMedicine.dart';
import 'Features/BottomNavigation/bottom_navigation.dart';
import 'Locale/locale.dart';
import 'Provider/Doctor/DoctorProvider.dart';
import 'Routes/routes.dart';
import 'Theme/style.dart';
import 'Locale/language_cubit.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(Phoenix(child: Docto()));
}

class Docto extends StatelessWidget {
  static String username="";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: GlobalProvider(),),
                ChangeNotifierProvider.value(value: LocationProvider(),),
                ChangeNotifierProvider.value(value: DoctorProvider(),),
                ChangeNotifierProvider.value(value: LocationProvider(),),
                ChangeNotifierProvider.value(value: ProductProvider(),),
              ],
            child: MaterialApp(
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en'),
                const Locale('ar'),
                const Locale('pt'),
                const Locale('fr'),
                const Locale('id'),
                const Locale('es'),
                const Locale('it'),
                const Locale('tr'),
                const Locale('sw'),
              ],
              locale: locale,
              theme: appTheme,
              home: Splash(),
              routes: PageRoutes().routes(),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
