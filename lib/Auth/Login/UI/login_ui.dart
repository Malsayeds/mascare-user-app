import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Components/custom_button.dart';
import 'package:doctoworld_user/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_interactor.dart';

class LoginUI extends StatefulWidget {
  final LoginInteractor loginInteractor;

  LoginUI(this.loginInteractor);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  color: Theme.of(context).splashColor,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset('assets/logo_user.png', scale: 3),
                      Spacer(),
                      Image.asset('assets/hero_image.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55),
                      EntryField(
                        hint: locale.enterMobileNumber,
                        prefixIcon: Icons.phone_iphone,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        controller: _numberController,
                      ),
                      SizedBox(height: 20.0),
                      CustomButton(
                          onTap: () => widget.loginInteractor
                              .loginWithMobile('', _numberController.text)),
                      Spacer(flex: 2),
                      Text(
                        locale.orQuickContinueWith!,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              icon: Image.asset('assets/Icons/ic_fb.png',
                                  scale: 2),
                              color: Color(0xff3b45c1),
                              label: locale.facebook,
                              onTap: () =>
                                  widget.loginInteractor.loginWithFacebook(),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: CustomButton(
                              label: locale.gmail,
                              icon: Image.asset('assets/Icons/ic_ggl.png',
                                  scale: 3),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              textColor: Theme.of(context).hintColor,
                              onTap: () =>
                                  widget.loginInteractor.loginWithGoogle(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
