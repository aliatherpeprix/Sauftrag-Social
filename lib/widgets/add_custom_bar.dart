import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class AddCustomBar extends StatefulWidget {
  const AddCustomBar({Key? key}) : super(key: key);

  @override
  _AddCustomBarState createState() => _AddCustomBarState();
}

class _AddCustomBarState extends State<AddCustomBar> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      //onModelReady: (data) => data.initializeShareDialog(),
      builder: (context, model, child){
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            backgroundColor: Colors.white,
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    IconButton(
                      onPressed: (){
                        model.navigateBack();
                      },
                      iconSize: 15.0,
                      //padding: EdgeInsets.all(20),
                      //constraints: BoxConstraints(),
                      icon: SvgPicture.asset(ImageUtils.cancelIcon),
                    ),

                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,
                    //vertical: Dimensions.verticalPadding
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(height: 3.h),

                        TextField(
                          controller: model.addCustomBarController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB( 18, 0,  8, 0),
                            //isDense: true,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFDEDEDE)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color(0xFFDE6D09), width: 1.5),
                            ),
                            labelStyle: const TextStyle(color: Color(0xFFDEDEDE)),
                            hintText: "Add Bar",
                            hintStyle:  TextStyle(
                                fontFamily: FontUtils.modernistRegular,
                                color: Colors.grey),
                          ),
                        ),

                        SizedBox(height: 5.h,),
                        //Submit
                        SizedBox(
                          width: double.infinity,
                          //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                          child: ElevatedButton(
                            onPressed: () async{
                              model.addingBar(context);
                              //List temp = CommonFunctions.AddFromList(model.selectedClubList);
                              //await model.favoritesDrinks(model.selectedClubList, "favorite_night_club");
                              //model.navigateBack();
                            },
                            child: model.favDrink == false ? Text("Save") : Loader(),
                            style: ElevatedButton.styleFrom(
                              primary: ColorUtils.text_red,
                              onPrimary: ColorUtils.white,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  Dimensions.containerVerticalPadding),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.roundCorner)),
                              textStyle: TextStyle(
                                color: ColorUtils.white,
                                fontFamily: FontUtils.modernistBold,
                                fontSize: 1.8.t,
                                //height: 0
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 2.h,),

                      ],
                    ),
                  ),
                ),
              ],
            )
        );
      },
      viewModelBuilder: () => locator<RegistrationViewModel>(),
      disposeViewModel: false,
    );
  }
}
