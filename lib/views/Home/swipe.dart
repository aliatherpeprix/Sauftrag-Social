import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Swipe extends StatefulWidget {

  const Swipe({Key? key}) : super(key: key);

  @override
  _SwipeState createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> with TickerProviderStateMixin {

  List<SwipeItem> _swipeItems = [];
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
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);

    //matchEngine.currentItem.
    super.initState();
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
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: Dimensions.homeTopMargin),

                      //Top bar
                      Row(
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
                      SizedBox(height: 5.h),

                      Expanded(
                        child: Container(
                          //height: 550,
                          child: SwipeCards(
                            matchEngine: _matchEngine,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    image: DecorationImage(image: AssetImage(_swipeItems[index].content.text), fit: BoxFit.cover),
                                  ),
                                alignment: Alignment.center,
                                //color: _swipeItems[index].content.color,
                                //child: Image.asset(_swipeItems[index].content.text)
                              );
                            },
                            onStackFinished: () {
                              _scaffoldKey.currentState!.showSnackBar(SnackBar(
                                content: Text("Stack Finished"),
                                duration: Duration(milliseconds: 500),
                              ));
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          ElevatedButton(
                            onPressed: () {

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
