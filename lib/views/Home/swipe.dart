import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/back_swipe_card.dart';
import 'package:sauftrag/widgets/drink_status_dialog_box.dart';
import 'package:sauftrag/widgets/swipe_card.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
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

  //List data = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl3, ImageUtils.girl4, ImageUtils.girl5, ImageUtils.girl6, ImageUtils.girl7, ImageUtils.girl8, ImageUtils.girl9, ImageUtils.girl10, ImageUtils.girl11, ImageUtils.girl12];
  //List data = [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl3, ImageUtils.girl4, ImageUtils.girl5, ImageUtils.girl6];

  List<List<String>> data = [
    [ImageUtils.girl1, ImageUtils.girl2, ImageUtils.girl3, ImageUtils.girl4, ImageUtils.girl5, ImageUtils.girl6],
    [ImageUtils.girl7, ImageUtils.girl8, ImageUtils.girl9, ImageUtils.girl10, ImageUtils.girl11, ImageUtils.girl12],
    [ImageUtils.girl2, ImageUtils.girl4, ImageUtils.girl6, ImageUtils.girl8, ImageUtils.girl10, ImageUtils.girl12],
    [ImageUtils.girl12, ImageUtils.girl11, ImageUtils.girl10, ImageUtils.girl9, ImageUtils.girl8, ImageUtils.girl7],
    [ImageUtils.girl6, ImageUtils.girl5, ImageUtils.girl4, ImageUtils.girl3, ImageUtils.girl2, ImageUtils.girl1],
  ];

  List selectedData = [];

  void initState() {
    super.initState();

    _buttonController = new AnimationController(duration: new Duration(milliseconds: 1000), vsync: this);

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

                          Text(
                            "Discover",
                            style: TextStyle(
                              color: ColorUtils.black,
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.5.t,
                            ),
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
                    Expanded(
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
                    ),
                    SizedBox(height: 2.h),

                    Row(
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
                    ),
                    SizedBox(height: 6.h),


                  ],
                ),
              )
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
