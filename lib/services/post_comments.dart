
import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/comments.dart';
import 'package:sauftrag/models/comments_bar.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class PostComments {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future postComments(

      String text,
      int post,
      ) async {
    try {
      var param = {
        'text': text,
        'post': post,
      };
      UserModel? userModel = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.post(
          Constants.BaseUrlPro + Constants.PostNewFeedComments,
          data: param,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${userModel!.token!}"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var postData = NewsfeedComments.fromJson(response.data);
        return postData;
      }
      //user not found
      else {
        return response.data['message'];
      }
    } catch (e) {
      print(e);
      //dynamic exception = e;
      return (e as DioError).response!.data["message"].toString();
    }
  }


  Future postCommentsBar(

      String text,
      int post,
      ) async {
    try {
      var param = {
        'text': text,
        'post': post,
      };
      NewBarModel? userModel = (await locator<PrefrencesViewModel>().getBarUser());
      var response = await dio.post(
          Constants.BaseUrlPro + Constants.PostNewFeedComments,
          data: param,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${userModel!.token!}"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var postData = NewsfeedCommentsBar.fromJson(response.data);
        return postData;
      }
      //user not found
      else {
        return response.data['message'];
      }
    } catch (e) {
      print(e);
      //dynamic exception = e;
      return (e as DioError).response!.data["message"].toString();
    }
  }
}