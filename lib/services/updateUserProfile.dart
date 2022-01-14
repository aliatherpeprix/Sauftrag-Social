import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class SignupUser {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future SignUpUser(
      String profile_picture,
      String catalogue_image1,
      String catalogue_image2,
      String catalogue_image3,
      String catalogue_image4,
      String catalogue_image5,
      String favorite_alcohol_drinks,
      String favorite_night_club,
      String favorite_party_vacation,
      String gender,
      String id,

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({
        'profile_picture': profile_picture,
        'catalogue_image1': catalogue_image1,
        'catalogue_image2': catalogue_image2,
        'catalogue_image3' : catalogue_image3,
        'catalogue_image4' : catalogue_image4,
        'catalogue_image5' : catalogue_image5,
        'favorite_alcohol_drinks' : favorite_alcohol_drinks,
        'favorite_night_club' : favorite_night_club,
        'favorite_party_vacation' : favorite_party_vacation,
        'gender' : gender,
        'role' : 1,

      });

      var response = await dio.post(Constants.BaseUrl+Constants.UpdateUserProfile+ id, data: param);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        /* if (response.data["status"] == 200) {
          var userData = UserModel.fromJson(response.data['data']);
          return userData;
        }*/
        var userData = UserModel.fromJson(response.data);
        return userData;}
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
