import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class SignupUser {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future SignUpUser(
      String email,
      String username,
      String password,
      String password2,
      String phone_no,
      String relationship,
      String address,
      String gender,
      String DOB,
      List<int> selectedDrinkList,
      List<int> selectedClubList,
      List<int> selectedVacationList,
      List images,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({
        'email': email,
        'username': username,
        'password': password,
        'password2' : password2,
        'phone_no' : phone_no,
        'relation_ship' : relationship,
        'address' : address,
        'gender' : gender,
        'dob' : DOB,
        'selectedDrinkList' : selectedDrinkList,
        'selectedClubList' : selectedClubList,
        'selectedVacationList' : selectedVacationList,
        'role' : 1,
        'bar_kind' : [1]
      });

      var response = await dio.post(Constants.BaseUrlPro+Constants.SignUp, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
       /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = UserModel.fromJson(response.data);
        return userData;}
        //user not found
        else {
          return response.data['message'];
        }

    } catch (e) {
      //dynamic exception = e;
      return  (e as DioError).response!.data["message"].toString();
    }
  }
}
