import 'dart:convert';

import 'package:sauftrag/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class PrefrencesViewModel extends BaseViewModel{
  SharedPreferences? preferences;
  
  Future init() async{
      preferences = await SharedPreferences.getInstance();
  }
  
  Future saveUser(UserModel user)async{
    await preferences!.setString("user", jsonEncode(user.toJson()));
  }

  String getUser (UserModel user){
    return preferences!.getString("user") ?? "";
  }
  
}