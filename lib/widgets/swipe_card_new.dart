import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Positioned swipeCardNew(
    List<String> img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    int flag,
    Function dismissImg,
    Function addImg,
    Function details,
    Function swipeLeft,
    Function swipeRight,
    BuildContext context) {
  
  Size screenSize = MediaQuery.of(context).size;

  final currentPageNotifier = ValueNotifier<int>(0);

  late PageController controller = PageController(initialPage: 0);

  late double likeOpacity, dislikeOpacity;
  StreamController<double> streamController = StreamController<double>.broadcast();
  late Stream stream = streamController.stream;

  late double startPosition;

  bool isLike = false;

  return Positioned(
    bottom: 0.0 + bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: Dismissible(
      key: Key(img[0]),
      crossAxisEndOffset: -0.3,
      onResize: () {
      },
      onDismissed: (DismissDirection direction) {
        //_swipeAnimation();
        if (direction == DismissDirection.endToStart) {
          dismissImg(img);
        } else {
          addImg(img);
        }
      },
      child: StreamBuilder(
          stream: stream,
          initialData: 0.0,
          builder: (context, snapshot){
            return Listener(
              child: Transform(
                alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
                //transform: null,
                transform: new Matrix4.skewX(skew),
                //transform: new Matrix4.rotationX(flag == 0 ? rotation / 360 : -rotation / 360),
                //..rotateX(-math.pi / rotation),
                child: RotationTransition(turns: AlwaysStoppedAnimation(flag == 0 ? rotation / 360 : -rotation / 360),
                  child: GestureDetector(
                    onTap: () {
                      details();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenSize.width / 1.1 + cardWidth,
                      height: screenSize.height / 1.4,
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      ElevatedButton(
                                        onPressed: () {
                                          swipeLeft();
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
                                        onPressed: (){
                                          //_matchEngine.rewindMatch();
                                        },
                                        child: SvgPicture.asset(ImageUtils.repeatIcon),
                                        backgroundColor: ColorUtils.white,

                                      ),

                                      ElevatedButton(
                                        onPressed: () {
                                          swipeRight();
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

                                  Container(
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
                                ],
                              )
                          ),

                          Center(
                            child: Opacity(
                                opacity: isLike ? snapshot.data as double : 0 ,
                                child: SvgPicture.asset(ImageUtils.likeCenterIcon)
                            ),
                          ),

                          Center(
                            child: Opacity(
                                opacity: isLike ? 0 : snapshot.data as double,
                                child: SvgPicture.asset(ImageUtils.dislikeCenterIcon)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onPointerDown: (event) {
                startPosition = event.position.dx;
                isLike = false;
              },
              onPointerUp: (event) {
                likeOpacity = 0.0;
                dislikeOpacity = 0.0;
                streamController.add(0);
              },
              onPointerMove: (details) {
                if (details.position.dx > startPosition) {
                  var move = details.position.dx - startPosition;
                  move = move / MediaQuery.of(context).size.width;

                  isLike = true;
                  likeOpacity = move;

                  streamController.add(likeOpacity);
                }
                else if (details.position.dx < startPosition) {
                  var move = startPosition - details.position.dx;
                  move = move / MediaQuery.of(context).size.width;

                  isLike = false;
                  dislikeOpacity = move;

                  streamController.add(dislikeOpacity);
                }
              },
            );
          }
      ),
    ),
  );
}
