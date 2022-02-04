import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/newsfeed_post_id.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Termscondition {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future GetTermsCondition(


      ) async {
    try {

      NewBarModel? barModel = (await locator<PrefrencesViewModel>().getBarUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.GetTermsAndConditions,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${barModel!.token!}"
              }
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {

        var termsCondition = (response.data);
        String termAndCondition = termsCondition[0]['terms_of_use'];
        //print();

        // List<NewsfeedPostId> getBarPost = (response.data as List).map((e) =>
        //     NewsfeedPostId.fromJson(e)).toList();

        //print(termsOfservices);
        return termAndCondition;
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
