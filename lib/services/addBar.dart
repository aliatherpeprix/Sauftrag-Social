import 'package:dio/dio.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_Kind_Model.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/utils/constants.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';

class AddBarKind {
  //var _dioService = DioService.getInstance();

  Dio dio = Dio();

  Future addKindOfBar(
      String name,
      )
  async
  {
    try {

      var param = FormData.fromMap({
        'name': name,
      });
      BarModel? user = (await locator<PrefrencesViewModel>().getUser()) as BarModel?;
      var response = await dio.post(Constants.BaseUrlPro+Constants.
      addBarKind, data: param,options: Options(
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
        var barKindData = BarKindModel.fromJson(response.data);
        return barKindData;
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