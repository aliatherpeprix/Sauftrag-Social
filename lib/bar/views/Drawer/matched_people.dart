import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/viewModels/authentication_view_model.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/widgets/all_page_loader.dart';
import 'package:stacked/stacked.dart';

class MatchedPeople extends StatefulWidget {
  const MatchedPeople({Key? key}) : super(key: key);

  @override
  _MatchedPeopleState createState() => _MatchedPeopleState();
}

class _MatchedPeopleState extends State<MatchedPeople> {
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

      onModelReady: (model) {
        model.acceptMatched(context);
      },

      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: model.acceptMatchesLoader
              ? Center(child: AllPageLoader())
              : SafeArea(
                  top: false,
                  bottom: false,
                  child: Scaffold(
                      backgroundColor: ColorUtils.white,
                      body: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                           // margin: EdgeInsets.only(left: 5.w),
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: GridView.builder(
                              itemCount: model.acceptMatchedtModel.length,
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
                                return /*model.isLoading == true ? AllPageLoader() :*/
                                GestureDetector(
                                  onTap:  () async{
                                    model.matchedImage.clear();
                                    model.getMatchedUserData = (model.acceptMatchedtModel[index]);
                                    if (model.getMatchedUserData!.user!.profilePicture != null &&
                                        model.getMatchedUserData!.user!.profilePicture.isNotEmpty) {
                                      model.matchedImage.add(model.getMatchedUserData!.user!.profilePicture);
                                    }
                                    if (model.getMatchedUserData!.user!.catalogueImage1 != null &&
                                        model.getMatchedUserData!.user!.catalogueImage1.isNotEmpty) {
                                      model.matchedImage.add(model.getMatchedUserData!.user!.catalogueImage1);
                                    }
                                    if (model.getMatchedUserData!.user!.catalogueImage2 != null &&
                                        model.getMatchedUserData!.user!.catalogueImage2.isNotEmpty) {
                                      model.matchedImage.add(model.getMatchedUserData!.user!.catalogueImage2);
                                    }
                                    if (model.getMatchedUserData!.user!.catalogueImage3 != null &&
                                        model.getMatchedUserData!.user!.catalogueImage3.isNotEmpty) {
                                      model.matchedImage.add(model.getMatchedUserData!.user!.catalogueImage3);
                                    }
                                    if (model.getMatchedUserData!.user!.catalogueImage4 != null &&
                                        model.getMatchedUserData!.user!.catalogueImage4.isNotEmpty) {
                                      model.matchedImage.add(model.getMatchedUserData!.user!.catalogueImage4);
                                    }
                                    if (model.getMatchedUserData!.user!.catalogueImage5 != null &&
                                        model.getMatchedUserData!.user!.catalogueImage5.isNotEmpty) {
                                      model.matchedImage.add(model.getMatchedUserData!.user!.catalogueImage5);
                                    }
                                    model.notifyListeners();
                                    await model.getAnitherUserInfo(model.acceptMatchedtModel[index].user!.id.toString());
                                    model.navigateToMatchedProfileUser();
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          model.acceptMatchedtModel[index].user!
                                              .profilePicture,
                                          height: 25.h,
                                          width: 40.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      PositionedDirectional(
                                          bottom: 0,
                                          child: Container(
                                            //width: 34.5.w,
                                            decoration: BoxDecoration(
                                              color:
                                              Colors.grey.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(10),
                                                  bottomLeft:
                                                  Radius.circular(10)),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.2.h,
                                                horizontal: 11.w),
                                            child: Text(
                                              model.acceptMatchedtModel[index]
                                                  .user!.username,
                                              style: TextStyle(
                                                  color: ColorUtils.white),
                                            ),
                                          ))
                                    ],
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
