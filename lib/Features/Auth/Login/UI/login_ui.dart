import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Auth/LoginProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Stroage/StorageData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'login_interactor.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(), child: LoginUI());
  }
}

class LoginUI extends StatefulWidget {
LoginUI(){}
  @override
  _LoginUIState createState() => _LoginUIState();
}
class _LoginUIState extends State<LoginUI> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey=GlobalKey<FormState>();
  bool loader=false;
  bool ishiden=true;
  FocusNode passwordNode=new FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final loginProvider= Provider.of<LoginProvider>(context, listen: false);
    var locale = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.38),
                     Form(
                       key: formKey,
                       child: Column(
                         children: [
                           EntryField(
                             onValidate: validateEmail,
                             textInputType: TextInputType.emailAddress,
                             focusNode: passwordNode,
                             prefixIcon: Icon(Icons.mail,color:Theme.of(context).primaryColor),
                             hint: locale.emailAddress,
                             color: Theme.of(context).scaffoldBackgroundColor,
                             controller: _emailController,
                           ),
                           SizedBox(height: 10.0),
                           EntryField(
                             hint: locale.enterpassword,
                             onValidate: validatePassword,
                             OwnFocusNode: passwordNode,
                             focusNode: FocusNode(),
                             prefixIcon:ishiden?
                             InkWell(onTap: ()=>hiddenPassword(),child: Icon(Icons.visibility_outlined,color:Theme.of(context).primaryColor),):
                             InkWell(onTap: ()=>hiddenPassword(),child:Icon(Icons.visibility_off_outlined,color:Theme.of(context).primaryColor)),
                             color: Theme.of(context).scaffoldBackgroundColor,
                             controller: _passwordController,
                             isHidden: ishiden,
                           ),
                           SizedBox(height: 10.0),
                         ],
                       ),
                     ),
                      CustomButton(
                        color: loader?Colors.black54:Theme.of(context).primaryColor,
                          onTap: () async{
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  loader=true;
                                });
                              await loginProvider.LoginServices(_emailController.text, _passwordController.text);
                              print(loginProvider.LoginInfo["token"].toString());
                               if(loginProvider.LoginInfo["token"]!=null){
                                 print("ssssssssssssssssssssssssssssssssssssssssssssssssssssss");
                                 StorageData.storeValue("token", loginProvider.LoginInfo["token"].toString());
                                 StorageData.storeValue("user_id", loginProvider.LoginInfo["user"]["id"].toString());
                                 StorageData.storeValue("user_name", loginProvider.LoginInfo["user"]["first_name"]+" "+loginProvider.LoginInfo["user"]["last_name"]);
                                 Navigator.pushNamed(context, PageRoutes.bottomNavigation);
                               }
                               else{
                                 DialogMessages.ErrorMessage(context,loginProvider.LoginInfo["error"].toString());
                                 setState(() {
                                   loader=false;
                                 });
                               }
                            }
                          }),
                      SizedBox(height: MediaQuery.of(context).size.height*.03),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, PageRoutes.register);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            locale.donthaveacount!,
                            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 14,decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        locale.orQuickContinueWith!,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              icon: Image.asset('assets/Icons/ic_fb.png',
                                  scale: 2),
                              color: Color(0xff3b45c1),
                              label: locale.facebook,
                              onTap: () {

                              }
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
                              onTap: () {}
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
    ));
  }

  void hiddenPassword(){
    setState(() {
      ishiden=!ishiden;
    });
  }
  String? validateEmail(String? value){
    var locale = AppLocalizations.of(context)!;
    if(value!.isEmpty){
      return locale.enteremail;
    }
    return null;
  }
  String? validatePassword(String? value){
    var locale = AppLocalizations.of(context)!;
    if(value!.isEmpty){
      return locale.enterpassword;
    }
    return null;
  }
}
