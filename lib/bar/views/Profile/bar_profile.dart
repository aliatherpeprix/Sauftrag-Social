import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/bar_model.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/prefrences_view_model.dart';
import 'package:sauftrag/widgets/round_image.dart';
import 'package:stacked/stacked.dart';

class BarProfile extends StatefulWidget {
  const BarProfile({Key? key}) : super(key: key);

  @override
  _BarProfileState createState() => _BarProfileState();
}

class _BarProfileState extends State<BarProfile> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {
        // model.saveBarDetails();
        // model.notifyListeners();
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.topMargin),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Settings",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 3.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),

                      ///--------------Event Name--------------------///
                      GestureDetector(
                        onTap: () async {
                          //model.notifyListeners();
                          model.isUserProfile = true;
                          model.notifyListeners();
                          model.navigateToBarDetails();
                          PrefrencesViewModel prefs =
                          locator<PrefrencesViewModel>();
                          model.barModel = await prefs.getBarUser();
                          if (model.barModel!.profile_picture != null &&
                              model.barModel!.profile_picture!.isNotEmpty) {
                            model.imageFiles.removeAt(0);
                            model.imageFiles
                                .insert(0, model.barModel!.profile_picture!);
                          }
                          if (model.barModel!.catalogue_image1 != null &&
                              model.barModel!.catalogue_image1!.isNotEmpty) {
                            model.imageFiles.removeAt(1);
                            model.imageFiles
                                .insert(1, model.barModel!.catalogue_image1!);
                          }
                          if (model.barModel!.catalogue_image2 != null &&
                              model.barModel!.catalogue_image2!.isNotEmpty) {
                            model.imageFiles.removeAt(2);
                            model.imageFiles
                                .insert(2, model.barModel!.catalogue_image2!);
                          }
                          if (model.barModel!.catalogue_image3 != null &&
                              model.barModel!.catalogue_image3!.isNotEmpty) {
                            model.imageFiles.removeAt(3);
                            model.imageFiles
                                .insert(3, model.barModel!.catalogue_image3!);
                          }
                          if (model.barModel!.catalogue_image4 != null &&
                              model.barModel!.catalogue_image4!.isNotEmpty) {
                            model.imageFiles.removeAt(4);
                            model.imageFiles
                                .insert(4, model.barModel!.catalogue_image4!);
                          }
                          if (model.barModel!.catalogue_image5 != null &&
                              model.barModel!.catalogue_image5!.isNotEmpty) {
                            model.imageFiles.removeAt(5);
                            model.imageFiles
                                .insert(5, model.barModel!.catalogue_image5!);
                          }
                          model.isUserProfile = false;
                          model.notifyListeners();
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(

                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    // onPressed: () {
                                    //  /* showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context){
                                    //         return DrinkStatusDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                    //       }
                                    //   );*/
                                    // },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image(
                                          image: NetworkImage(model
                                              .barModel!.profile_picture!),
                                          fit: BoxFit.cover,
                                          height: 15.i,
                                          width: 15.i,
                                        )),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.barModel!.bar_name!,
                                        style: TextStyle(
                                          color: ColorUtils.black,
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 2.t,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        model.barModel!.address!,
                                        style: TextStyle(
                                          color: ColorUtils.text_grey,
                                          fontFamily: FontUtils.modernistBold,
                                          fontSize: 1.7.t,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 30,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),

                      ///--------------Settings Options--------------------///
                      GestureDetector(
                        onTap: (){
                          model.navigateToBarAccounts();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.profile),
                                SizedBox(width: 1.5.h,),
                                Text(
                                  "Accounts",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),

                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),

                      GestureDetector(
                        onTap: (){
                          model.navigateToUserProfileAccountNotificationScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.notification),
                                SizedBox(width: 1.5.h,),
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),

                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: (){
                          model.navigateToUserProfileAccountLegalTermScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.terms),
                                SizedBox(width: 1.5.h,),
                                Text(
                                  "Others",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),

                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(ImageUtils.packages),
                              SizedBox(width: 1.5.h,),
                              Text(
                                "Packages",
                                style: TextStyle(
                                  color: ColorUtils.black,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 2.t,
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(right: 20),
                              //   child: RoundImage(
                              //     url: widget.profile.imageurl,
                              //     txtsize: 18,
                              //     txt: widget.profile.fullName,
                              //     width: 50,
                              //     height: 50,
                              //     borderRadius: 15,
                              //   ),
                              // ),
                            ],
                          ),

                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                            color: Colors.grey,
                          )
                        ],
                      ),

                      //GPS
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: (){
                          model.navigateToUserProfileAccountGpsScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.gps),
                                SizedBox(width: 1.5.h,),
                                Text(
                                  "GPS",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),

                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),

                      //Faqs
                      SizedBox(height: 3.h),
                      GestureDetector(
                        onTap: (){
                          model.navigateToFaqScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(ImageUtils.gps),
                                SizedBox(width: 1.5.h,),
                                Text(
                                  "FAQ",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   child: RoundImage(
                                //     url: widget.profile.imageurl,
                                //     txtsize: 18,
                                //     txt: widget.profile.fullName,
                                //     width: 50,
                                //     height: 50,
                                //     borderRadius: 15,
                                //   ),
                                // ),
                              ],
                            ),

                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
