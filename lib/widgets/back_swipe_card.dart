import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class BackSwipeCard extends StatelessWidget {

  List<String> img;
  double bottom;
  double right;
  double left;
  double cardWidth;
  double rotation;
  double skew;

  BackSwipeCard({Key? key, required this.img, required this.bottom, required this.right, required this.left, required this.cardWidth, required this.rotation, required this.skew}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    final currentPageNotifier = ValueNotifier<int>(0);
    late PageController controller = PageController(initialPage: 0,);

    return Positioned(
      bottom: 0.0 + bottom,
      child: Container(
        alignment: Alignment.center,
        width: screenSize.width / 1.4 + cardWidth,
        height: screenSize.height / 2,
        child: Stack(
          children: [

            PageView.builder(
              itemBuilder: (context, position) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(image: AssetImage(img[position]), fit: BoxFit.cover),
                  ),
                  alignment: Alignment.center,
                );
              },
              itemCount: img.length,
              scrollDirection: Axis.vertical,
              controller: controller,
              onPageChanged: (int index){
                currentPageNotifier.value = index;
              },// Can be null
            ),

            Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 8.h),
                  padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                    color: ColorUtils.white.withOpacity(0.6),

                  ),
                  child: SmoothPageIndicator(
                      controller: controller,  // PageController
                      count:  img.length,
                      effect:  WormEffect(
                          spacing:  10,
                          dotWidth:  5,
                          dotHeight:  5,
                          dotColor:  ColorUtils.white.withOpacity(0.5),
                          activeDotColor:  ColorUtils.white
                      ),
                      axisDirection: Axis.vertical,
                      onDotClicked: (index){

                      }
                  ),
                )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 0.8.h),
                      Text(
                        "Stella Christensen, 24",
                        style: TextStyle(
                          color: ColorUtils.white,
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.2.t,
                        ),
                      ),
                      SizedBox(height: 1.h),

                      Row(
                        children: [

                          Icon(Icons.location_pin, color: ColorUtils.white, size: 5.i,),

                          Text(
                            "Germany",
                            style: TextStyle(
                              color: ColorUtils.white,
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.5.t,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}