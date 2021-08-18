import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Auth/login_navigator.dart';
import 'package:doctoworld_user/Locale/language_cubit.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Auth/ProfileProvider.dart';
import 'package:doctoworld_user/Provider/Config.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Stroage/StorageData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
class ChangeLanguagePage extends StatelessWidget{
  final bool fromRoot;

  ChangeLanguagePage([this.fromRoot = false]);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: ChangeLanguageScreen(this.fromRoot));
  }
}

class ChangeLanguageScreen extends StatefulWidget {
  final bool fromRoot;

  ChangeLanguageScreen([this.fromRoot = false]);

  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  late LanguageCubit _languageCubit;
  int? _selectedLanguage = -1;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider= Provider.of<ProfileProvider>(context, listen: true);
    final List<String> _languages = [
      'English',
      'عربى',
    ];
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        _selectedLanguage = getCurrentLanguage(locale);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.changeLanguage!),
            textTheme: Theme.of(context).textTheme,
          ),
          body: FadedSlideAnimation(
             Container(
                 child: ListView.builder(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: ()async{
                      setState(() {
                        _selectedLanguage = index;
                      });
                      if (_selectedLanguage == 0) {
                        _languageCubit.selectEngLanguage();
                        StorageData.storeValue("lang", "en");
                      } else if (_selectedLanguage == 1) {
                        _languageCubit.selectArabicLanguage();
                        StorageData.storeValue("lang", "ar");
                      } else if (_selectedLanguage == 2) {
                        _languageCubit.selectFrenchLanguage();
                      } else if (_selectedLanguage == 3) {
                        _languageCubit.selectIndonesianLanguage();
                      } else if (_selectedLanguage == 4) {
                        _languageCubit.selectPortugueseLanguage();
                      } else if (_selectedLanguage == 5) {
                        _languageCubit.selectSpanishLanguage();
                      } else if (_selectedLanguage == 6) {
                        _languageCubit.selectItalianLanguage();
                      } else if (_selectedLanguage == 7) {
                        _languageCubit.selectTurkishLanguage();
                      } else if (_selectedLanguage == 8) {
                        _languageCubit.selectSwahiliLanguage();
                      }
                      if (widget.fromRoot) {
                        Navigator.pushNamed(context, PageRoutes.login);
                      } else {
                        Navigator.pop(context);
                        var lang=await StorageData.getValue("lang");
                        profileProvider.changelanguage(lang!);
                      }
                    },
                    title: Text(_languages[index]),
                  ),
            ),
             ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        );
      },
    );
  }

  int getCurrentLanguage(Locale locale) {
    if (locale == Locale('en'))
      return 0;
    else if (locale == Locale('ar'))
      return 1;
    else if (locale == Locale('fr'))
      return 2;
    else if (locale == Locale('id'))
      return 3;
    else if (locale == Locale('pt'))
      return 4;
    else if (locale == Locale('es'))
      return 5;
    else if (locale == Locale('it'))
      return 6;
    else if (locale == Locale('tr'))
      return 7;
    else if (locale == Locale('sw'))
      return 8;
    else
      return -1;
  }
}
