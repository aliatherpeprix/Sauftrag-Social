
import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/faqs_questions.dart';
import 'package:sauftrag/models/get_bar_followers.dart';
import 'package:sauftrag/models/listOfFollowing_Bars.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

import '../models/get_bar_follower_list.dart';
import '../models/get_bar_follower_list.dart';
import '../models/get_bar_follower_list.dart';
import '../models/get_bar_follower_list.dart';

class   BARFollowers {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future GetBarFollowers(


      ) async {
    try {

      NewBarModel? user = (await locator<PrefrencesViewModel>().getBarUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.followersList,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${user!.token!}"
              }
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {

        // var faqs = (response.data);
        //List<FaqsModel> Faq = faqs[1]['question'];
        print("jhjg");
        List<GetBarFollower> getbarfollowers = (response.data as List).map((e) =>
            GetBarFollower.fromJson(e)).toList();
       // getbarfollowers.removeWhere((element) => element.role==2);
        return getbarfollowers;
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

  Future GetBarFollowersLists(


      ) async {
    try {

      NewBarModel? user = (await locator<PrefrencesViewModel>().getBarUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.followersList,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${user!.token!}"
              }
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {

        // var faqs = (response.data);
        //List<FaqsModel> Faq = faqs[1]['question'];
        print("jhjg");
        List<GetBarFollowersList> getbarfollowers = (response.data as List).map((e) =>
            GetBarFollowersList.fromJson(e)).toList();
        // getbarfollowers.removeWhere((element) => element.role==2);
        return getbarfollowers;
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