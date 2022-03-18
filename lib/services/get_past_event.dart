import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/faqs_questions.dart';
import 'package:sauftrag/models/get_bar_followers.dart';
import 'package:sauftrag/models/get_bar_upcoming_event.dart';
import 'package:sauftrag/models/listOfFollowing_Bars.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class PastEvents {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future GetPastEvents(


      ) async {
    try {

      UserModel? user = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.GetPastEvent,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${user!.token!}"
              }
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {

        var faqs = (response.data);
        //List<FaqsModel> Faq = faqs[1]['question'];
        //print("jhjg");
        List<GetEvent> getupcomingevents = (response.data as List).map((e) =>
            GetEvent.fromJson(e)).toList();
        // getbarfollowers.removeWhere((element) => element.role==2);
        return getupcomingevents;
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