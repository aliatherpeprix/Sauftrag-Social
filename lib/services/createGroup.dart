import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/create_group_chat.dart';
import 'package:sauftrag/models/get_bar_upcoming_event.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/UserFriendList/create_group.dart';

class Creategroup {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future CreateGroup(

      String name,
      List listOfUsers,
      int? privacy,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'name' : name,
        'users' : listOfUsers,
        'privacy' : privacy

      });

      UserModel? userModel = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.post(Constants.BaseUrlPro+Constants.createGroup,
          data: param,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${userModel!.token!}"
              }
          )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        CreateGroupChat getEventByFilter = CreateGroupChat.fromJson(response.data);
        return getEventByFilter;
      }
      //user not found
      else {
        return response.data['message'];
      }

    } catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }
}
