import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/round_image.dart';
import 'package:stacked/stacked.dart';

class Match extends StatefulWidget {

  const Match({Key? key}) : super(key: key);

  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          child: Scaffold(
              backgroundColor: ColorUtils.white,
              body: Stack(
                children: [

                  //SvgPicture.asset(ImageUtils.matchBg),

                  Image.asset(ImageUtils.matchBgPng),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SvgPicture.asset(ImageUtils.congratzPic),
                        SizedBox(height: 5.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Container(
                              width: 28.i,
                              height: 28.i,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ColorUtils.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorUtils.text_grey.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: Offset(0,5)
                                  ),
                                ],
                              ),
                              child: Container(
                                //width: 23.i,
                                //height: 23.i,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(ImageUtils.girl), fit: BoxFit.cover),
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),

                            SvgPicture.asset(ImageUtils.matchIcon),

                            Container(
                              width: 28.i,
                              height: 28.i,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ColorUtils.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: ColorUtils.text_grey.withOpacity(0.2),
                                      blurRadius: 20,
                                      offset: Offset(0,5)
                                  ),
                                ],
                              ),
                              child: Container(
                                //width: 23.i,
                                //height: 23.i,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(ImageUtils.boy), fit: BoxFit.cover),
                                    shape: BoxShape.circle
                                ),
                              ),
                            )

                          ],
                        ),
                        SizedBox(height: 5.h),


                        Text(
                          "You and Elizabeth have liked each other. Let’s ask her about her somthing interesting or you can just “Hi”.",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistRegular,
                            fontSize: 1.7.t,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5.h),

                        //Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                },
                                child: Text("Say Hi"),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorUtils.text_red,
                                  onPrimary: ColorUtils.white,
                                  padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 5.w),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                      side: BorderSide(
                                          color: ColorUtils.text_red,
                                          width: 1
                                      )
                                  ),
                                  textStyle: TextStyle(
                                    //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 1.8.t,
                                    //height: 0
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 5.w,),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                },
                                child: Text("Keep Swiping"),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorUtils.white,
                                  onPrimary: ColorUtils.text_red,
                                  padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 5.w),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                      side: BorderSide(
                                          color: ColorUtils.text_red,
                                          width: 1
                                      )
                                  ),
                                  textStyle: TextStyle(
                                    //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 1.8.t,
                                    //height: 0
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),


                      ],
                    ),
                  )
                ],
              )
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
