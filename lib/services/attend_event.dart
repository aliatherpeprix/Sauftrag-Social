import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/follow_bar.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Attendevent {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future AttendEvent(

      int event_id,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'event_id': event_id,

      });

      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.post(Constants.BaseUrlPro+Constants.AttendEvent, data: param,
          options: Options(
            //contentType: Headers.formUrlEncodedContentType,
              headers: {'Authorization': 'Token ${user!.token!}'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
          //var userData = response.data["details"];
        return true;
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

  Future RemoveAttendEvent(

      int event_id,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'event_id': event_id,

      });

      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.delete(Constants.BaseUrlPro + Constants.RemoveAttendEvent
         +"?event_id=" + event_id.toString() , data: param,
          options: Options(
            //contentType: Headers.formUrlEncodedContentType,
              headers: {'Authorization': 'Token ${user!.token!}'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        //var userData = response.data["details"];
        return true;
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
