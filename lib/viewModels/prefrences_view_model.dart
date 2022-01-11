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

   Future<UserModel> getUser (UserModel user) async {
    UserModel? user = UserModel.fromJson(jsonDecode(await preferences!.getString("user")!)) ?? null;
    return user!;
  }


  
}