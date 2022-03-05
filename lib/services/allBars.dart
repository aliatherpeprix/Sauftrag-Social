
import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/faqs_questions.dart';
import 'package:sauftrag/models/listOfFollowing_Bars.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class AllBarUsers {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future GetAllBarUsers(


      ) async {
    try {

      UserModel? user = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.AllUsers,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${user!.token!}"
              }
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {

        // var faqs = (response.data);
        //List<FaqsModel> Faq = faqs[1]['question'];
        List<ListOfBarsModel> allusers = (response.data["bars"] as List).map((e) =>
            ListOfBarsModel.fromJson(e)).toList();
        allusers.removeWhere((element) => element.role==1);
        return allusers;
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