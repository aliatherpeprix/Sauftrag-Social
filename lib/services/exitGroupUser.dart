import 'dart:convert';

import 'package:dio/dio.dart';

import '../app/locator.dart';
import '../models/report_chat.dart';
import '../models/user_models.dart';
import '../utils/constants.dart';
import '../viewModels/prefrences_view_model.dart';

class ExitGroupuser {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future ExitGroupUser(int id

      /* String? chat,
      String? chat_user_email,
      String? chat_user_name*/

      ) async {
    try {
      /// just login user through phoneNumber and password


      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.post(
          Constants.BaseUrlPro + Constants.exitGroupUser + "/${id}/" ,
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {'Authorization': 'Token ${user!.token!}'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var jsonData = (response.data);
        print(jsonData);
      }
      //user not found
      else {
        return response.data['message'];
      }

    } catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }
}