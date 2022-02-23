import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/address_book.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

class Addressbook {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  // POST API

  Future AddressBookList(

      //int? id,
      // String? username,
      // String? phone_no,
      // bool exist
      List contacts

      ) async {
    try {
      /// just login user through phoneNumber and password

      // var param = FormData.fromMap({
      //
      //   'username': username,
      //   'phone_no': phone_no,
      //   'exist' : exist
      //
      // });

      var param = {
        "data" : contacts
      };

      NewBarModel? barModel = await locator<PrefrencesViewModel>().getBarUser();
      var response = await dio.post(Constants.BaseUrlPro+Constants.AddressBook, data: param,
          options: Options(
              // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${barModel!.token!}"
              }
          )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {

        var addressBoookData = (response.data as List).map((e) => AddressBook.fromJson(e)).toList();

        print(addressBoookData);
        return addressBoookData;
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

}
