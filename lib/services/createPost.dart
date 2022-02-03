import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime/mime.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/create_bar_post.dart';
import 'package:sauftrag/models/get_newsfeed.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/newsfeed_post_id.dart';
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
      List files = [];
      for (File data in images){
        if (data.path.isNotEmpty){
          String media = "data:${lookupMimeType(data.path)};base64," +
              base64Encode(data.readAsBytesSync());
          files.add(media);
        }
      }
      var param = {
        'post_type' : post_type,
        'post_location' : post_location,
        'post_content' : post_content,
        'media' : files
      };
      // var param = FormData.fromMap({
      //
      //   'post_type' : post_type,
      //   'post_location' : post_location,
      //   'post_content' : post_content,
      //   'media' : files
      //   //if (images[0] is File && (images[0] as File).path.isNotEmpty)"media": await MultipartFile.fromFile((images[0] as File).path,),
      // });

      NewBarModel? barModel = (await locator<PrefrencesViewModel>().getBarUser());
      var response = await dio.post(Constants.BaseUrlPro+Constants.CreateNewFeed, data: param,
          options: Options(
          // contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Token ${barModel!.token!}"
          }
      ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var postData = CreateBarPost.fromJson(response.data);
        return postData;}
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

  Future GetPost()
  async
  {
    try{
      NewBarModel? barModel = (await locator<PrefrencesViewModel>().getBarUser());
      var getResponse = await dio.get(Constants.BaseUrlPro+Constants.GetNewFeed,
          options: Options(
        // contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Token ${barModel!.token!}"
          }
      ));
      if (getResponse.statusCode == 200 || getResponse.statusCode == 201) {

        List<NewsfeedPostId> getBarPost = (getResponse.data as List).map((e) =>
            NewsfeedPostId.fromJson(e)).toList();

        print(getBarPost);
        return getBarPost;
      }

      //user not found
      else {
        return getResponse.data['message'];
      }

    }
    catch (e) {
      print(e);
      return  (e as DioError).response!.data["message"].toString();
    }
  }
}
