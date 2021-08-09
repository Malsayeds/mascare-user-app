import 'package:flutter/cupertino.dart';

class LoginInteractor {
  void loginWithMobile(GlobalKey<FormState> formkey,String isoCode, String mobileNumber) {
    if(formkey.currentState!.validate()){
      print("success");
    }
  }
  void loginWithFacebook() {}
  void loginWithGoogle() {}
}
