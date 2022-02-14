import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/back_swipe_card.dart';
import 'package:sauftrag/widgets/drink_status_dialog_box.dart';
import 'package:sauftrag/widgets/my_side_menu.dart';
import 'package:sauftrag/widgets/swipe_card.dart';
import 'package:sauftrag/widgets/swipe_card_new.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Swipe extends StatefulWidget {

  const Swipe({Key? key}) : super(key: key);

  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> with TickerProviderStateMixin {

  /*List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl1];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
          },
          nopeAction: () {
          },
          superlikeAction: () {
          }
          )
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);

    super.initState();
  }*/

  late AnimationController _buttonController;
  late Animation<double> rotate;
  late Animation<double> right;
  late Animation<double> bottom;
  late Animation<double> width;
  int flag = 0;

  List<String> welcomeImages = [
    ImageUtils.girl1,
    ImageUtils.girl2,
    ImageUtils.girl3,
    ImageUtils.girl4,
    ImageUtils.girl5,
    ImageUtils.girl6,
    ImageUtils.girl7,
    ImageUtils.girl8,
    ImageUtils.girl9,
    ImageUtils.girl10,
    ImageUtils.girl11,
    ImageUtils.girl12
  ];
  //List data = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl3, ImageUtils.girl4, ImageUtils.girl5, ImageUtils.girl6];

  List<List<String>> data = [
    [ImageUtils.boy_4, ImageUtils.boy_5, ImageUtils.boy_6,],
    [ImageUtils.boy_1, ImageUtils.boy_2, ImageUtils.boy_3,],
    [ImageUtils.girl10, ImageUtils.girl11, ImageUtils.girl12, ImageUtils.girl13],
    [ImageUtils.girl7, ImageUtils.girl8, ImageUtils.girl9,],
    [ImageUtils.girl4, ImageUtils.girl5, ImageUtils.girl6,],
    [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl3,],
    /*[ImageUtils.girl2, ImageUtils.girl4, ImageUtils.girl6, ImageUtils.girl8, ImageUtils.girl10, ImageUtils.girl12],
    [ImageUtils.girl12, ImageUtils.girl11, ImageUtils.girl10, ImageUtils.girl9, ImageUtils.girl8, ImageUtils.girl7],
    [ImageUtils.girl6, ImageUtils.girl5, ImageUtils.girl4, ImageUtils.girl3, ImageUtils.girl2, ImageUtils.girl1],*/
  ];

  List selectedData = [];

  //late CardController controller;
  late PageController pageController;
  final currentPageNotifier = ValueNotifier<int>(0);

  void initState() {
    super.initState();

    _buttonController = new AnimationController(duration: new Duration(milliseconds: 1000), vsync: this);

    pageController = PageController(initialPage: 0);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    pageController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(List img) {
    setState(() {
      data.remove(img);
    });
  }

  addImg(List img) {
    setState(() {
      data.remove(img);
      selectedData.add(img);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {

    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = 0.0;

    return ViewModelBuilder<MainViewModel>.reactive(
      // onModelReady: (data) {
      //   data.buttonController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
      //   data.initSwipe();
      // },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: SideMenu(
            key: model.sideMenuKey,
            type: SideMenuType.shrinkNSlide,
            background: ColorUtils.text_red,
            radius: BorderRadius.circular(30),
            menu: MySideMenu(),
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: Dimensions.verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: Dimensions.homeTopMargin),

                      //Top bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                        //margin: EdgeInsets.only(bottom: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            ElevatedButton(
                              onPressed: () {
                                final _state = model.sideMenuKey.currentState;
                                if (_state!.isOpened)
                                  _state.closeSideMenu(); // close side menu
                                else
                                  _state.openSideMenu();
                              },
                              child: SvgPicture.asset(ImageUtils.menuIcon),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.white,
                                padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                  side: BorderSide(color: ColorUtils.divider, width: 1)
                                ),
                                textStyle: TextStyle(
                                  color: ColorUtils.white,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),

                            Column(
                              children: [
                                Text(
                                  "Discover",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 3.t,
                                  ),
                                ),
                                Text(
                                  "Chicago",
                                  style: TextStyle(
                                    color: ColorUtils.black,
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.7.t,
                                  ),
                                ),
                              ],
                            ),

                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return DrinkStatusDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                    }
                                );
                              },
                              child: SvgPicture.asset(ImageUtils.setStatusIcon),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                //onPrimary: ColorUtils.white,
                                padding: EdgeInsets.symmetric(vertical: Dimensions.containerVerticalPadding),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(color: ColorUtils.divider, width: 1)
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
                      ),
                      //SizedBox(height: 3.h),

                      /*Expanded(
                        child: Container(
                          //height: 550,
                          //color: ColorUtils.red_color,
                          child: SwipeCards(
                            matchEngine: _matchEngine,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                //margin: EdgeInsets.only(top: index == _swipeItems.indexOf(_matchEngine.currentItem!) ? 5.h : 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        image: DecorationImage(image: AssetImage(_swipeItems[index].content.text), fit: BoxFit.cover),
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        //height: 10.h,
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
                                    ),

                                  ],
                                ),
                                //color: _swipeItems[index].content.color,
                                //child: Image.asset(_swipeItems[index].content.text)
                              );
                            },
                            onStackFinished: () {

                            },
                          ),
                        ),
                      ),*/

                      /*Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: data.map((item) {
                            if (data.indexOf(item) == dataLength - 1) {
                              return SwipeCard(
                                  img: item,
                                  cardWidth: backCardWidth + 10,
                                  rotation: rotate.value,
                                  skew: rotate.value < -10 ? 0.1 : 0.0,
                                  details: (){model.navigateToProfileScreen();},
                                  right: right.value,
                                  left: 0.0,
                                  addImg: addImg,
                                  bottom: bottom.value,
                                  flag: flag,
                                  dismissImg: dismissImg);
                            }
                            else{
                              backCardPosition = backCardPosition - 10;
                              backCardWidth = backCardWidth + 10;

                              return BackSwipeCard(
                                  img: item,
                                  cardWidth: backCardWidth,
                                  right: 0,
                                  left: 0,
                                  rotation: 0,
                                  skew: 0,
                                  bottom: backCardPosition);
                            }
                          }).toList(),
                        ),
                      ),*/

                      Expanded(
                        child: Container(
                          //margin: EdgeInsets.symmetric(vertical: 2.h),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: data.map((item) {
                              return SwipeCard(
                                  img: item,
                                  cardWidth: backCardWidth + 0,
                                  rotation: rotate.value,
                                  skew: rotate.value < -10 ? 0.1 : 0.0,
                                  details: (){model.navigateToProfileScreen(item);},
                                  right: right.value,
                                  left: 0.0,
                                  addImg: addImg,
                                  bottom: bottom.value,
                                  flag: flag,
                                  dismissImg: dismissImg,
                                  swipeRight: swipeRight,
                                  swipeLeft: swipeLeft
                                  );

                              return swipeCardNew(
                                  item,
                                  bottom.value,
                                  right.value,
                                  0.0,
                                  backCardWidth + 0,
                                  rotate.value,
                                  rotate.value < -10 ? 0.1 : 0.0,
                                  flag,
                                  dismissImg,
                                  addImg,
                                  model.navigateToProfileScreen,
                                  swipeLeft,
                                  swipeRight,
                                  context
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      //SizedBox(height: 1.h),

                      /*Expanded(
                        child: TinderSwapCard(
                          swipeUp: false,
                          swipeDown: false,
                          orientation: AmassOrientation.TOP,
                          totalNum: data.length,
                          stackNum: 2,
                          swipeEdge: 8,
                          allowVerticalMovement: false,
                          maxWidth: MediaQuery.of(context).size.width * 1,
                          maxHeight: MediaQuery.of(context).size.height * 1,
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          minHeight: MediaQuery.of(context).size.height * 0.9,
                          cardBuilder: (context, index) => Stack(
                            children: [

                              PageView.builder(
                                itemBuilder: (context, position) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(image: AssetImage(data[index][position]), fit: BoxFit.cover),
                                    ),
                                    alignment: Alignment.center,
                                  );
                                },
                                itemCount: data[index].length,
                                scrollDirection: Axis.vertical,
                                controller: pageController,
                                onPageChanged: (int index){
                                  //currentPageNotifier.value = index;
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
                                        controller: pageController,  // PageController
                                        count:  data[index].length,
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
                                              //widget.swipeLeft();
                                              controller.triggerLeft();
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
                                              //widget.swipeRight();
                                              controller.triggerRight();
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
                          cardController: controller = CardController(),
                          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                            /// Get swiping card's alignment
                            if (align.x < 0) {
                              //Card is LEFT swiping
                            } else if (align.x > 0) {
                              //Card is RIGHT swiping
                            }
                          },
                          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
                            /// Get orientation & index of swiped card!
                            pageController = PageController(initialPage: 0);
                          },
                        ),
                      ),*/

                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          ElevatedButton(
                            onPressed: () {
                              //_matchEngine.currentItem!.nope();
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
                              //_matchEngine.currentItem!.like();
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
                      ),*/
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

class Content {
  final String text;
  final Color color;

  Content({required this.text, required this.color});
}
