
import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/faqs_questions.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class UserGetAnotherUser {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future GetAnotherUserInfo(

      String user_id

      ) async {
    try {
      UserModel? barModel = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.GetUserToUserInfo,
          queryParameters:{ 'user_id' : user_id },
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${barModel!.token!}"
              }
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {

        // var faqs = (response.data);
        //List<FaqsModel> Faq = faqs[1]['question'];
        UserModel user = UserModel.fromJson(response.data[0]);
        return user;
      }

      //user not found
      else {
        return response.data['message'];
      }

    }
    catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }
}