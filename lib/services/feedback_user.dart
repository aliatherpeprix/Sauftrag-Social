import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/follow_bar.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

import '../models/user_feedback.dart';

class Userfeedback {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future UserFeedback(

      String? message,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'message': message,

      });

      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.post(Constants.BaseUrlPro+Constants.feedback, data: param,
          options: Options(
            //contentType: Headers.formUrlEncodedContentType,
              headers: {'Authorization': 'Token ${user!.token!}'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = UserFeedBack.fromJson(response.data);
        return userData;}
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
