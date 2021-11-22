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
                        Container(
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
}
