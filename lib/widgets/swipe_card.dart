import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class SwipeCard extends StatefulWidget {

  List<String> img;
  double bottom;
  double right;
  double left;
  double cardWidth;
  double rotation;
  double skew;
  int flag;
  Function dismissImg;
  Function addImg;
  Function details;
  Function swipeLeft;
  Function swipeRight;

  SwipeCard({Key? key, required this.img, required this.bottom, required this.right, required this.left, required this.cardWidth, required this.rotation, required this.skew, required this.flag, required this.dismissImg, required this.addImg, required this.details, required this.swipeLeft, required this.swipeRight}) : super(key: key);

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {

  //List<String> images = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl3, ImageUtils.girl4, ImageUtils.girl5];
  final currentPageNotifier = ValueNotifier<int>(0);

  late PageController controller;

  late double likeOpacity, dislikeOpacity;
  StreamController<double> streamController = StreamController<double>.broadcast();
  late Stream stream;

  late double startPosition;

  bool isLike = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = PageController(initialPage: 0);
    stream = streamController.stream;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return ViewModelBuilder<MainViewModel>.reactive(
      /*onModelReady: (data){
        //data.initSwipe();
      },*/
      builder: (context, model, child) {
        return Positioned(
          bottom: 0.0 + widget.bottom,
          right: widget.flag == 0 ? widget.right != 0.0 ? widget.right : null : null,
          left: widget.flag == 1 ? widget.right != 0.0 ? widget.right : null : null,
          child: Dismissible(
            key: Key(widget.img[0]),
            crossAxisEndOffset: -0.3,
            onResize: () {
            },
            onDismissed: (DismissDirection direction) {
              //_swipeAnimation();
              if (direction == DismissDirection.endToStart) {
                widget.dismissImg(widget.img);
              } else {
                widget.addImg(widget.img);
              }
            },
            child: StreamBuilder(
              stream: stream,
              initialData: 0.0,
              builder: (context, snapshot){
                return Listener(
                  child: Transform(
                    alignment: widget.flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
                    //transform: null,
                    transform: new Matrix4.skewX(widget.skew),
                    //transform: new Matrix4.rotationX(flag == 0 ? rotation / 360 : -rotation / 360),
                    //..rotateX(-math.pi / rotation),
                    child: RotationTransition(turns: AlwaysStoppedAnimation(widget.flag == 0 ? widget.rotation / 360 : -widget.rotation / 360),
                      child: GestureDetector(
                        onTap: () {
                          widget.details();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenSize.width / 1.1 + widget.cardWidth,
                          height: screenSize.height / 1.4,
                          child: Stack(
                            children: [

                              PageView.builder(
                                itemBuilder: (context, position) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(image: AssetImage(widget.img[position]), fit: BoxFit.cover),
                                    ),
                                    alignment: Alignment.center,
                                  );
                                },
                                itemCount: widget.img.length,
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
                                        count:  widget.img.length,
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
                                            widget.swipeLeft();
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
                                            widget.swipeRight();
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
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}