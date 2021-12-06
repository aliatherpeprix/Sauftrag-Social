import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.topMargin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                model.navigateBack();
                              },
                              iconSize: 15.0,
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ColorUtils.black,
                              )),
                          SizedBox(width: 2.w),
                          Text(
                            "QR Code",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),

                      ///--------------Event Name--------------------///
                      Center(
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Image.asset(ImageUtils.qrCodeImg, height: 25.h,)
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
                        decoration: BoxDecoration(
                          color: ColorUtils.text_red,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          children: [
                            Image.asset(ImageUtils.levelStar,
                              height: 20.i,
                              width: 20.i,
                            ),
                            SizedBox(width: 2.w,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Level 21",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistBold,
                                      color: Colors.white,
                                      fontSize: 2.5.t,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 2.h,
                                  // ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    child: Text("You are just 25 points away to reach next level",
                                      style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        color: Colors.white,
                                        fontSize: 1.6.t,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.0.h,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: SizedBox(
                                        height: 8,
                                        child:LiquidLinearProgressIndicator(
                                          value: 0.45, // Defaults to 0.5.
                                          valueColor: AlwaysStoppedAnimation(ColorUtils.settingsProgress), // Defaults to the current Theme's accentColor.
                                          backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                                          //borderColor: Colors.red, //border color of the bar
                                          //borderWidth: 5.0, //border width of the bar
                                          borderRadius: 12.0,//border radius
                                          direction: Axis.horizontal,
                                          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                          //center: Text("50%"), //text inside bar
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),

                      ///--------------Settings Options--------------------///
                      Text(
                        "Ranking List Nubmer",
                        style: TextStyle(
                          color: ColorUtils.black,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.5.t,
                        ),
                      ),
                      SizedBox(height: 3.h,),
                     Row(
                       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("#4",  style: TextStyle(
                             fontFamily: FontUtils.modernistRegular,
                             fontSize: 2.t,
                             color: ColorUtils.red_color
                         ),),
                         SizedBox(width: 3.w,),
                         Expanded(
                           child: Container(

                             padding: EdgeInsets.only(right: 5.w),
                             decoration: BoxDecoration(
                               color: ColorUtils.searchFieldColor,
                               borderRadius: BorderRadius.all(Radius.circular(25)),
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               //crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Row(
                                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Image.asset(ImageUtils.johnImg,
                                         width: 12.i,
                                         height: 12.i,
                                         fit: BoxFit.cover,
                                       ),
                                     ),
                                     SizedBox(width: 2.w,),
                                     Text("John Milton",  style: TextStyle(
                                         fontFamily: FontUtils.modernistBold,
                                         fontSize: 2.t,
                                         color: ColorUtils.black
                                     ),),
                                   ],
                                 ),
                                 Text("75 Pts",  style: TextStyle(
                                     fontFamily: FontUtils.modernistRegular,
                                     fontSize: 2.t,
                                     color: ColorUtils.red_color
                                 ),),
                               ],
                             ),
                           ),
                         )
                       ],
                     )
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
