import 'dart:io';

import 'package:get/get.dart';
import 'package:sauftrag/models/user_models.dart';
/*
  type : Class
  packages used: Getx
  function: this is the controller class that listens to user object changes when user is registering
 */
class OnboardingController extends GetxController{
  Rx<UserModel> _user = UserModel().obs;
  UserModel get onboardingUser => _user.value;
  set onboardata(UserModel value) => this._user.value = value;
  RxBool loading = false.obs;

  //set imageurl(String value) => this._user.value.profile_picture = value;
  set imageFile(String value) => this._user.value.profile_picture = value;
  // set fullName(String value) => this._user.value.fullName = value;
  // set email(String value) => this._user.value.email = value;
  // set password(String value) => this._user.value.password = value;
  // set username(String value) => this._user.value.username = value;
  // set phonenumber(String value) => this._user.value.phonenumber = value;
}