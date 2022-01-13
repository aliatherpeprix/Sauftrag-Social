import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

        'role' : role,
        'profile_picture' : ''

      });

      var response = await dio.post(Constants.BaseUrl+Constants.Login, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = UserModel.fromJson(response.data["user"]);
        userData.token = response.data["token"];
        return userData;}
      //user not found
      else {
        return response.data['message'];
      }

    } catch (e) {
      // DialogUtils().showDialog(
      //     MyErrorWidget(error: (e as DioError).response!.data["detail"].toString()));

      return (e as DioError).response!.data["detail"].toString();
      // dynamic exception = e;
      // return exception.message;
    }
  }
}
