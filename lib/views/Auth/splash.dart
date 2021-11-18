import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      onModelReady: (data) => data.initializeSplash(),
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: ColorUtils.white,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageUtils.logo),
                  SizedBox(height: 3.h),
                  Text(
                    "Sauftrag",
                    style: TextStyle(
                      color: ColorUtils.black,
                      fontFamily: FontUtils.modernistBold,
                      fontSize: 5.t,
                    ),
                  ),
                  Text(
                    "Social",
                    style: TextStyle(
                      color: ColorUtils.black,
                      fontFamily: FontUtils.modernistMono,
                      fontSize: 3.t,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
