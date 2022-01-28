import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Addfavorites {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  // POST API

  Future AddFavoritesDrink(

      //int? id,
      String? name,


      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        //'id': id,
        'name': name,
        // 'created_at': created_at,
        // 'updated_at' : updated_at,

      });

      var response = await dio.post(Constants.BaseUrlPro+Constants.AddFavoriteDrink, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var favoritesData = FavoritesModel.fromJson(response.data);
        // var responce = await dio.get(Constants.BaseUrlPro+Constants.GetFavoriteDrink);
        // var getFavoritesData = responce.data;
        // List favouritesList = [];
        // //FavoritesModel.fromJson(responce.data);
        // for(var det in getFavoritesData){
        //   favouritesList.add(FavoritesModel.fromJson(det).name);
        // }
        // favouritesList.reversed.toList();
        print(favoritesData);
        return favoritesData;
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

  Future AddFavoritesClub(

      //int? id,
      String? name,


      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        //'id': id,
        'name': name,
        // 'created_at': created_at,
        // 'updated_at' : updated_at,

      });

      var response = await dio.post(Constants.BaseUrlPro+Constants.AddFavoriteClub, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var favoritesData = FavoritesModel.fromJson(response.data);

        print(favoritesData);

        return favoritesData;

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

  Future AddFavoritesPartyVacation(

      //int? id,
      String? name,


      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        //'id': id,
        'name': name,
        // 'created_at': created_at,
        // 'updated_at' : updated_at,

      });

      var response = await dio.post(Constants.BaseUrlPro+Constants.AddFavoritePartyVacation, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var favoritesData = FavoritesModel.fromJson(response.data);
        return favoritesData;}
      //user not found
      else {
        return response.data['message'];
      }

    } catch (e) {
      //dynamic exception = e;
      return  (e as DioError).response!.data["message"].toString();
    }
  }


  // GET API

  Future GetFavoritesDrink(

      ) async {
    try {
      /// just login user through phoneNumber and password

      var response = await dio.get(Constants.BaseUrlPro+Constants.GetFavoriteDrink, );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        List<FavoritesModel> favs = ((response.data) as List).map((e) => FavoritesModel.fromJson(e)).toList();
        //var favoritesData = FavoritesModel.fromJson(response.data);
        //print(favoritesData);
        return favs;
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

  Future GetFavoritesClub(

      ) async {
    try {
      /// just login user through phoneNumber and password



      var response = await dio.get(Constants.BaseUrlPro+Constants.GetFavoriteClub, );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        List<FavoritesModel> favsClub = ((response.data) as List).map((e) => FavoritesModel.fromJson(e)).toList();
       // var favoritesData = FavoritesModel.fromJson(response.data);
        //print(favoritesData);

        return favsClub;

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

  Future GetFavoritesPartyVacation(

      ) async {
    try {
      /// just login user through phoneNumber and password



      var response = await dio.get(Constants.BaseUrlPro+Constants.GetFavoritePartyVacation, );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        List<FavoritesModel> favsLocation = ((response.data) as List).map((e) => FavoritesModel.fromJson(e)).toList();
        //var favoritesData = FavoritesModel.fromJson(response.data);
        return favsLocation;}
      //user not found
      else {
        return response.data['message'];
      }

    } catch (e) {
      //dynamic exception = e;
      return  (e as DioError).response!.data["message"].toString();
    }
  }

}
