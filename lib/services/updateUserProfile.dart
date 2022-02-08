import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Updateuser {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future UpdateUser(
      String email,
      String username,
      String password,
      String password2,
      String phone_no,
      String relationship,
      String address,
      String gender,
      String DOB,
      List<int> selectedDrinkList,
      List<int> selectedClubList,
      List<int> selectedVacationList,
      List images,
      String id,
      bool terms,
      bool data,

      )
  async
  {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'email': email,
        'username': username,
        // 'password' : password,
        // 'password2' : password2,
        'phone_no' : phone_no,
        'address' : address,
        'gender' : gender,
        'favorite_alcohol_drinks' : selectedDrinkList,
        'favorite_night_club' : selectedClubList,
        'favorite_party_vacation' : selectedVacationList,
        'terms_conditions' : terms,
        'data_protection' : data,
        'role' : 1,
        if (images[0] is File && (images[0] as File).path.isNotEmpty)"profile_picture": await MultipartFile.fromFile((images[0] as File).path,),
        if (images[1] is File && (images[1] as File).path.isNotEmpty)"catalogue_image1": await MultipartFile.fromFile((images[1] as File).path,),
        if (images[2] is File && (images[2] as File).path.isNotEmpty)"catalogue_image2": await MultipartFile.fromFile((images[2] as File).path,),
        if (images[3] is File && (images[3] as File).path.isNotEmpty)"catalogue_image3": await MultipartFile.fromFile((images[3] as File).path,),
        if (images[4] is File && (images[4] as File).path.isNotEmpty)"catalogue_image4": await MultipartFile.fromFile((images[4] as File).path,),
        if (images[5] is File && (images[5] as File).path.isNotEmpty)"catalogue_image5": await MultipartFile.fromFile((images[5] as File).path,),
      });
      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.patch(Constants.BaseUrlPro+Constants.
      UpdateUserProfile+ id+"/", data: param,options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Authorization": "Token ${user!.token!}"
        }
      ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = UserModel.fromJson(response.data);
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

  Future UpdateUserFavorites(
      List selectedList,
      String favorite
      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        if(favorite=='favorite_alcohol_drinks')'favorite_alcohol_drinks' : selectedList,
        if(favorite=='favorite_night_club')'favorite_night_club' : selectedList,
        if(favorite=='favorite_party_vacation')'favorite_party_vacation' : selectedList,

      });
      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.patch(Constants.BaseUrlPro+Constants.
      UpdateUserProfile+ user!.id.toString()+"/", data: param,options: Options(
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
        var userData = UserModel.fromJson(response.data);
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

  Future UpdateUserProfile(
      String gender,
      List images
      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({
        if (images[0] is File && (images[0] as File).path.isNotEmpty)"profile_picture": await MultipartFile.fromFile((images[0] as File).path,),
        if (images[1] is File && (images[1] as File).path.isNotEmpty)"catalogue_image1": await MultipartFile.fromFile((images[1] as File).path,),
        if (images[2] is File && (images[2] as File).path.isNotEmpty)"catalogue_image2": await MultipartFile.fromFile((images[2] as File).path,),
        if (images[3] is File && (images[3] as File).path.isNotEmpty)"catalogue_image3": await MultipartFile.fromFile((images[3] as File).path,),
        if (images[4] is File && (images[4] as File).path.isNotEmpty)"catalogue_image4": await MultipartFile.fromFile((images[4] as File).path,),
        if (images[5] is File && (images[5] as File).path.isNotEmpty)"catalogue_image5": await MultipartFile.fromFile((images[5] as File).path,),
        'gender' : gender
      });
      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.patch(Constants.BaseUrlPro+Constants.
      UpdateUserProfile+ user!.id.toString()+"/", data: param,options: Options(
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
        var userData = UserModel.fromJson(response.data);
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
