import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';
import 'package:stacked/stacked.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

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

  List filterPlaces = [
    {
      'image': ImageUtils.discoBall,
      'text': "Beer Hall",
    },
    {
      'image': ImageUtils.musicIcon,
      'text': "Hotel Bar",
    },
    {
      'image': ImageUtils.chaimpaineGlass,
      'text': "Pub",
    },
    {
      'image': ImageUtils.calenderFilter,
      'text': "Cocktail",
    },
    {
      'image': ImageUtils.knife,
      'text': "Disco",
    },
  ];

  List time = [
    "Today",
    "Tomorrow",
    "This week",
  ];

  List<String> location = [
    'Karachi, Pakistan',
    'Lahore, Pakistan',
    'Islamabad, Pakistan',
  ];

  String? selectedLocation;

  @override
  void initState() {
    // TODO: implement initState
    selectedLocation = 'Karachi, Pakistan';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
        builder: (context, model, child) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                child: Column(

                  children: [
                    SizedBox(height: Dimensions.topMargin),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: IconButton(
                                onPressed: () {
                                  model.navigateToMapScreen();
                                  //model.navigateBack();
                                },
                                iconSize: 18.0,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorUtils.black,
                                  size: 4.5.i,
                                )),),
                      ],
                    ),
                    //SizedBox(height: 3.h,),
                    Container(
                      //width: 200.0,
                      margin: EdgeInsets.only(
                          left: SizeConfig.widthMultiplier * 4.5,
                          right: SizeConfig.widthMultiplier * 5,
                          top: SizeConfig.heightMultiplier * 3),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: ColorUtils.shadowColor.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                        color: ColorUtils.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: Container(
                        //color: Colors.amber,
                        margin:
                        EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 3,),
                        child: Row(
                          children: [
                            Container(
                              child: SvgPicture.asset(ImageUtils.searchIcon),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.widthMultiplier * 3,
                                    right: SizeConfig.widthMultiplier * 3),
                                child: TextField(
                                  onTap: () {},
                                  enabled: true,
                                  //readOnly: true,
                                  //focusNode: model.searchFocus,
                                  controller: model.mapSearchController,
                                  decoration: InputDecoration(
                                    hintText: "Where are you going to ?",
                                    hintStyle: TextStyle(
                                      //fontFamily: FontUtils.proximaNovaRegular,
                                      color: ColorUtils.icon_color,
                                      fontSize: SizeConfig.textMultiplier * 1.9,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: SizeConfig.heightMultiplier * 2),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                filter(context, model);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorUtils.text_red,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(ImageUtils.filterIcon),
                                      ),
                                    ),
                                    Text("Filters",
                                      style: TextStyle(
                                          fontFamily: FontUtils.avertaDemo,
                                          fontSize: 1.8.t,
                                          color: ColorUtils.filterText
                                      ),
                                    ),
                                    SizedBox(width: 2.w,),
                                  ],
                                ),
                              ),
                            ),
                            // Text(searchHere,
                            //   style: TextStyle(
                            //     fontFamily: FontUtils.gibsonRegular,
                            //     fontWeight: FontWeight.w400,
                            //     fontSize: SizeConfig.textMultiplier * 1.8,
                            //     color: ColorUtils.searchFieldText,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 3,),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal:SizeConfig.widthMultiplier * 4,),
                            child: GestureDetector(
                              onTap: (){
                                model.selectedUpcomingEvents = (model.addFilters[index]);
                                // model.selectedBar = (model.listOfBar[index]);
                                model.navigateToUpcomingBarEventDetails();
                              },
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
                                            child: Image.network(model.addFilters[index].media![0].media,
                                              width: 20.i,
                                              height: 20.i,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 3.w,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(model.addFilters[index].event_date!,
                                                style: TextStyle(
                                                    fontFamily: FontUtils.modernistRegular,
                                                    fontSize: 1.7.t,
                                                    color: ColorUtils.text_red
                                                ),
                                              ),
                                              SizedBox(height: 1.h,),
                                              Text(model.addFilters[index].name!,
                                                style: TextStyle(
                                                    fontFamily: FontUtils.modernistBold,
                                                    fontSize: 2.2.t,
                                                    color: ColorUtils.blackText
                                                ),
                                              ),
                                              SizedBox(height: 1.h,),
                                              Text(model.addFilters[index].location!,
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
                        itemCount: model.addFilters.length,
                      ),
                    ),
                    SizedBox(height: 6.h,)
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
  void filter(context, MainViewModel mainModel) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft:  Radius.circular(25) ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return ViewModelBuilder.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => locator<MainViewModel>(),
            builder: (context, model, child) {
              return Container(
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(50),
                //         topLeft: Radius.circular(50))
                // ),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 3.0.t,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 15.h,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              mainModel.eventSelected = true;
                              mainModel.currentEventSelected = index;
                              mainModel.notifyListeners();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 4.w,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          if(mainModel.eventSelected ==
                                              true &&
                                              index ==
                                                  mainModel
                                                      .currentEventSelected)
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 0,
                                              blurRadius: 10,
                                              offset: Offset(0, 5), // changes position of shadow
                                            ),
                                        ],
                                        shape: BoxShape.circle,
                                        color: mainModel.eventSelected ==
                                            true &&
                                            index ==
                                                mainModel
                                                    .currentEventSelected
                                            ? ColorUtils.text_red
                                            : Colors.white,
                                        border: Border.all(
                                          color: mainModel.eventSelected ==
                                              true &&
                                              index ==
                                                  mainModel
                                                      .currentEventSelected
                                              ? ColorUtils.text_red
                                              : ColorUtils.borderColor,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          filterPlaces[index]["image"],
                                          color: mainModel.eventSelected ==
                                              true &&
                                              index ==
                                                  mainModel
                                                      .currentEventSelected
                                              ? Colors.white
                                              : ColorUtils.icon_color,
                                          width: 10.i,
                                          height: 10.i,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Text(filterPlaces[index]["text"],
                                    style: TextStyle(
                                        fontFamily: FontUtils.modernistRegular,
                                        fontSize: 1.7.t,
                                        color: ColorUtils.text_dark
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 0.5.w,
                          );
                        },
                        itemCount: filterPlaces.length,
                      ),
                    ),
                    //SizedBox(height: 0.5.h,),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Text(
                        "Time & Date",
                        style: TextStyle(
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.2.t,
                          color: ColorUtils.blackText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(

                      // margin: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 5.5.h,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              mainModel.timeSelected = true;
                              mainModel.timeValue = index;
                              mainModel.notifyListeners();
                              // mainModel.currentEventSelected = index;
                              mainModel.notifyListeners();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.w),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: mainModel.timeSelected == true &&
                                      index == mainModel.timeValue
                                      ? ColorUtils.text_red
                                      : Colors.white,
                                  border: Border.all(
                                    color: mainModel.timeSelected == true &&
                                        index == mainModel.timeValue
                                        ? ColorUtils.text_red
                                        : ColorUtils.borderColor,
                                  )),
                              child: Padding(
                                padding: EdgeInsets.all(3.i),
                                child: Text(
                                  time[index],
                                  style: TextStyle(
                                    fontFamily: FontUtils.modernistRegular,
                                    fontSize: 1.9.t,
                                    color: mainModel.timeSelected == true &&
                                        index == mainModel.timeValue
                                        ? Colors.white
                                        : ColorUtils.icon_color,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 6.w,
                          );
                        },
                        itemCount: time.length,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Text(
                        "Location",
                        style: TextStyle(
                          fontFamily: FontUtils.modernistBold,
                          fontSize: 2.2.t,
                          color: ColorUtils.blackText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    Container(
                      height: 7.h,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.containerVerticalPadding,
                          horizontal:
                          Dimensions.containerHorizontalPadding),
                      decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.roundCorner)),
                          border:
                          Border.all(color: ColorUtils.divider)),
                      child: GestureDetector(
                        onTap: () async {
                          mainModel.navigateToFilterEventScreen();
                          var position = await mainModel.determinePositionFilters();
                          mainModel.latitude = position.latitude;
                          mainModel.latitude = position.longitude;
                        },
                        child: Row(
                          children: [
                            Container(child: SvgPicture.asset(ImageUtils.locationIcon)
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: TextField(
                                focusNode: mainModel.filtersMapFocus,
                                controller: mainModel.filtersMapController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(
                                  color: ColorUtils.red_color,
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.9.t,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter location",
                                  hintStyle: TextStyle(
                                    fontFamily: FontUtils.modernistBold,
                                    fontSize: 2.t,
                                    color: ColorUtils.text_grey,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Range",
                            style: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 2.2.t,
                              color: ColorUtils.blackText,
                            ),
                          ),
                          Text(
                            mainModel.lowValue! +"km" + "-" + mainModel.highValue!+"km",
                            style: TextStyle(
                                fontFamily: FontUtils.modernistRegular,
                                fontSize: 2.0.t,
                                color: ColorUtils.text_red
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlutterSlider(
                      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                        handlerIndex = 0;

                        mainModel.lowerValue = lowerValue;
                        mainModel.upperValue = upperValue;
                        // print(_upperValue);
                        // print(_lowerValue);
                        setState(() {

                        });
                      },
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBar: BoxDecoration(
                          color: ColorUtils.text_red,
                        ),
                        inactiveTrackBar: BoxDecoration(
                          color: ColorUtils.text_red.withOpacity(0.2),
                        ),
                      ),
                      // handlerHeight: 0.0,
                      // handlerWidth: 0.0,
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image:AssetImage(ImageUtils.doubleArrow),
                          // ),
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            border: Border.all(color: ColorUtils.text_red)),
                        child: Image.asset(
                          ImageUtils.doubleArrow,
                          height: 5.i,
                          width: 5.i,
                        ),
                      ),
                      rightHandler: FlutterSliderHandler(
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   image:AssetImage(ImageUtils.doubleArrow),
                          // ),
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            border: Border.all(color: ColorUtils.text_red)),
                        child: Image.asset(
                          ImageUtils.doubleArrow,
                          height: 5.i,
                          width: 5.i,
                        ),
                      ),
                      values: [mainModel.lowerValue, mainModel.upperValue],
                      rangeSlider: true,
                      max: 50,
                      min: 0,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        mainModel.lowerValue = lowerValue;
                        mainModel.upperValue = upperValue;
                        mainModel.lowValue = mainModel.lowerValue.toStringAsFixed(0);
                        mainModel.highValue =  mainModel.upperValue.toStringAsFixed(0);
                        mainModel.notifyListeners();
                      },
                    ),
                    SizedBox(height: 3.h,),
                    Container(
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                mainModel.eventSelected = false;
                                mainModel.currentEventSelected = null;
                                mainModel.timeSelected = false;
                                mainModel.timeValue = null;
                                mainModel.notifyListeners();
                              },
                              child: Text("RESET"),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 5.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 5.w,),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                mainModel.addEventFilters();
                                //mainModel.navigateToMapSearchScreen();
                              },
                              child: Text("APPLY"),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.text_red,
                                onPrimary: ColorUtils.white,
                                padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 5.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                  ],
                ),
              );
            },
          );
        });
  }
}
