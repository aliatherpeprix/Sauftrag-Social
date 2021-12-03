import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';
class OwnerShip extends StatefulWidget {
  const OwnerShip({Key? key}) : super(key: key);

  @override
  _OwnerShipState createState() => _OwnerShipState();
}

class _OwnerShipState extends State<OwnerShip> {
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              elevation: 0,
              title: Text(
                "Account OwnerShip",
                style: TextStyle(
                    color: Colors.black, fontSize: 2.5.t, fontFamily: FontUtils.modernistBold),
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,vertical: Dimensions.verticalPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(
                      height: 3.h,
                    ),
                        Text("If you want to take a break from sauftrag, \nyou can deactivate or you can delete your account,.",style: TextStyle(fontFamily: FontUtils.modernistRegular),),

                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      width: 350.w,
                      height: 11.h,
                      decoration: BoxDecoration(
                          border: Border.all(color:ColorUtils.red_color),
                          borderRadius: BorderRadius.circular(15)),
                      child: RadioListTile(
                        activeColor: ColorUtils.red_color,
                        value: 1,
                        groupValue: val,
                        onChanged: (_value) {
                          setState(() => val = 1);
                        },
                        title: Text(
                          "Deactivate Account",
                          style: TextStyle(
                              color: ColorUtils.red_color,
                              fontSize: 2.t,
                              fontFamily: FontUtils.modernistBold),
                        ),
                        subtitle: Text(
                          "Deactivating your account is temporary. Your account will be disabled and your photos will be removed from most of the things.",
                          style: TextStyle(
                              fontSize: 1.7.t,
                              fontFamily: FontUtils.modernistRegular
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 350.w,
                      height: 11.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorUtils.red_color),
                          borderRadius: BorderRadius.circular(15)),
                      child: RadioListTile(
                        activeColor: ColorUtils.red_color,
                        value: 2,
                        groupValue: val,
                        onChanged: (_value) => setState(() => val = 2),
                        title: Text(
                          "Delete Account",
                          style: TextStyle(
                              color: ColorUtils.red_color,
                              fontSize: 2.t,
                              fontWeight: FontWeight.w700,fontFamily: FontUtils.modernistBold),
                        ),
                        subtitle: Text(
                          "Deleting your account is permament. When you delete your account, you won’t be able to retrieve the content or the information that you have shared.",
                          style: TextStyle(
                              fontSize: 1.7.t,
                              fontFamily: FontUtils.modernistRegular
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              titlePadding: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              title: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
//color: Color(kColor)
                                            border: Border.all(color: ColorUtils.red_color,width: 0.5.w)
                                        ),
                                        child: InkWell(onTap: (){Navigator.pop(context);} ,child: Icon(Icons.close,color: ColorUtils.red_color,size: 15,))
                                    ),
                                  ),
                                  Icon(
                                    Icons.delete,
                                    size: 80,
                                    color:ColorUtils.red_color,
                                  ),
                                  Text(
                                    "Do you really want to delete your account and make the radler lobby win???",
                                    style: TextStyle(fontSize: 2.t,fontFamily: FontUtils.modernistRegular),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 120.w,
                                            height: 7.h,
                                            decoration: BoxDecoration(
                                                color: ColorUtils.red_color,
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text("Yes",style: TextStyle(fontFamily: FontUtils.modernistBold),),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: 120.w,
                                            height: 7.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:ColorUtils.red_color),
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                "No",
                                                style:
                                                TextStyle(color:ColorUtils.red_color,fontFamily: FontUtils.modernistBold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ));
                      },
                      child: Container(
                        width: 370.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorUtils.red_color),
                        child: Center(
                          child: Text(
                            "Delete Account",
                            style: TextStyle(color: Colors.white,fontFamily: FontUtils.modernistBold),
                          ),
                        ),
                      ),
                    )
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
