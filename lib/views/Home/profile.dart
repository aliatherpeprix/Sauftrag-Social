import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class Profile extends StatefulWidget {

  List<String> images;

  Profile({Key? key, required this.images}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //List<String> images = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1];

  final currentPageNotifier = ValueNotifier<int>(0);

  late PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = PageController(initialPage: 0,);
  }

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeLoginModel(),
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            top: false,
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 3.5.h),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Stack(
                          children: [

                            PageView.builder(
                              itemBuilder: (context, position) {
                                return Container(
                                  decoration: BoxDecoration(
                                    //borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(image: AssetImage(widget.images[position]), fit: BoxFit.cover),
                                  ),
                                  alignment: Alignment.center,
                                );
                              },
                              itemCount: widget.images.length,
                              controller: controller,
                              onPageChanged: (int index){
                                currentPageNotifier.value = index;
                              },// Can be null
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                  color: ColorUtils.white.withOpacity(0.6),
                                  
                                ),
                                child: SmoothPageIndicator(
                                controller: controller,  // PageController
                                count:  widget.images.length,
                                effect:  WormEffect(
                                    spacing:  10,
                                    dotWidth:  5,
                                    dotHeight:  5,
                                    dotColor:  ColorUtils.white.withOpacity(0.5),
                                    activeDotColor:  ColorUtils.white
                                ),
                                axisDirection: Axis.horizontal,
                                onDotClicked: (index){

                                }
                            ),
                                /*CirclePageIndicator(
                                  size: 5.0,
                                  selectedSize: 7.0,
                                  itemCount: 5,
                                  dotColor: ColorUtils.white.withOpacity(0.5),
                                  selectedDotColor: ColorUtils.white,
                                  dotSpacing: 3.w,
                                  currentPageNotifier: currentPageNotifier,
                                ),*/
                              ),
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 3.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                        child: Text(
                          "Stella Christensen, 24",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.4.t,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                        child: Row(
                          children: [

                            Icon(Icons.location_pin, color: ColorUtils.text_dark),

                            Text(
                              "Germany",
                              style: TextStyle(
                                color: ColorUtils.text_dark,
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.8.t,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),

                      Divider(
                        color: ColorUtils.divider,
                        thickness: 1,
                      ),
                      SizedBox(height: 3.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                        child: Text(
                          "Interest",
                          style: TextStyle(
                            color: ColorUtils.black,
                            fontFamily: FontUtils.modernistBold,
                            fontSize: 2.2.t,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                        child: Wrap(
                          spacing: 2.5.w,
                          runSpacing: 1.5.h,
                          direction: Axis.horizontal,
                          children: model.interestList
                              .map((element) => ElevatedButton(
                            onPressed: () {
                            },
                            child: Text(model.interestList[model.interestList.indexOf(element)]),
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
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 1.5.t,
                                //height: 0
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                      SizedBox(height: 4.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          ElevatedButton(
                            onPressed: () {
                              model.navigateBack();
                            },
                            child: SvgPicture.asset(ImageUtils.dislikeIcon),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.transparent,
                              onPrimary: ColorUtils.white,
                              //padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                                //side: BorderSide(color: ColorUtils.divider, width: 1)
                              ),
                              textStyle: TextStyle(
                                color: ColorUtils.white,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                                //height: 0
                              ),
                            ),
                          ),

                          FloatingActionButton(
                            onPressed: (){},
                            child: SvgPicture.asset(ImageUtils.repeatIcon),
                            backgroundColor: ColorUtils.white,

                          ),

                          ElevatedButton(
                            onPressed: () {
                              model.navigateToMatchScreen();
                            },
                            child: SvgPicture.asset(ImageUtils.likeIcon),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.transparent,
                              onPrimary: ColorUtils.white,
                              //padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                                //side: BorderSide(color: ColorUtils.divider, width: 1)
                              ),
                              textStyle: TextStyle(
                                color: ColorUtils.white,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                                //height: 0
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 2.h),


                    ],
                  ),
                )
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
