import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:stacked/stacked.dart';


class DataProtection extends StatefulWidget {
  @override
  _DataProtectionState createState() => _DataProtectionState();
}

class _DataProtectionState extends State<DataProtection> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (model) {
        model.getDataProtection();
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return model.isDataProtection == true ? AllPageLoader() :
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.topMargin),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                      ),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                model.navigateBack();
                              },
                              iconSize: 18.0,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ColorUtils.black,
                                size: 4.5.i,
                              )),
                          SizedBox(width: 2.w),
                          Text(
                            "Data Protection",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w),
                      margin: EdgeInsets.only(top: Dimensions.topMargin),
                      child: Text(
                        "Data Protection",
                        style: TextStyle(
                          color: ColorUtils.red_color,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.3.t,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w),
                      child:
                      Html(
                        data : model.protection!,
                        // style: TextStyle(
                        //   color: ColorUtils.black,
                        //   fontFamily: FontUtils.modernistRegular,
                        //   fontSize: 1.8.t,
                        // ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              )
          ),
        );
      },
    );
  }
}
