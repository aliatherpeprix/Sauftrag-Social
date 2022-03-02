import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/models/favorites_model.dart';
import 'package:sauftrag/services/addFavorites.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/common_functions.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/viewModels/registrationViewModel.dart';
import 'package:sauftrag/widgets/add_dialog_box_drink1.dart';
import 'package:sauftrag/widgets/add_dialog_box_drinks.dart';
import 'package:sauftrag/widgets/radler_dialog_box.dart';
import 'package:stacked/stacked.dart';

import 'loader.dart';

class FavoriteDrinkList extends StatefulWidget {

  String title;
  String btnTxt;

  FavoriteDrinkList({Key? key, required this.title, required this.btnTxt, }) : super(key: key);

  @override
  _FavoriteDrinkListState createState() => _FavoriteDrinkListState();
}

class _FavoriteDrinkListState extends State<FavoriteDrinkList> {

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<MainViewModel>.reactive(
      //onModelReady: (data) => data.initializeShareDialog(),
      onModelReady: (model) async {
        model.drinkList = await Addfavorites().GetFavoritesDrink();
      },
      builder: (context, model, child){
        // model.favDrink = false;
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            backgroundColor: Colors.white,
            child: WillPopScope(
              onWillPop: ()async{
                if (model.favDrink){
                  return false;
                }
                else {
                  return true;
                }
              },
              child: AbsorbPointer(
                absorbing: model.favDrink,
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
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding, vertical: Dimensions.verticalPadding),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            SizedBox(height: 3.h),

                            Wrap(
                              spacing: 2.5.w,
                              runSpacing: 1.5.h,
                              direction: Axis.horizontal,
                              children: model.drinkList
                                  .map((element) => ElevatedButton(
                                onPressed: () {
                                  if(model.selectedDrinkList.contains(element.id)){
                                    model.selectedDrinkList.remove(element.id);
                                  }
                                  else{
                                    // if(element == "Radler"){
                                    //   showDialog(
                                    //       context: context,
                                    //       builder: (BuildContext context){
                                    //         return RadlerDialogBox(title: "Add New Location", btnTxt: "Add Location", icon: ImageUtils.addLocationIcon);
                                    //       }
                                    //   );
                                    // }
                                    model.selectedDrinkList.add(element.id);
                                  }
                                  model.notifyListeners();
                                },
                                child: Text((element as FavoritesModel).name ?? ""),
                                style: ElevatedButton.styleFrom(
                                  primary: model.selectedDrinkList.contains(element.id) ? ColorUtils.text_red : ColorUtils.white,
                                  onPrimary: model.selectedDrinkList.contains(element.id) ? ColorUtils.white : ColorUtils.text_dark,
                                  padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 9.w),
                                  elevation: model.selectedDrinkList.contains(element.id) ? 5 : 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                      side: BorderSide(
                                          color: model.selectedDrinkList.contains(element.id) ? ColorUtils.text_red : ColorUtils.divider,
                                          width: 1
                                      )
                                  ),
                                  textStyle: TextStyle(
                                    //color: model.role == Constants.user ? ColorUtils.white: ColorUtils.text_red,
                                    fontFamily: model.selectedDrinkList.contains(element.id) ? FontUtils.modernistBold : FontUtils.modernistRegular,
                                    fontSize: 1.8.t,
                                    //height: 0
                                  ),
                                ),
                              )).toList(),
                            ),

                            SizedBox(height: 5.h,),

                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AddDialogBoxDrink1(title: "Add New Drink", btnTxt: "Add Drink", icon: ImageUtils.addDrinkIcon);
                                    }
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  SvgPicture.asset(ImageUtils.addDrinkIcon),

                                  SizedBox(width: 10),

                                  Text("Add Drink")
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: ColorUtils.white,
                                onPrimary: ColorUtils.text_red,
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.roundCorner),
                                    side: BorderSide(
                                        color: ColorUtils.text_red,
                                        width: 1
                                    )
                                ),
                                textStyle: TextStyle(
                                  fontFamily: FontUtils.modernistRegular,
                                  fontSize: 1.8.t,
                                  //height: 0
                                ),
                              ),
                            ),

                            // Stack(
                            //   children: [
                            //     Container(
                            //       height: 7.h,
                            //       padding: EdgeInsets.symmetric(
                            //           vertical: Dimensions.containerVerticalPadding,
                            //           horizontal:
                            //           Dimensions.containerHorizontalPadding),
                            //       decoration: BoxDecoration(
                            //           color: ColorUtils.white,
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(Dimensions.roundCorner)),
                            //           border:
                            //           Border.all(color: ColorUtils.divider)),
                            //       child: TextField(
                            //         inputFormatters: <TextInputFormatter>[
                            //           LengthLimitingTextInputFormatter(18),
                            //         ],
                            //         focusNode: model.updateNewDrinkFocus,
                            //         controller: model.updateNewDrinkController,
                            //         keyboardType: TextInputType.text,
                            //         textInputAction: TextInputAction.next,
                            //         style: TextStyle(
                            //           color: ColorUtils.black,
                            //           fontFamily: FontUtils.modernistRegular,
                            //           fontSize: 1.8.t,
                            //         ),
                            //         decoration: InputDecoration(
                            //           hintText: "Anything you like",
                            //           hintStyle: TextStyle(
                            //               fontFamily: FontUtils.modernistRegular,
                            //               color: ColorUtils.text_grey,
                            //               fontSize: 1.8.t
                            //           ),
                            //           border: InputBorder.none,
                            //           isDense:true,
                            //           contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            //         ),
                            //       ),
                            //       // TextField(
                            //       //   focusNode: model.addDrinkFocus,
                            //       //   controller: model.addDrinkController,
                            //       //   keyboardType: TextInputType.text,
                            //       //   textInputAction: TextInputAction.next,
                            //       //   style: TextStyle(
                            //       //     color: ColorUtils.red_color,
                            //       //     fontFamily: FontUtils.modernistRegular,
                            //       //     fontSize: 1.9.t,
                            //       //   ),
                            //       //   decoration: const InputDecoration(
                            //       //     border: InputBorder.none,
                            //       //     isDense: true,
                            //       //     contentPadding: EdgeInsets.symmetric(
                            //       //         horizontal: 0, vertical: 0),
                            //       //   ),
                            //       // ),
                            //     ),
                            //     Container(
                            //       margin: EdgeInsets.only(left: 5.w),
                            //       padding: EdgeInsets.symmetric(horizontal: 1.w),
                            //       color: ColorUtils.white,
                            //       child: Text(
                            //         "Add Drink",
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //             color: ColorUtils.text_grey,
                            //             fontFamily: FontUtils.modernistRegular,
                            //             fontSize: 1.5.t,
                            //             height: .4),
                            //       ),
                            //     ),
                            //   ],
                            // ),

                            SizedBox(height: 5.h,),
                            //Submit
                            SizedBox(
                              width: double.infinity,
                              //margin: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2, horizontal: SizeConfig.widthMultiplier * 4),
                              child: ElevatedButton(
                                onPressed: () async{

                                  await model.favoritesDrinks(model.selectedDrinkList, "favorite_alcohol_drinks");
                                  model.navigateBack();
                                },
                                child: model.favDrink == false ? Text("Save") : Loader() ,
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



                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
