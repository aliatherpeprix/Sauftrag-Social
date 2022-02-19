 import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/views/Home/bar_drinks.dart';
import 'package:sauftrag/main.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/models/new_bar_model.dart';
import 'package:sauftrag/models/user_models.dart';
import 'package:sauftrag/modules/dio_services.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/utils/convertAssetToFile.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/views/Auth/signup.dart';
import 'package:sauftrag/views/Home/main_view.dart';

class BarQrcode {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future BarQrCode(

      dynamic user_id

      ) async {
    try {
      /// just login user through phoneNumber and password

      var param = FormData.fromMap({
        'user_id': user_id ,
      });

      NewBarModel? barModel = (await locator<PrefrencesViewModel>().getBarUser());
      var response = await dio.post(Constants.BaseUrlPro+Constants.QRCode, data: param,
          options: Options(
            // contentType: Headers.formUrlEncodedContentType,
              headers: {
                "Authorization": "Token ${barModel!.token!}"
              }
          )

      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.push(navigationViewModel.navigationKey.currentContext!, PageTransition(child: BarDrinks(),
            type: PageTransitionType.rightToLeftWithFade));

        // navigateToChooseDrinkScreen(context)  {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => BarDrinks()));
        // }
        List<FavoritesModel> drinks = (response.data as List).map((e) => FavoritesModel.fromJson(e)).toList();
        return drinks;
        var userData = BarModel.fromJson(response.data);
        return userData;}

      //user not found
      // else {
      //
      // }

    } catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }
}
