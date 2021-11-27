import 'package:flutter/cupertino.dart';
import 'package:sauftrag/utils/dialog_utils.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';
import 'error_widget.dart';

class BarAuthViewModel extends BaseViewModel {


  final signupBarNameController = TextEditingController();
  final signupAddressController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();


  createVendor() {
    if (signupBarNameController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(error: "Username is required"));
      return;
    }
    if (signupAddressController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(error: "Email is required"));
      return;
    }
    if (!signupEmailController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(error: "Email is invalid"));
      return;
    }
    if (signupPasswordController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(error: "Password is required"));
      return;
    }
    else
      {
        navigationViewModel.navigateToUploadBarMedia();
      }

    /*signupVendor(
        signupUserNameController.text.toString(),
        signupEmailController.text.toString(),
        signupPasswordController.text.toString(),
        signupMobileController.text.toString(),
        Constants.vendor);*/

  }
}