import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';


class LegalTerm extends StatefulWidget {
  @override
  _LegalTermState createState() => _LegalTermState();
}

class _LegalTermState extends State<LegalTerm> {
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
              title: Text("Legal Terms",style:TextStyle(fontSize: 2.5.t,fontFamily: FontUtils.modernistBold,color: Colors.black),),
              backgroundColor: Colors.white,

            ),
            backgroundColor: Colors.white,
            body:
            Container(
              margin: EdgeInsets.only(top: 6.h),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                width: 350.w,
                height: 23.h,
                decoration: BoxDecoration(
                    border: Border.all(color:ColorUtils.red_color),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.verticalPadding),
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                          // Navigator.push(context, MaterialPageRoute(builder: (Context)=>GPS()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Legal Terms",style: TextStyle(fontSize: 2.t,color: ColorUtils.red_color),),
                            Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,size: 17,)
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 1.8.h,),
                      InkWell(
                        onTap:(){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact",style: TextStyle(fontSize: 2.t,color:ColorUtils.red_color),),
                            Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,size: 17,)
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 1.h,),
                      InkWell(
                        onTap:(){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Imprint",style: TextStyle(fontSize: 2.t,color: ColorUtils.red_color),),
                            Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,size: 17,)
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
    );
  }
}