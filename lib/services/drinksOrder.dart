import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/views/Home/bar_drinks.dart';
import 'package:sauftrag/bar/views/Home/order_details.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';

import '../main.dart';

class Drinkorder {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  // POST API

  Future DrinkOrder(

      int? user_id,
      List? order_details,


      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({

        'user_id': user_id,
        'order_details': order_details,


      });

      NewBarModel? barModel = (await locator<PrefrencesViewModel>().getBarUser());
      var response = await dio.post(Constants.BaseUrlPro+Constants.order, data: param,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${barModel!.token!}"
              }
          )
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // user found
        Navigator.push(navigationViewModel.navigationKey.currentContext!, PageTransition(child: OrderDetails(),
            type: PageTransitionType.rightToLeftWithFade));
        // var orderResponse = FavoritesModel.fromJson(response.data);
        //
        // print(orderResponse);
        // return orderResponse;
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
