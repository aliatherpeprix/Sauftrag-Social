import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:sauftrag/utils/extensions.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {

  List upComingEvents = [
    {'image': ImageUtils.upComingEvent,
      'eventName': 'Lorem Ipsum',
      'date': '10',
      'month': ' June',
      'location': 'Lot 13 • Oakland, CA',
      'going': '+20',
      'goingGroup': ImageUtils.groupGoing
    },
    {'image': ImageUtils.upComingEvent,
      'eventName': 'Lorem Ipsum',
      'date': '10',
      'month': ' June',
      'location': 'Lot 13 • Oakland, CA',
      'going': '+20',
      'goingGroup': ImageUtils.groupGoing
    },
  ];

  List places = [
    {
      'image': ImageUtils.place1,
      'eventName': 'Trivia Nights',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.place2,
      'eventName': 'Bar Crawl Stop',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.place3,
      'eventName': 'Singles Night',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
    {
      'image': ImageUtils.place4,
      'eventName': 'Bar Olympics',
      'date': '1st  May- Sat -2:00 PM',
      'location': 'Lot 13 • Oakland, CA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model){
      },
      builder: (context, model, child) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            // key: _scaffoldKey,
            // drawer: DrawerScreen(),
            // bottomNavigationBar: MyCurvedNavBar(
            //   barIconColor: ColorUtils.silverColor,
            //   selectedIconColor: Colors.white,
            //   buttonBackgroundColor: ColorUtils.blueColor,
            //   index: currentIndex,
            //   animationCurve: Curves.ease,
            //   animationDuration: Duration(milliseconds: 300),
            //   backgroundColor: Colors.white,
            //   height: 8.h,
            //   parentDecoration: BoxDecoration(
            //       boxShadow: [BoxShadow(
            //           color: Color(0xFFefefef),
            //           blurRadius: 3.i,
            //           offset: Offset(0,-10)
            //       )]
            //   ),
            //   items: [
            //     ImageUtils.homeIcon,
            //     ImageUtils.chatIcon,
            //     ImageUtils.addIcon,
            //     ImageUtils.searchIcon,
            //     ImageUtils.calenderIcon,
            //   ],
            //   onTap: (index){
            //   },
            // ),
            backgroundColor: Colors.white,
            body: Container(
              //margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(left: 1.5.w, right: 4.w),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       IconButton(
                  //         onPressed: () =>
                  //             _scaffoldKey.currentState!.openDrawer(),
                  //         icon: SvgPicture.asset(
                  //             ImageUtils.menuIcon),
                  //       ),
                  //       SvgPicture.asset(ImageUtils.notificationBell),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 4.h,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Upcoming Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.6.t,
                                    color: ColorUtils.text_dark,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    //model.navigationService.navigateTo(to: ForgotPassword());
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.7.t,

                                        shadows: [
                                          Shadow(
                                              color: ColorUtils.text_red,
                                              offset: Offset(0, -3))
                                        ],
                                        color: Colors.transparent,
                                        decoration:
                                        TextDecoration.underline,
                                        decorationColor: ColorUtils.text_red,
                                        decorationThickness: 1,
                                        decorationStyle:
                                        TextDecorationStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                            //margin: EdgeInsets.only(left: 0.w,right: 1.w),
                            height: 38.5.h,
                            //width: 70.w,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                //padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      //model.navigationService.navigateTo(to: EventDetails());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0.0, 5),
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 10.0,
                                                spreadRadius: 0
                                            ),
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(18)),
                                          border: Border.all(color: ColorUtils.text_red),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.asset(upComingEvents[index]["image"],
                                                      fit: BoxFit.fitHeight,
                                                      height: 20.h,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 3.w,
                                                    top: 1.5.h,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.70),
                                                        borderRadius: BorderRadius.all(Radius.circular(18)),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.25.h),
                                                        child: Column(
                                                          children: [
                                                            Text(upComingEvents[index]["date"],
                                                              style: TextStyle(
                                                                  fontFamily: FontUtils.modernistBold,
                                                                  fontSize: 2.2.t,
                                                                  color: ColorUtils.text_red
                                                              ),
                                                            ),
                                                            Text(upComingEvents[index]["month"],
                                                              style: TextStyle(
                                                                  fontFamily: FontUtils.modernistRegular,
                                                                  color: ColorUtils.text_red
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 2.h,),
                                              Container(
                                                margin: EdgeInsets.only(left: 2.2.w),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Trivia Nights",
                                                      style: TextStyle(
                                                          fontFamily: FontUtils.modernistBold,
                                                          fontSize: 2.4.t,
                                                          color: ColorUtils.blackText
                                                      ),
                                                    ),
                                                    SizedBox(height: 1.h,),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          //color: Colors.red,
                                                          child: Image.asset(upComingEvents[index]["goingGroup"],
                                                            width: 16.i,
                                                            height: 7.i,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(width: 3.w,),
                                                        Text(upComingEvents[index]["going"] + " Going",
                                                          style: TextStyle(
                                                            fontFamily: FontUtils.modernistRegular,
                                                            fontSize: 1.7.t,
                                                            color: ColorUtils.goingColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 1.h,),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(ImageUtils.upcomingLocation),
                                                        SizedBox(width: 1.w,),
                                                        Text(upComingEvents[index]["location"],
                                                          style: TextStyle(
                                                            fontFamily: FontUtils.modernistRegular,
                                                            fontSize: 1.7.t,
                                                            color: ColorUtils.text_dark,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 1.w,);
                                },
                                itemCount: upComingEvents.length
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("All Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.6.t,
                                    color: ColorUtils.text_dark,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    //model.navigationService.navigateTo(to: ForgotPassword());
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.7.t,

                                        shadows: [
                                          Shadow(
                                              color: ColorUtils.text_red,
                                              offset: Offset(0, -3))
                                        ],
                                        color: Colors.transparent,
                                        decoration:
                                        TextDecoration.underline,
                                        decorationColor: ColorUtils.text_red,
                                        decorationThickness: 1,
                                        decorationStyle:
                                        TextDecorationStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(height: 3.h,),
                          ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal:SizeConfig.widthMultiplier * 4,),
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
                                    borderRadius: BorderRadius.all(Radius.circular(18)),
                                    border: Border.all(color: ColorUtils.red_color),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(places[index]["image"],
                                                width: 20.i,
                                                height: 20.i,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 3.w,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(places[index]["date"],
                                                  style: TextStyle(
                                                      fontFamily: FontUtils.modernistRegular,
                                                      fontSize: 1.7.t,
                                                      color: ColorUtils.text_red
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Text(places[index]["eventName"],
                                                  style: TextStyle(
                                                      fontFamily: FontUtils.modernistBold,
                                                      fontSize: 2.2.t,
                                                      color: ColorUtils.blackText
                                                  ),
                                                ),
                                                SizedBox(height: 1.h,),
                                                Text(places[index]["location"],
                                                  style: TextStyle(
                                                      fontFamily: FontUtils.modernistRegular,
                                                      fontSize: 1.7.t,
                                                      color: ColorUtils.text_dark
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                            },
                            itemCount: places.length,
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}