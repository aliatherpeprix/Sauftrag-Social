
import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class   UserDetails {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future GetUserDetails(
      ) async {
    try {

      UserModel? user = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.getUserDetails,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${user!.token!}"
              }
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {

        var faqs = (response.data);
        //List<FaqsModel> Faq = faqs[1]['question'];
        List<UserModel> getUserDetails = (response.data as List).map((e) =>
            UserModel.fromJson(e)).toList();
        // getbarfollowers.removeWhere((element) => element.role==2);
        return getUserDetails;
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