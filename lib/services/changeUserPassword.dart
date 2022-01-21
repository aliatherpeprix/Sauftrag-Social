
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/widgets/error_widget.dart';

class Changeuserpassword {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future ChangeUserPassword(

      String old_password,
      String new_password,

      ) async
  {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'old_password': old_password,
        'new_password': new_password,

      });

      UserModel? user = UserModel();
      user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.post(
          Constants.BaseUrlPro + Constants.ChangeUserPassword, data: param,
          options: Options(
              headers: {
                "Authorization": "Token ${user!.token!}"
              }));
          if (response.statusCode == 200 || response.statusCode == 201)
      {
        // user found
        if (response.data["email"] == 200) {
          /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
          // print(response.data);
          // var userData = UserModel.fromJson(response.data);
          return response.data["email"];
        }
        //user not found
        else {
          DialogUtils().showDialog(
              MyErrorWidget(error: response.data["message"].toString()));

          //return response.data['message'];
        }
      }
    } catch (e) {
      return;
      // dynamic exception = e;
      // return exception.message;
    }
  }
}
