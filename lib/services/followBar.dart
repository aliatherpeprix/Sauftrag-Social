import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/follow_bar.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Followbar {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future FollowBar(

      int follow_id,
      bool isFollow,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'follow_id': follow_id,
        'isFollow' : isFollow,

      });

      var response = await dio.post(Constants.BaseUrlPro+Constants.FollowBar, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = FollowBAR.fromJson(response.data);
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
