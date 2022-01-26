import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class SignupBar {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future SignUpBar(
      String bar_name,
      String address,
      String email,
      String password,
      String password2,

      ) async {
    try {

      var param = FormData.fromMap({
        'bar_name': bar_name,
        'username' : bar_name,
        'address' : address,
        'email' : email,
        'password': password,
        'password2' : password2,
        'role' : 2,
        'profile_picture' : ''

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
      return  (e as DioError).response!.data["message"].toString();
    }
  }
}
