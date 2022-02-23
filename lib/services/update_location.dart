import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Updatelocation {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future UpdateLocation(

      String latitude,
      String longitude,
      String id,
      )
  async
  {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'latitude' : latitude,
        'longitude' : longitude,
        'role' : 1,

       });
      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.patch(Constants.BaseUrlPro+Constants.
      UpdateUserProfile+ id+"/", data: param,options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Token ${user!.token!}"
          }
      ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = UserModel.fromJson(response.data);
        return userData;
      }
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
