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

class UpdateUser {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future updateUser(
      int userId,
      String country_code,
      String phone_no,
      String about,
      dynamic gender,
      String userAddress,
      String dob,
      dynamic relation_ship,
      int role,
      List<dynamic> favorite_alcohol_drinks,
      List<dynamic> favorite_musics,
      List<dynamic> favorite_party_vacation,
      //String profilePicture,
      List images,
      bool terms_conditions,
      bool data_protection,
      String password,
      String password2,

      )
  async
  {
    try {
      var param = FormData.fromMap({

        "country_code": country_code,
        "phone_no": phone_no,
        "about": about,
        "gender": gender,
        "address": userAddress,
        "dob": dob,
        "relation_ship": relation_ship,
        "role": role,
        "favorite_alcohol_drinks": favorite_alcohol_drinks,
        "favorite_musics": favorite_musics,
        "favorite_party_vacation": favorite_party_vacation,
        "catalogue_image1": null,
        "catalogue_image2": null,
        "catalogue_image3": null,
        "catalogue_image4": null,
        "catalogue_image5": null,
        "terms_conditions": true,
        "data_protection": true,
        "password": "ZXC!asd123",
        "password2": "ZXC!asd123",
        //"profile_picture" : profilePicture,
        //if (images[0] is File && (images[0] as File).path.isNotEmpty)"profile_picture": await MultipartFile.fromFile((images[0] as File).path,),
        if (images[0] is File && (images[0] as File).path.isNotEmpty)"catalogue_image1": await MultipartFile.fromFile((images[1] as File).path,),
        if (images[1] is File && (images[1] as File).path.isNotEmpty)"catalogue_image2": await MultipartFile.fromFile((images[2] as File).path,),
        if (images[2] is File && (images[2] as File).path.isNotEmpty)"catalogue_image3": await MultipartFile.fromFile((images[3] as File).path,),
        if (images[3] is File && (images[3] as File).path.isNotEmpty)"catalogue_image4": await MultipartFile.fromFile((images[4] as File).path,),
        if (images[4] is File && (images[4] as File).path.isNotEmpty)"catalogue_image5": await MultipartFile.fromFile((images[5] as File).path,),
      });
      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.patch(Constants.BaseUrlPro+Constants.
      UpdateUserProfile+ "${userId}"+"/", data: param,options: Options(
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
      print(e);
      return  "yo";
        //(e as DioError).response!.data["message"].toString();
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

        if (images[0] is File && (images[0] as File).path.isNotEmpty)
          "profile_picture": await MultipartFile.fromFile((images[0] as File).path,)
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


  Future UpdateAccountDetails(
      String phone_no,
      String address,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'phone_no' : phone_no,
        'address' : address,

      });
      UserModel? user = await locator<PrefrencesViewModel>().getUser();
      var response = await dio.patch(Constants.BaseUrlPro+Constants.
      UpdateUserProfile+ user!.id.toString()+"/", data: param,options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Token ${user.token!}"
          }
      ));
      print(response);
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
