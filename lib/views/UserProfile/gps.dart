import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';


class GPS extends StatefulWidget {
  @override
  _GPSState createState() => _GPSState();
}

class _GPSState extends State<GPS> {

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return

          Scaffold(
            appBar: AppBar(elevation: 0,
              leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 15,)),
              title: Text("GPS",style:TextStyle(fontSize: 2.5.t,fontFamily: FontUtils.modernistBold,color: Colors.black),),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,),
                child: Column(
                  children: [
                    SizedBox(height: 3.h,),
                    Row(
                      children: [
                        Text(
                          "GPS Service",
                          style:
                          TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                      width: 350.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorUtils.red_color),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("On",style: TextStyle(color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor:ColorUtils.red_color,
                            activeColor: ColorUtils.red_color,
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
    );
  }

}