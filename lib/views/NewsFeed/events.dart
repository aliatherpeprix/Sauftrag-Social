import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
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
        model.getEvent(context);

      },
      builder: (context, model, child) {
        return model.eventLoader? Center(child: AllPageLoader()):SafeArea(
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
                    height: 3.h,
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
                      physics: BouncingScrollPhysics()
                      ,
                      child: Column(
                        children: [
                          //SizedBox(height: 4.h,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Upcoming Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.2.t,
                                    color: ColorUtils.text_dark,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    model.navigateToUpcomingBarEventScreen();
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.7.t,
                                      color: ColorUtils.text_red,
                                      decoration: TextDecoration.underline,

                                      // shadows: [
                                      //   Shadow(
                                      //       color: ColorUtils.text_red,
                                      //       offset: Offset(0, -3))
                                      // ],
                                      // color: Colors.transparent,
                                      // decoration:
                                      // TextDecoration.underline,
                                      // decorationColor: ColorUtils.text_red,
                                      // decorationThickness: 1,
                                      // decorationStyle:
                                      // TextDecorationStyle.solid,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Container(
                            margin: EdgeInsets.only(right: 2.w,),
                            height: 35.h,
                            //width: 70.w,
                            child: ListView.separated(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                //padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      // model.navigateToEventDetailsScreen();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w, bottom: 2.h,),
                                      child: GestureDetector(
                                        onTap : (){
                                          model.selectedUpcomingEvents = (model.listOfUpcomingEvents[index]);
                                          // model.selectedBar = (model.listOfBar[index]);
                                          model.navigateToUpcomingBarEventDetails();
                                        },
                                        child: Container(
                                          width: 65.w,
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
                                            // border: Border.all(color: ColorUtils.text_red),
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
                                                      child:  Image.network(model.listOfUpcomingEvents![index].media![0].media,
                                                        fit: BoxFit.fill,
                                                        height: 17.h,
                                                        width: 60.w,
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
                                                              Text(model.listOfUpcomingEvents![index].event_date!.substring(8, 10),
                                                                style: TextStyle(
                                                                    fontFamily: FontUtils.modernistBold,
                                                                    fontSize: 2.2.t,
                                                                    color: ColorUtils.text_red
                                                                ),
                                                              ),
                                                              Text(model.listOfUpcomingEvents![index].event_date!.substring(0, 7),
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
                                                      Text(model.listOfUpcomingEvents![index].name!,
                                                        style: TextStyle(
                                                            fontFamily: FontUtils.modernistBold,
                                                            fontSize: 2.3.t,
                                                            color: ColorUtils.blackText
                                                        ),
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            //color: Colors.red,
                                                            child: Image.asset(ImageUtils.groupGoing,
                                                              width: 16.i,
                                                              height: 7.i,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          SizedBox(width: 3.w,),
                                                          Text("+20 Going",
                                                            style: TextStyle(
                                                              fontFamily: FontUtils.modernistRegular,
                                                              fontSize: 1.6.t,
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
                                                          Text(model.listOfUpcomingEvents![index].location!,
                                                            style: TextStyle(
                                                              fontFamily: FontUtils.modernistRegular,
                                                              fontSize: 1.6.t,
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
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 1.w,);
                                },
                                itemCount: 4
                            ),
                          ),
                          SizedBox(height: 2.5.h,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("All Events",
                                  style: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.3.t,
                                    color: ColorUtils.text_dark,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    model.navigateToAllEventListScreen();
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      fontFamily: FontUtils.modernistRegular,
                                      fontSize: 1.7.t,
                                      color: ColorUtils.red_color,
                                      decoration:
                                      TextDecoration.underline,
                                      decorationColor: ColorUtils.text_red,

                                      // shadows: [
                                      //   Shadow(
                                      //       color: ColorUtils.text_red,
                                      //       offset: Offset(0, -3))
                                      // ],
                                      // color: Colors.transparent,
                                      // decoration:
                                      // TextDecoration.underline,
                                      // decorationColor: ColorUtils.text_red,
                                      // decorationThickness: 1,
                                      // decorationStyle:
                                      // TextDecorationStyle.solid,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.5.h,),
                          //SizedBox(height: 3.h,),
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              dynamic time = model.barEventModel![index].startTime;
                              time =time.toString().split(':00');
                              print(time);
                              return GestureDetector(
                                onTap: (){
                                  model.navigationService.navigateToEventDetailScreen(model.barEventModel?[index].media?[0].media ??'',model.barEventModel![index].name,model.barEventModel![index].eventDate,model.barEventModel![index].startTime,model.barEventModel![index].endTime,model.barEventModel![index].location,model.barEventModel![index].about,model.barEventModel![index].userId!.username,model.barEventModel![index].userId!.profilePicture);
                                },
                                child: Padding(
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
                                                child: Image.network(model.barEventModel?[index].media![0].media,
                                                  width: 20.i,
                                                  height: 20.i,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(width: 3.w,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(model.barEventModel![index].eventDate +' -'+time[0],
                                                    style: TextStyle(
                                                        fontFamily: FontUtils.modernistRegular,
                                                        fontSize: 1.7.t,
                                                        color: ColorUtils.text_red
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h,),
                                                  Text(model.barEventModel![index].name,
                                                    style: TextStyle(
                                                        fontFamily: FontUtils.modernistBold,
                                                        fontSize: 2.2.t,
                                                        color: ColorUtils.blackText
                                                    ),
                                                  ),
                                                  SizedBox(height: 1.h,),
                                                  Text(model.barEventModel![index].location,
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
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height:  SizeConfig.heightMultiplier * 2.5,);
                            },
                            itemCount: 4,
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