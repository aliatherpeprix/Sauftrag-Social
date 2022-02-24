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
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:sauftrag/widgets/drink_status_dialog_box.dart';
import 'package:sauftrag/widgets/drink_update_status_dialog_box.dart';
import 'package:sauftrag/widgets/my_side_menu.dart';
import 'package:sauftrag/widgets/swipe_card.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';

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
  List<List<String>> data = [
    [
      ImageUtils.girl4,
      ImageUtils.girl5,
      ImageUtils.girl6,
    ],
    [
      ImageUtils.girl1,
      ImageUtils.girl2,
      ImageUtils.girl3,
    ],
    [
      ImageUtils.girl10,
      ImageUtils.girl11,
      ImageUtils.girl12,
      ImageUtils.girl13
    ],
    [
      ImageUtils.girl7,
      ImageUtils.girl8,
      ImageUtils.girl9,
    ],
    [
      ImageUtils.girl4,
      ImageUtils.girl5,
      ImageUtils.girl6,
    ],
    [
      ImageUtils.girl1,
      ImageUtils.girl2,
      ImageUtils.girl3,
    ],
  ];

  List selectedData = [];

  late PageController pageController;
  final currentPageNotifier = ValueNotifier<int>(0);
  void initState() {
    super.initState();
    MainViewModel model = locator<MainViewModel>();
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

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
          var i = model.catalogImages.removeLast();
          model.catalogImages.insert(0, i);
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

  dismissImg(List img, MainViewModel model) {
    if (model.catalogImages.indexOf(img) ==
        model.catalogImages.indexOf(model.catalogImages.first)) {
      model.getDiscover(context);
    }
    setState(() {
      model.catalogImages.remove(img);
    });

    print(model.catalogImages.length);
  }

  addImg(List img, MainViewModel model) {
    setState(() {
      model.catalogImages.remove(img);
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
      onModelReady: (data) {
        data.getDiscover(context);
      },
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
              body: InkWell(
                onTap: (){
                  final _state = model.sideMenuKey.currentState;
                  if (_state!.isOpened)
                    _state.closeSideMenu();
                  model.notifyListeners();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0, vertical: Dimensions.verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.homeTopMargin),

                      //Top bar
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.horizontalPadding),
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
                                model.notifyListeners();
                              },
                              child: SvgPicture.asset(ImageUtils.menuIcon),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.white,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Dimensions.containerVerticalPadding),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.divider, width: 1)),
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
                                if (model.getStatus != null) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DrinkUpdateStatusDialogBox(
                                            title: "Add New Location",
                                            btnTxt: "Add Location",
                                            icon: ImageUtils.addLocationIcon);
                                      });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DrinkStatusDialogBox(
                                            title: "Add New Location",
                                            btnTxt: "Add Location",
                                            icon: ImageUtils.addLocationIcon);
                                      });
                                }
                              },
                              child: model.getStatus == null
                            ? SvgPicture.asset(ImageUtils.setStatusIcon)
                      : Row(
                children: [
                SvgPicture.asset(
                ImageUtils.bottleSelected,
                  height: 3.5.h,
                ),
                Text(
                  "x${model.getStatus!.quantity}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 1.2.t,
                      height: 0.5.h),
                  textAlign: TextAlign.end,
                ),
                Container(
                  width: 15.w,
                  alignment: Alignment.center,
                  child: Text(
                    "Motor anwärmen",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorUtils.text_red,
                      fontFamily:
                      FontUtils.modernistBold,
                      fontSize: 1.2.t,
                    ),
                  ),
                ),
                ],
              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                //onPrimary: ColorUtils.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.5.h, horizontal: 3.3.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.divider, width: 1)),
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
                      Expanded(
                        child: Container(
                          //margin: EdgeInsets.symmetric(vertical: 2.h),
                          child: model.discoverLoader
                              ? AllPageLoader()
                              : model.catalogImages.isEmpty?Image.asset(ImageUtils.UserNotFound):AbsorbPointer(
                            absorbing: model.sideMenuKey.currentState != null && model.sideMenuKey.currentState!.isOpened,
                                child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: model.catalogImages.map((item) {
                                      return  SwipeCard(
                                        name: model
                                            .discoverModel![
                                                model.catalogImages.indexOf(item)]
                                            .username,
                                        img: item,
                                        cardWidth: backCardWidth + 0,
                                        rotation: rotate.value,
                                        skew: rotate.value < -10 ? 0.1 : 0.0,
                                        address: model
                                            .discoverModel![
                                                model.catalogImages.indexOf(item)]
                                            .address,
                                        details: () {
                                          model.navigateToProfileScreen(
                                              item,
                                              model.matchName[model.catalogImages
                                                  .indexOf(item)],
                                              model
                                                  .discoverModel![model
                                                      .catalogImages
                                                      .indexOf(item)]
                                                  .address!,
                                              model
                                                  .discoverModel![model
                                                      .catalogImages
                                                      .indexOf(item)]
                                                  .favorite_alcohol_drinks!,
                                              model
                                                  .discoverModel![model
                                                      .catalogImages
                                                      .indexOf(item)]
                                                  .favorite_night_club!,
                                              model
                                                  .discoverModel![model
                                                      .catalogImages
                                                      .indexOf(item)]
                                                  .favorite_party_vacation!,
                                            model
                                                .discoverModel![
                                            model.catalogImages.indexOf(item)]
                                                .id,
                                          );
                                        },
                                        right: right.value,
                                        left: 0.0,
                                        addImg: addImg,
                                        bottom: bottom.value,
                                        flag: flag,
                                        dismissImg: dismissImg,
                                        swipeRight: swipeRight,
                                        swipeLeft: swipeLeft,
                                        id: model
                                            .discoverModel![
                                                model.catalogImages.indexOf(item)]
                                            .id,
                                      );
                                    }).toList(),
                                  ),
                              ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
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
