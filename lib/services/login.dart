import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/widgets/error_widget.dart';

class LoginUser {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future LogInUser(
    String username,
    String password,
    String role,
  ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({
        'username': username,
        'password': password,
        'role': role,
        'profile_picture': ''
      });

      var response = await dio.post(Constants.BaseUrlPro + Constants.Login, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var user;
        if (response.data["user"]["bar_name"] != null) {
          user = NewBarModel.fromJson(response.data["user"]);
          (user as NewBarModel).token = response.data["token"];
        } else {
          user = UserModel.fromJson(response.data["user"]);
          user.token = response.data["token"];
        }

        return user;
      }
      //user not found
      else {
        return response.data['message'];
      }
    }
    on DioError catch (e) {

      if(e.response!.statusCode == 500) {
        return "abc";
      }

      if ((e as DioError).response!.data is Map &&
          (e).response!.data["detail"] != null) {
        DialogUtils().showDialog(
            MyErrorWidget(error: (e).response!.data["detail"].toString()));
      } else {
        DialogUtils().showDialog(
            MyErrorWidget(error: "Unable to login with provided credentials"));
        //return (e).error.toString();
      }

      print(e);
      //return (e as DioError).response!.data["detail"];
      // dynamic exception = e;
      // return exception.message;
    }
  }
}
