import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:path/path.dart' as path;
import 'package:sauftrag/widgets/error_widget.dart';

class SignupBar {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future SignUpBar(
    String userName,
    String barName,
    String email,
    String about,
    String address,
    int role,
    List<int> barKind,
    List<int> workingDays,
    String openingTime,
    String closingTime,
    String breakOpeningTime,
    String breakClosingTime,
    List<int> weekendDays,
    String weekendOpeningTime,
    String weekendClosingTime,
    String weekendBreakOpeningTime,
    String weekendBreakClosingTime,
    File barLogo,
    File catalogueImage1,
    File catalogueImage2,
    File catalogueImage3,
    File catalogueImage4,
    File catalogueImage5,
    bool termsConditions,
    bool dataProtection,
    String password,
    String password2,
    double latitude,
    double longitude,
  ) async {

    try {
      var param = FormData.fromMap({
        'username': userName,
        'bar_name': barName,
        'email': email,
        'about' : about,
        'address': address,
        'role': "2",
        'bar_kind': [2],
        'working_days': workingDays,
        'opening_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(openingTime)),
        'closing_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(closingTime)),
        if(breakOpeningTime != '') 'break_opening_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(breakOpeningTime)),
        if(breakClosingTime != '') 'break_closing_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(breakClosingTime)),
        'weekend_days': weekendDays,
        'weekend_opening_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(weekendOpeningTime)),
        'weekend_closing_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(weekendClosingTime)),
        if(weekendBreakOpeningTime != '') 'weekend_break_opening_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(weekendBreakOpeningTime)),
        if(weekendBreakClosingTime != '') 'weekend_break_closing_time': DateFormat("H:mm").format(DateFormat("hh:mm a").parse(weekendBreakClosingTime)),
        if (barLogo.path.isNotEmpty)'profile_picture': await MultipartFile.fromFile(barLogo.path, filename: path.basename(barLogo.path)),
        if (catalogueImage1.path.isNotEmpty)'catalogue_image1': await MultipartFile.fromFile(catalogueImage1.path, filename: path.basename(catalogueImage1.path)),
        if (catalogueImage2.path.isNotEmpty)'catalogue_image2': await MultipartFile.fromFile(catalogueImage2.path, filename: path.basename(catalogueImage2.path)),
        if (catalogueImage3.path.isNotEmpty)'catalogue_image3': await MultipartFile.fromFile(catalogueImage3.path, filename: path.basename(catalogueImage3.path)),
        if (catalogueImage4.path.isNotEmpty)'catalogue_image4': await MultipartFile.fromFile(catalogueImage4.path, filename: path.basename(catalogueImage4.path)),
        if (catalogueImage5.path.isNotEmpty)'catalogue_image5': await MultipartFile.fromFile(catalogueImage5.path, filename: path.basename(catalogueImage5.path)),
        'terms_conditions': true,
        'data_protection': true,
        'password': password,
        'password2': password,
        'latitude': latitude,
        'longitude':longitude
      });

      var response =
          await dio.post(Constants.BaseUrlPro + Constants.SignUp, data: param);
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

      if ((e as DioError).response!.data is Map &&
          (e).response!.data["detail"] != null) {
        DialogUtils().showDialog(
            MyErrorWidget(error: (e).response!.data["detail"].toString()));
      } else {
        DialogUtils().showDialog(
            MyErrorWidget(error: "Bar name already exist"));
        //return (e).error.toString();
      }

      DialogUtils().showDialog(MyErrorWidget(
          error: (e as DioError).response!.data["details"].toString()));
      print(e);
      return (e as DioError).response!.data["details"].toString();
    }
  }
}
