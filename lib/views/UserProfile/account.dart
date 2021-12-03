import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:date_picker_timeline/extra/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  double _value = 40.0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Container(
                    child: Text(
                      "Account",
                      style: TextStyle(
                          color: Colors.black, fontSize: 2.5.t, fontFamily: FontUtils.modernistBold),
                    ),
                  ),
                ),

              backgroundColor: Colors.white,
              body: SafeArea(
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,vertical: Dimensions.verticalPadding),
                      child: Column(children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(height: 4.h,),
                          Row(
                            children: [
                              Text(
                                "Phone Number",
                                style:
                                TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color: ColorUtils.red_color)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color:  ColorUtils.red_color),
                                ),
                                focusColor:  ColorUtils.red_color,
                                prefixIcon: CountryCodePicker(
                                  initialSelection: 'US',
                                  showCountryOnly: false,

                                ),
                                hintText: 'Enter Your Phone number',
                                hintStyle: TextStyle(color:  ColorUtils.red_color)),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Location",
                                style:
                                TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Color(0xFFE20000), fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(color:  ColorUtils.red_color)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color:  ColorUtils.red_color),
                                ),
                                focusColor: ColorUtils.red_color,
                                hintText: 'anywhere in the world',
                                hintStyle: TextStyle(color:  ColorUtils.red_color),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.my_location_sharp,
                                      color: ColorUtils.red_color,
                                    ))),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Maximum Distance",
                                style:
                                TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                              width: 370.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorUtils.red_color),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: SfSlider(
                                      activeColor:  ColorUtils.red_color,
                                      inactiveColor: Color(0xFFFFE4E8),
                                      min: 0.0,
                                      max: 100,
                                      value: _value,
                                      onChanged: (dynamic value){
                                        setState(() {
                                          _value = value;
                                        });
                                      })
                              )),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Block Contacts",
                                style:
                                TextStyle(fontSize: 2.t, fontFamily: FontUtils.modernistBold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 370.w,
                              height: 8.h,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Block Contacts",
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          InkWell(
                            onTap: () {
                              model.navigateToUserProfileAccountOwnershipScreen();
                            },
                            child: Container(
                              width: 370.w,
                              height: 8.h,
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "AccountOwnership & Control",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                          ),

                        ]),
                      ),
                    )),

        );
      },
    );
  }
}
