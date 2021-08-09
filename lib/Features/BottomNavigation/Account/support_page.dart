import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_user/Features/Components/DialogMessages.dart';
import 'package:doctoworld_user/Features/Components/custom_button.dart';
import 'package:doctoworld_user/Features/Components/entry_field.dart';
import 'package:doctoworld_user/Locale/locale.dart';
import 'package:doctoworld_user/Provider/Account/ContactProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SupportPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ContactProvider(), child: SupportScreesn());
  }
}

class SupportScreesn extends StatefulWidget {
  @override
  _SupportScreesnState createState() => _SupportScreesnState();
}

class _SupportScreesnState extends State<SupportScreesn> {
  TextEditingController email=new TextEditingController();
  TextEditingController message =new TextEditingController();
  final formKey=GlobalKey<FormState>();
  FocusNode messageNode=new FocusNode();
  bool loader=false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var contactProvider= Provider.of<ContactProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.support!),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FadedSlideAnimation(
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.howMayWeHelpYou!,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  locale.letUsKnowUrQueriesFeedbacks!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                SizedBox(height: 10.0),
               Form(
                 key: formKey,
                 child: Column(
                  children: [
                    EntryField(
                        prefixIcon: Icon(Icons.mail,color:Theme.of(context).primaryColor),
                        onValidate: validateEmail,
                        controller: email,
                        focusNode: messageNode,
                        hint: locale.emailAddress),
                    SizedBox(height: 12.0),
                    EntryField(
                      OwnFocusNode: messageNode,
                      controller: message,
                      focusNode: FocusNode(),
                      onValidate: validateMessage,
                      prefixIcon: Icon(Icons.edit,color:Theme.of(context).primaryColor),
                      hint: locale.writeYourMsg,
                      maxLines: 4,
                    ),
                   ],
                  ),
                ),
                SizedBox(height: 10.0),
                CustomButton(
                  color: loader?Colors.black12:Theme.of(context).primaryColor,
                label: locale.submit,onTap: (){
                if(formKey.currentState!.validate()){
                  setState(() {
                    loader=true;
                  });
               contactProvider.contactServices(email.text, message.text);
               if(contactProvider.contactInfo["message"]!=""){
                 DialogMessages.SuccessMessage(context, contactProvider.contactInfo["message"]);
                setState(() {
                  email.text="";
                  message.text="";
                  loader=false;
                });
               }
                }
                },),
                SizedBox(height: 10.0),
                FadedScaleAnimation(
                  Image.asset(
                    'assets/hero_image.png',
                    height: 200,
                  ),
                  durationInMilliseconds: 400,
                )
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
  String? validateEmail(String? value){
    var locale = AppLocalizations.of(context)!;
    if(value!.isEmpty){
      return locale.enteremail;
    }
    return null;
  }
  String? validateMessage(String? value){
    var locale = AppLocalizations.of(context)!;
    if(value!.isEmpty){
      return locale.enteremail;
    }
    return null;
  }
  Submit(BuildContext context){
    if(formKey.currentState!.validate()){

    }
  }
}
