import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class Updatebar {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future UpdateBar(
      String bar_name,
      String address,
      String email,
      String password,
      String password2,
      List images,
      List<int> selectedWeekDays,
      List<int> selectedWeekendDays,
      //List<int> selectedBarKind,
      String id,
      String opening_time,
      String closing_time,
      String break_opening_time,
      String break_closing_time,
      String weekend_opening_time,
      String weekend_closing_time,
      String weekend_break_opening_time,
      String weekend_break_closing_time
      )
  async
  {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'bar_name': bar_name,
        'address': address,
        // 'password' : password,
        // 'password2' : password2,
        'email' : email,
        'working_days' : selectedWeekDays,
        'weekend_days' : selectedWeekendDays,
        'opening_time' : opening_time,
        'closing_time' : closing_time,
        'break_opening_time' : break_opening_time,
        'break_closing_time' : break_closing_time,
        'weekend_opening_time' : weekend_opening_time,
        'weekend_closing_time' : weekend_closing_time,
        'weekend_break_opening_time' : weekend_break_opening_time,
        'weekend_break_closing_time' : weekend_break_closing_time,
        'role' : 2,

        if (images[0] is File && (images[0] as File).path.isNotEmpty)"profile_picture": await MultipartFile.fromFile((images[0] as File).path,),
        if (images[1] is File && (images[1] as File).path.isNotEmpty)"catalogue_image1": await MultipartFile.fromFile((images[1] as File).path,),
        if (images[2] is File && (images[2] as File).path.isNotEmpty)"catalogue_image2": await MultipartFile.fromFile((images[2] as File).path,),
        if (images[3] is File && (images[3] as File).path.isNotEmpty)"catalogue_image3": await MultipartFile.fromFile((images[3] as File).path,),
        if (images[4] is File && (images[4] as File).path.isNotEmpty)"catalogue_image4": await MultipartFile.fromFile((images[4] as File).path,),
        if (images[5] is File && (images[5] as File).path.isNotEmpty)"catalogue_image5": await MultipartFile.fromFile((images[5] as File).path,),
      });
      BarModel? user = (await locator<PrefrencesViewModel>().getUser()) as BarModel?;
      var response = await dio.patch(Constants.BaseUrlPro+Constants.
      UpdateUserProfile+ id+"/", data: param,options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Token ${user!.token!}"
          }
      )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = BarModel.fromJson(response.data);
        return userData;
      }
      //user not found
      else {
        return response.data['message'];
      }

    } catch (e) {
      //dynamic exception = e;
      return  (e as DioError).response!.data["message"].toString();
    }
  }

  Future UpdateBarProfile(
    String bar_name,
    List images
      ) async
  {
   try{
     var param = FormData.fromMap({

       'bar_name': bar_name,


       if (images[0] is File && (images[0] as File).path.isNotEmpty)
         "profile_picture": await MultipartFile.fromFile((images[0] as File).path,)
       else if (images[0] is String) "profile_picture" : null
       else "profile_picture" : "",


       if (images[1] is File && (images[1] as File).path.isNotEmpty)
         "catalogue_image1": await MultipartFile.fromFile((images[1] as File).path,)
       else if (images[1] is String) "catalogue_image1" : null
       else "catalogue_image1" : "",


       if (images[2] is File && (images[2] as File).path.isNotEmpty)
         "catalogue_image2": await MultipartFile.fromFile((images[2] as File).path,)
       else if (images[2] is String) "catalogue_image2" : null
       else "catalogue_image2" : "",


       if (images[3] is File && (images[3] as File).path.isNotEmpty)
         "catalogue_image3": await MultipartFile.fromFile((images[3] as File).path,)
       else if (images[3] is String) "catalogue_image3" : null
       else "catalogue_image3" : "",


       if (images[4] is File && (images[4] as File).path.isNotEmpty)
         "catalogue_image4": await MultipartFile.fromFile((images[4] as File).path,)
       else if (images[4] is String) "catalogue_image4" : null
       else "catalogue_image4" : "",


       if (images[5] is File && (images[5] as File).path.isNotEmpty)
         "catalogue_image5": await MultipartFile.fromFile((images[5] as File).path,)
       else if (images[5] is String) "catalogue_image5" : null
       else "catalogue_image5" : "",

      });
     NewBarModel? user = await locator<PrefrencesViewModel>().getBarUser();
     var response = await dio.patch(Constants.BaseUrlPro+Constants.
     UpdateBarProfile+ user!.id.toString()+"/", data: param,options: Options(
         contentType: Headers.formUrlEncodedContentType,
         headers: {
           "Authorization": "Token ${user.token!}"
         }
     ));
     if (response.statusCode == 200 || response.statusCode == 201) {
       // user found
       /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
       var userData = NewBarModel.fromJson(response.data);
       return userData;
     }
     //user not found
     else {
       return response.data['message'];
     }

  } catch (e) {
  print(e);
  //dynamic exception = e;
  return  (e as DioError).response!.data["message"].toString();
  }
  }
}