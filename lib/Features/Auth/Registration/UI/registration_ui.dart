import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Auth/RegisterProvider.dart';
import 'package:doctoworld_user/Routes/routes.dart';
import 'package:doctoworld_user/Stroage/StorageData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'registration_interactor.dart';
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterProvider(), child: RegistrationUI());
  }
}

class RegistrationUI extends StatefulWidget {
 RegistrationInteractor registrationInteractor=new RegistrationInteractor();
 //String phoneNumber;

  RegistrationUI();

  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailNode=new FocusNode();
  FocusNode passwordNode=new FocusNode();
  FocusNode lastNode=new FocusNode();
  FocusNode phoneNode=new FocusNode();
  final formKey=GlobalKey<FormState>();
  bool ishiden=true;

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  bool loader=false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final registerProvider= Provider.of<RegisterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.registerNow!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FadedSlideAnimation(
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
            //    Spacer(),
          /*      SizedBox(height: 10.0),
                Text(
                  locale.yourPhoneNumberNotRegistered!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),*/
               // SizedBox(height: 10.0),
            //    Spacer(),
                 Form(
                   key: formKey,
                   child: Column(
                     children: [
                       SizedBox(height: 20.0),
                       EntryField(
                         onValidate:validateName,
                         focusNode: lastNode,
                         controller: _firstController,
                         prefixIcon: Icon(Icons.person,color:Theme.of(context).primaryColor),
                         hint: locale.firstname,
                       ),
                       SizedBox(height: 20.0),
                       EntryField(
                         OwnFocusNode: lastNode,
                         onValidate:validateName,
                         focusNode: phoneNode,
                         controller: _lastController,
                         prefixIcon: Icon(Icons.person,color:Theme.of(context).primaryColor),
                         hint: locale.lastname,
                       ),
                       SizedBox(height: 20.0),
                       EntryField(
                         textInputType: TextInputType.phone,
                         OwnFocusNode: phoneNode,
                         onValidate: validatePhone,
                         focusNode: emailNode,
                         prefixIcon: Icon(Icons.phone_iphone,color:Theme.of(context).primaryColor),
                         hint: locale.mobileNumber,
                         controller: _phoneController,
                         //initialValue: widget.phoneNumber,
                         readOnly: false,
                       ),
                       SizedBox(height: 20.0),
                       EntryField(
                         textInputType: TextInputType.emailAddress,
                         onValidate: validateEmail,
                         OwnFocusNode: emailNode,
                         focusNode: passwordNode,
                         controller: _emailController,
                         prefixIcon: Icon(Icons.mail,color:Theme.of(context).primaryColor),
                         hint: locale.emailAddress,
                       ),
                       SizedBox(height: 20.0),
                       EntryField(
                         onValidate: validatePassword,
                         OwnFocusNode: passwordNode,
                         focusNode: FocusNode(),
                         hint: locale.enterpassword,
                         prefixIcon:ishiden?
                         InkWell(onTap: ()=>hiddenPassword(),child: Icon(Icons.visibility_outlined,color:Theme.of(context).primaryColor),):
                         InkWell(onTap: ()=>hiddenPassword(),child:Icon(Icons.visibility_off_outlined,color:Theme.of(context).primaryColor)),
                         // color: Theme.of(context).scaffoldBackgroundColor,
                         controller: _passwordController,
                         isHidden: ishiden,
                       ),
                       SizedBox(height: 20.0),
                     ],
                   ),
                 ),
                CustomButton(
                  color: loader?Colors.black26:Theme.of(context).primaryColor,
                  onTap: () async{
                    if(formKey.currentState!.validate()){
                      setState(() {
                        loader=true;
                      });
                        await registerProvider.RegisterServices(_firstController.text,_lastController.text,_emailController.text,_passwordController.text, _phoneController.text);
                        if(registerProvider.RegisterInfo["token"]!=null){
                          StorageData.storeValue("token", registerProvider.RegisterInfo["token"].toString());
                          StorageData.storeValue("user_id", registerProvider.RegisterInfo["user"]["id"].toString());
                          StorageData.storeValue("user_name", _firstController.text+" "+_lastController.text);
                          Navigator.pushNamed(context, PageRoutes.bottomNavigation);
                        }
                        else{
                          DialogMessages.ErrorMessage(context,registerProvider.RegisterInfo["error"].toString());
                          setState(() {
                            loader=false;
                          });
                        }
                      }
                    }

                ),
                SizedBox(height: 10.0),
                CustomButton(
                  label: locale.backToSignIn,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  textColor: Theme.of(context).hintColor,
                  onTap: widget.registrationInteractor.goBack,
                ),
               // Spacer(flex: 5),
                Text(
                  locale.wellSendAnOTP!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                //Spacer(),
              ],
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
  void hiddenPassword(){
    setState(() {
      ishiden=!ishiden;
    });
  }
  String? validateName(String? value){
    var locale = AppLocalizations.of(context)!;
    if(value!.isEmpty){
      return locale.entername;
    }
    return null;
  }
  String? validateEmail(String? value){
    var locale = AppLocalizations.of(context)!;
    if(value!.isEmpty){
      return locale.enteremail;
    }
    return null;
  }
  String? validatePhone(String? value){
    var locale = AppLocalizations.of(context)!;
    if(value!.isEmpty){
      return locale.enterMobileNumber;
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
