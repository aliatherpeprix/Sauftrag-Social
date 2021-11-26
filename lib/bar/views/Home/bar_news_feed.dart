import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/widgets/my_side_menu.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/drink_status_dialog_box.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:stacked/stacked.dart';
import 'package:sauftrag/viewModels/navigation_view_model.dart';
import 'dart:math' as math;

class BarNewsFeed extends StatefulWidget {
  const BarNewsFeed({Key? key}) : super(key: key);

  @override
  _BarNewsFeedState createState() => _BarNewsFeedState();
}

class _BarNewsFeedState extends State<BarNewsFeed> {
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  List newsEvents = [
    {
      'image': ImageUtils.person_1,
      'barOwnerName': 'Nellie Mendez',
      'para':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': false,
      'comment': '68',
      'commentIon': ImageUtils.msgIcon,
      'likes': '53.5 k',
      'likesIcon': ImageUtils.matchedIcon,
    },
    {
      'image': ImageUtils.person_2,
      'barOwnerName': 'Ron Wright',
      'para':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': true,
      'commentIon': ImageUtils.msgIcon,
      'comment': '68',
      'likesIcon': ImageUtils.matchedIcon,
      'likes': '53.5 k',
    },
    {
      'image': ImageUtils.person_1,
      'barOwnerName': 'Nellie Mendez',
      'para':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer pulvinar blandit magna.',
      'image2': ImageUtils.feedImg,
      'imgPre': false,
      'commentIon': ImageUtils.msgIcon,
      'comment': '68',
      'likesIcon': ImageUtils.matchedIcon,
      'likes': '53.5 k',
    },
  ];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double initialBottom = 15.0;
    double backCardWidth = 0.0;

    return ViewModelBuilder<MainViewModel>.reactive(
      // onModelReady: (data) {
      //   data.buttonController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
      //   data.initSwipe();
      // },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          child: SideMenu(
            key: model.sideMenuKey,
            type: SideMenuType.shrinkNSlide,
            background: ColorUtils.text_red,
            radius: BorderRadius.circular(30),
            menu: MySideMenu(),
            child: Scaffold(
                backgroundColor: ColorUtils.white,
                floatingActionButton: ExpandableFab(
                  distance: 120.0,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            model.navigateToCreateEventScreen();
                          },
                          child: Container(
                              decoration: BoxDecoration(

                                color: ColorUtils.text_red,
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                //border: Border.all(color: ColorUtils.red_color),
                              ),
                              height: 5.4.h,
                              width: 11.5.w,
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: SvgPicture.asset(
                                  ImageUtils.calender,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            decoration: BoxDecoration(

                              color: ColorUtils.text_red,
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              //border: Border.all(color: ColorUtils.red_color),
                            ),
                            height: 5.4.h,
                            width: 11.5.w,
                            child: Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: SvgPicture.asset(
                                ImageUtils.pen2,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endDocked,
                body: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.homeTopMargin),

                      //Top bar
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.horizontalPadding),
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
                            Text(
                              "News Feed",
                              style: TextStyle(
                                color: ColorUtils.black,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.5.t,
                              ),
                            ),
                            Container(
                              // onPressed: () {
                              //  /* showDialog(
                              //       context: context,
                              //       builder: (BuildContext context){
                              //         return DrinkStatusDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                              //       }
                              //   );*/
                              // },
                              child: Image.asset(ImageUtils.profileImg),
                            ),
                          ],
                        ),
                      ),
                      //SizedBox(height: 3.h),

                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorUtils.black.withOpacity(0.1),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 5), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  //border: Border.all(color: ColorUtils.red_color),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.5.w, vertical: 1.h),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  newsEvents[index]["image"],
                                                  width: 10.i,
                                                  height: 10.i,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                newsEvents[index]["barOwnerName"],
                                                style: TextStyle(
                                                    fontFamily:
                                                        FontUtils.modernistBold,
                                                    fontSize: 2.2.t,
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorUtils.black),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            newsEvents[index]["para"],
                                            style: TextStyle(
                                                fontFamily:
                                                    FontUtils.modernistRegular,
                                                fontSize: 1.8.t,
                                                color: ColorUtils.black),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          if (newsEvents[index]["imgPre"] == true)
                                            Container(
                                                child: Image.asset(
                                              newsEvents[index]["image2"],
                                            )),
                                          Divider(),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    newsEvents[index]
                                                        ["commentIon"],
                                                    color: ColorUtils.icon_color,
                                                  ),
                                                  SizedBox(
                                                    width: 1.5.w,
                                                  ),
                                                  Text(
                                                    newsEvents[index]["comment"],
                                                    style: TextStyle(
                                                        fontFamily: FontUtils
                                                            .modernistRegular,
                                                        fontSize: 1.5.t,
                                                        color: ColorUtils
                                                            .icon_color),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 7.w),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    newsEvents[index]
                                                        ["likesIcon"],
                                                    color: ColorUtils.icon_color,
                                                  ),
                                                  SizedBox(
                                                    width: 1.5.w,
                                                  ),
                                                  Text(
                                                    newsEvents[index]["likes"],
                                                    style: TextStyle(
                                                        fontFamily: FontUtils
                                                            .modernistRegular,
                                                        fontSize: 1.5.t,
                                                        color: ColorUtils
                                                            .icon_color),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: SizeConfig.heightMultiplier * 2.5,
                            );
                          },
                          itemCount: newsEvents.length,
                        ),
                      ),

                      SizedBox(height: 2.h),
                    ],
                  ),
                )),
          ),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 55.0,
      height: 124.0,
      child: Center(
        child: Material(
          color: ColorUtils.text_red,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  ImageUtils.pen,
                  height: 3.h,
                  width: 2.w,
                )),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
            opacity: _open ? 0.0 : 1.0,
            curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
            duration: const Duration(milliseconds: 250),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              child: FloatingActionButton(
                  backgroundColor: ColorUtils.text_red,
                  onPressed: _toggle,
                  child: SvgPicture.asset(
                    ImageUtils.pen,
                    height: 3.h,
                    width: 2.w,
                  )),
            )),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: -115.0 + offset.dx,
          bottom: 110.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.accentColor,
      elevation: 4.0,
      child: IconTheme.merge(
        data: theme.accentIconTheme,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    Key? key,
    required this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}
