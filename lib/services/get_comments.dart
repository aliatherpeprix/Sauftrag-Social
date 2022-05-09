
import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/comments.dart';
import 'package:sauftrag/models/get_comments_user.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class GetComments {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future getComments(

      int postId,

      ) async {
    try {
      UserModel? userModel = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.get(
          Constants.BaseUrlPro + Constants.GetNewFeedComments + postId.toString() +"/",
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {"Authorization": "Token ${userModel!.token!}"}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        List<GetNewsfeedComments> postData = (response.data as List).map((e) => GetNewsfeedComments.fromJson(e)).toList();
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