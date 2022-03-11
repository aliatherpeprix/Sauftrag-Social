import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/bar/views/Drawer/requestUserProfile.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:stacked/stacked.dart';

class RequestedPeople extends StatefulWidget {
  const RequestedPeople({Key? key}) : super(key: key);

  @override
  _RequestedPeopleState createState() => _RequestedPeopleState();
}

class _RequestedPeopleState extends State<RequestedPeople> {
  List matchedImg = [
    {'image': ImageUtils.matchedImg1, 'title': 'Leona Mathis'},
    {'image': ImageUtils.matchedImg2, 'title': 'Josefina Ward'},
    {'image': ImageUtils.matchedImg3, 'title': 'Andre Patterson'},
    {'image': ImageUtils.matchedImg4, 'title': 'Nick Hoffman'},
    {'image': ImageUtils.matchedImg5, 'title': 'Henrietta Hall'},
    {'image': ImageUtils.matchedImg6, 'title': 'Hazel Ballard'},
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      onModelReady: (data) {
        data.requestMatches(context);
      },
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: model.matchesLoader
              ? Center(child: AllPageLoader())
              : SafeArea(
                  top: false,
                  bottom: false,
                  child: Scaffold(
                      backgroundColor: ColorUtils.white,
                      body: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            //margin: EdgeInsets.only(left: 5.w),
                            child: GridView.builder(
                              itemCount: model.requestModel.length,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              primary: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 50),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(

                                  child: GestureDetector(
                                    onTap: () {

                                      model.navigateToMatchDetailScreen(
                                          model.requestModel[index].user!.profilePicture!,
                                          model.requestModel[index].user!.username,
                                          model.requestModel[index].user!.address,
                                          model.requestModel[index].user!.favoriteAlcoholDrinks!,
                                        model.requestModel[index].user!.favoriteNightClub!,
                                        model.requestModel[index].user!.favoritePartyVacation!,
                                        model.requestModel[index].user!.id!,


                                      );
                                      print(model.requestModel[0].user!.username!);

                                      //model.requestModel[index].user!.map((item){
                                      //   model.(
                                      //       name : model.requestModel[index].user!.username!,
                                      //       address : model.requestModel[index].user!.address!,
                                      //       alcoholDrink : model.requestModel[index].user!.favoriteAlcoholDrinks!,
                                      //       nightClub : model.requestModel[index].user!.favoriteNightClub!,
                                      //       partyVacation : model.requestModel[index].user!.favoritePartyVacation!,
                                      //       images : model.requestModel[index].user!.profilePicture,
                                      //       id: model.requestModel[index].user!.id,
                                      //   );
                                      // }

                                     // );
                                      // model.navigateToFollowerList();
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child:  Image.network(
                                            model.requestModel[index].user!
                                                .profilePicture,
                                            height: 25.h,
                                            width: 40.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        PositionedDirectional(
                                          bottom: 5.h,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // SizedBox(
                                                //   width: 3.w,
                                                // ),
                                                GestureDetector(
                                                  onTap: () async{
                                                    if(model.matchesLoader){
                                                    }else{
                                                      await  model.deleteRequest(
                                                          context,
                                                          model.requestModel[index]
                                                              .id);
                                                    }

                                                    //
                                                    // model.requestModel
                                                    //     .removeAt(index);
                                                    model.notifyListeners();
                                                  },
                                                  child: SvgPicture.asset(
                                                    ImageUtils.dislikeIcon,
                                                    height: 5.h,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                GestureDetector(
                                                  onTap: () async{
                                                    if(model.matchesLoader){

                                                    }else{
                                                      await   model.acceptRequest(
                                                          context,
                                                          model.requestModel[index]
                                                              .id);
                                                    }

                                                    // model.requestModel
                                                    //     .removeAt(index);
                                                    model.notifyListeners();
                                                    // print(model
                                                    //     .requestModel[index].id);
                                                  },
                                                  child: SvgPicture.asset(
                                                    ImageUtils.likeIcon,
                                                    height: 5.h,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          bottom: 0,
                                          child: Container(
                                            //width: 39.5.w,

                                            decoration: BoxDecoration(
                                              color: Colors.grey.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.2.h, horizontal: 11.8.w),
                                            child: Text(
                                              model.requestModel[index].user!
                                                  .username,
                                              style: TextStyle(
                                                  color: ColorUtils.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )))),
        );
      },
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
    );
  }
}
