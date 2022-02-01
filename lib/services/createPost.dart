import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Createpost {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future CreatePost(

      dynamic post_type,
      String post_location,
      String post_content,
      List images,
      )
  async
  {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'post_type' : post_type,
        'post_location' : post_location,
        'post_content' : post_content,
        if (images[0] is File && (images[0] as File).path.isNotEmpty)"media": await MultipartFile.fromFile((images[0] as File).path,),

      });

      BarModel? user = (await locator<PrefrencesViewModel>().getBarUser()) as BarModel?;
      var response = await dio.post(Constants.BaseUrlPro+Constants.CreateNewFeed, data: param,
          options: Options(
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
        return userData;}
      //user not found
      else {
        return response.data['message'];
      }

    } catch (e) {
      print(e);
      //dynamic exception = e;
      return  (e as DioError).response!.data["message"].toString();
    }
  }
}
