import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/widgets/deactivate_account_dialog_box.dart';
import 'package:sauftrag/bar/widgets/delete_account_dialog_box.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class OwnerShip extends StatefulWidget {
  const OwnerShip({Key? key}) : super(key: key);

  @override
  _OwnerShipState createState() => _OwnerShipState();
}

class _OwnerShipState extends State<OwnerShip> {
  int selected = 1;
  int unselected = 0;
  int radioSelected = 0;
  int checkSelected = 0;
  int selectedIndex = 0;
  bool radioSelected1 = false;
  bool radioUnselected1 = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            bottom: false,
            top: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding,
                      //vertical: Dimensions.verticalPadding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.topMargin),

                        //Add Images
                        Row(
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
                              "Account Ownership",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.t,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.w),
                        Text(
                          "If you want to take a break from sauftrag, you can deactivate or you can delete your account,.",
                          style: TextStyle(
                            color: ColorUtils.text_dark,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.7.t,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        GestureDetector(
                          onTap: () {
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context){
                            //       return DeactivateAccountDialog(title: "Add New Location",
                            //           btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                            //     }
                            // );
                            setState(() {
                              radioSelected = selected;
                              radioSelected1 = true;
                              radioUnselected1 == false;
                              checkSelected = 0;
                              // ignore: unnecessary_statements
                              //roomusers.length == 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.verticalPadding,
                                horizontal: Dimensions.horizontalPadding),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorUtils.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              border: Border.all(color: ColorUtils.red_color),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(radioSelected == selected
                                    ? ImageUtils.radioSelected
                                    : ImageUtils.radioUnselected),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Deactivate Account",
                                          style: TextStyle(
                                              color: ColorUtils.red_color,
                                              fontSize: 2.2.t,
                                              fontFamily:
                                                  FontUtils.modernistBold),
                                        ),
                                        SizedBox(
                                          height: 2.w,
                                        ),
                                        Text(
                                          "Deactivating your account is temporary. Your account will be disabled and your photos will be removed from most of the things.",
                                          style: TextStyle(
                                              color: ColorUtils.black,
                                              fontSize: 1.7.t,
                                              fontFamily:
                                                  FontUtils.modernistRegular),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        GestureDetector(
                            onTap: () {
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context){
                              //       return DeleteAcountDialogbox(title: "Add New Location",
                              //           btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                              //     }
                              // );
                              setState(() {
                                // ignore: unnecessary_statements
                                //roomusers.length == 1;

                                radioSelected = unselected;
                                radioSelected1 = false;
                                radioUnselected1 == false;
                                checkSelected = 1;
                                print(checkSelected);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.verticalPadding,
                                  horizontal: Dimensions.horizontalPadding),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorUtils.black.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                border: Border.all(color: ColorUtils.red_color),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(radioSelected == unselected
                                      ? ImageUtils.radioSelected
                                      : ImageUtils.radioUnselected),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delete Account",
                                          style: TextStyle(
                                              color: ColorUtils.red_color,
                                              fontSize: 2.2.t,
                                              fontFamily:
                                                  FontUtils.modernistBold),
                                        ),
                                        SizedBox(
                                          height: 2.w,
                                        ),
                                        Text(
                                          "Deleting your account is permament. When you delete your account, you won’t be able to retrieve the content or the information that you have shared.",
                                          style: TextStyle(
                                              color: ColorUtils.black,
                                              fontSize: 1.7.t,
                                              fontFamily:
                                                  FontUtils.modernistRegular),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () {
                              //model.navigateToHomeBarScreen();
                              if (checkSelected != 1) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DeactivateAccountDialog(
                                          title: "Add New Location",
                                          btnTxt: "Add Location",
                                          icon: ImageUtils.addLocationIcon);
                                    });
                              } else
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DeleteAcountDialogbox(
                                          title: "Add New Location",
                                          btnTxt: "Add Location",
                                          icon: ImageUtils.addLocationIcon);
                                    });
                            },
                            child: Text(radioSelected == unselected
                                ? "Delete Account"
                                : "Deactivate Account"),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.text_red,
                              onPrimary: ColorUtils.white,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      Dimensions.containerVerticalPadding),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.roundCorner)),
                              textStyle: TextStyle(
                                color: ColorUtils.white,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                                //height: 0
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
