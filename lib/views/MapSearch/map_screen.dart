import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

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
      'text' : "Night Club",
    },
    {
      'image': ImageUtils.musicIcon,
      'text' : "Pub",
    },
    {
      'image': ImageUtils.chaimpaineGlass,
      'text' : "Bar",
    },
    {
      'image': ImageUtils.calenderFilter,
      'text' : "Events",
    },
    {
      'image': ImageUtils.knife,
      'text' : "Food",
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
            body: Stack(
              children: [
                Container(
                  child: GoogleMap(
                    markers: Set<Marker>.of(model.markers),
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: model.kGooglePlex,
                    //circles: model.mCircles ?? {},
                    //model.circles ?? {},
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller)async {
                      model.controller.complete(controller);
                      //model.getAddress();
                    },
                    //markers: model.markers!,
                    //polylines: Set<Polyline>.of(model.polylines.values),
                    //markers: model.markers!,
                    //Set<Marker>.of(model.newMarkers.values),
                    //markers: model.markers!,
                  ),
                ),
                Container(
                  //width: 200.0,
                  margin: EdgeInsets.only(
                      left: SizeConfig.widthMultiplier * 4.5,
                      right: SizeConfig.widthMultiplier * 5,
                      top: SizeConfig.heightMultiplier * 8),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 7.h),
                    height: 15.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
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
                        return SizedBox(
                          width:  SizeConfig.widthMultiplier * 2.5,
                        );
                      },
                      itemCount: places.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void filter(context, MainViewModel mainModel){
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return ViewModelBuilder.reactive(
            disposeViewModel: false,
            viewModelBuilder: () => locator<MainViewModel>(),
              builder: (context, model, child) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                  ),
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6.h, left: 4.w, right: 4.w),
                            child: Text("Filter",
                              style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 3.0.t,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Container(
                            height: 15.h,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    mainModel.eventSelected = true;
                                    mainModel.currentEventSelected = index;
                                    mainModel.notifyListeners();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 4.w,),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: mainModel.eventSelected == true && index == mainModel.currentEventSelected ? ColorUtils.text_red : Colors.white,
                                              border: Border.all(color: mainModel.eventSelected == true && index == mainModel.currentEventSelected ? ColorUtils.text_red : ColorUtils.borderColor,)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(13.0),
                                            child: Center(
                                              child: SvgPicture.asset(filterPlaces[index]["image"],
                                                color: mainModel.eventSelected == true && index == mainModel.currentEventSelected ? Colors.white : ColorUtils.icon_color,
                                                width: 7.i,
                                                height: 7.i,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.h,),
                                        Text(filterPlaces[index]["text"]),
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
                            child: Text("Time & Date",
                              style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.0.t,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Container(
                            height: 6.h,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    mainModel.timeSelected = true;
                                    mainModel.timeValue = index;
                                    mainModel.notifyListeners();
                                    // mainModel.currentEventSelected = index;
                                     mainModel.notifyListeners();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 4.w,),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: mainModel.timeSelected == true && index == mainModel.timeValue ? ColorUtils.text_red : Colors.white,
                                          border: Border.all(color: mainModel.timeSelected == true && index == mainModel.timeValue ? ColorUtils.text_red : ColorUtils.borderColor,)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(3.5.i),
                                        child: Text(time[index],
                                          style: TextStyle(
                                            color: mainModel.timeSelected == true && index == mainModel.timeValue ? Colors.white : ColorUtils.icon_color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 0.5.w,
                                );
                              },
                              itemCount: time.length,
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                            margin: EdgeInsets.only(left: 4.w, right: 4.w),
                            child: Text("Location",
                              style: TextStyle(
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 2.0.t,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            // width: double.infinity,
                            // height: 6.5.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                                border: Border.all(
                                  //width: 2.0,
                                  color: ColorUtils.text_red,
                                )),
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 2.2.w,
                                right: 2.3.w,
                              ),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 15.w,
                                            height: 7.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(Radius.circular(11.89)),
                                              color: ColorUtils.text_red,
                                            ),
                                          ),
                                          Container(
                                            width: 10.w,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(ImageUtils.locationPin,
                                                width: 5.i,
                                                height: 5.i,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 4.i,
                                      minHeight: 4.i,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.transparent),
                                    )),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  //size: 6.i,
                                ),
                                onChanged: (newValue) {
                                  selectedLocation = newValue;
                                  setState(() {});
                                },
                                items: location.map((city) {
                                  return DropdownMenuItem(
                                    value: city,
                                    child: new Text(
                                      city,
                                      // style: TextStyle(
                                      //   fontFamily: FontUtils.avertaSemiBold,
                                      //   fontSize: 2.3.t,
                                      //   color: ColorUtils.blueColor,
                                      // ),
                                    ),
                                  );
                                }).toList(),
                                value: selectedLocation,
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
    );
  }
}
