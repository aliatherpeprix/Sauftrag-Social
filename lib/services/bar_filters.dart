import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/get_bar_upcoming_event.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Barfilters {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

    Future  BarFilters(

      String user_id__bar_name__icontains,
      int? user_id__bar_kind__id,
      int? selectedTimeDate,
      double distance_range_start,
      double distance_range_end,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = {

        'user_id__bar_name__icontains': user_id__bar_name__icontains,
          if( user_id__bar_kind__id!=null ) 'user_id__bar_kind__id' : user_id__bar_kind__id,
          if( selectedTimeDate!=null && selectedTimeDate == 0 ) 'is_today' : "True",
          if( selectedTimeDate!=null && selectedTimeDate == 1 ) "is_tomorrow" : "True",
          if( selectedTimeDate!=null && selectedTimeDate == 2 ) "is_week" : "True",
          "distance_range_start" : distance_range_start,
          "distance_range_end" : distance_range_end

      };

      UserModel? userModel = (await locator<PrefrencesViewModel>().getUser());
      var response = await dio.get(Constants.BaseUrlPro+Constants.filterEvents,
          queryParameters: param,
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
        List<GetEvent> getEventByFilter = (response.data as List).map((e) => GetEvent.fromJson(e)).toList();
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
