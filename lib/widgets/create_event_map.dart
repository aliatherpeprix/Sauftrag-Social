import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:stacked/stacked.dart';

import '../viewModels/registrationViewModel.dart';

class CreateEventMap extends StatefulWidget {
  const CreateEventMap({Key? key}) : super(key: key);

  @override
  _CreateEventMapState createState() => _CreateEventMapState();
}

class _CreateEventMapState extends State<CreateEventMap> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      viewModelBuilder: () => locator<AuthenticationViewModel>(),
      onModelReady: (model) {
        model.determinePosition();
      },
      disposeViewModel: false,
      builder: (context, model, child) {
        return
          SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
                backgroundColor: Colors.white,
                floatingActionButton: Container(
                    margin: EdgeInsets.only(left: 3.w, bottom: 2.h),
                    child: Row(
                      children: [

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ElevatedButton(
                              onPressed: () {
                                model.locationController.text = model.address;
                                model.navigateBack();
                              },
                              child: Text('Use this Location'),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.red_color  ,
                                onPrimary: ColorUtils.white,
                                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                textStyle: TextStyle(
                                  color: ColorUtils.white,
                                  fontFamily: FontUtils.modernistBold,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),
                          ),
                        ),

                        FloatingActionButton(
                            elevation: 3,
                            onPressed: () {
                              model.navigateToPosition(LatLng(model.currentPosition!.latitude, model.currentPosition!.longitude),);
                            },
                            backgroundColor: ColorUtils.white,
                            child: SvgPicture.asset(ImageUtils.location_icon, color: ColorUtils.red_color,)),
                      ],
                    )
                ),
                body: Stack(
                  children: [

                    GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      initialCameraPosition: model.kGooglePlex,
                      onMapCreated: (gController)async {
                        model.mapController = gController;
                        model.controller.complete(gController);
                      },
                      markers: Set<Marker>.of(model.marker),
                      onTap: (latlng){
                        //model.addMarker(latlng);
                        model.navigateToPosition(latlng);
                      },
                    ),

                    GestureDetector(
                      onTap: (){
                        model.searchAddress(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorUtils.black.withOpacity(0.1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(
                          model.address,
                          style: TextStyle(
                              color: ColorUtils.text_dark,
                              fontSize: 1.6.t,
                              fontFamily: FontUtils.modernistRegular
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          );
      },
    );
  }
}
