import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

class MatchedScreen extends StatefulWidget {
  const MatchedScreen({Key? key}) : super(key: key);

  @override
  _MatchedScreenState createState() => _MatchedScreenState();
}

class _MatchedScreenState extends State<MatchedScreen> {
  List matchedImg = [
    {'image': ImageUtils.matchedImg1, 'title' : 'Leona Mathis'},
    {'image': ImageUtils.matchedImg2, 'title' : 'Josefina Ward'},
    {'image': ImageUtils.matchedImg3, 'title' : 'Andre Patterson'},
    {'image': ImageUtils.matchedImg4, 'title' : 'Nick Hoffman'},
    {'image': ImageUtils.matchedImg5, 'title' : 'Henrietta Hall'},
    {'image': ImageUtils.matchedImg6, 'title' : 'Hazel Ballard'},
  ];

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
              top: false,
              bottom: false,
              child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.homeTopMargin),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.horizontalPadding,
                        vertical: Dimensions.verticalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                                )),
                            SizedBox(width: 2.w),
                            Text(
                              "Matched",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.5.t,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.w),
                          child: GridView.builder(
                            itemCount: matchedImg.length,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            primary: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    // childAspectRatio: 2.5,
                                    crossAxisCount: 2,
                                    // crossAxisSpacing: 2,
                                    mainAxisSpacing: 30),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Image.asset(matchedImg[index]['image']),
                                  PositionedDirectional(
                                    bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 6.7.w, vertical: 1.2.h),
                                        color: ColorUtils.transparent.withOpacity(0.2),
                                    child: Text(matchedImg[index]['title']),
                                  ))
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      disposeViewModel: false,
    );
  }
}
