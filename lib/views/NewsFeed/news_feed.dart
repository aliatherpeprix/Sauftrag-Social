import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:sauftrag/views/NewsFeed/events.dart';
import 'package:stacked/stacked.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: (){
            context.unFocus();
            model.openGroupMenu = false;
            model.notifyListeners();
          },
          child: DefaultTabController(
            length: 2,
            child: SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.horizontalPadding,
                      vertical: Dimensions.verticalPadding),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                        child: AppBar(
                          backgroundColor: Colors.white,
                          elevation: 0.0,
                          bottom: TabBar(
                            indicatorColor: ColorUtils.text_red,
                            labelColor: ColorUtils.text_red,
                            labelStyle: TextStyle(
                              fontFamily: FontUtils.modernistBold,
                              fontSize: 1.8.t,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontFamily: FontUtils.modernistRegular,
                              fontSize: 1.8.t,
                            ),
                            unselectedLabelColor: ColorUtils.icon_color,
                            tabs: [
                              Tab(
                                text: "Direct",
                              ),
                              Tab(
                                text: "Groups",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // first tab bar view widget
                            Center(
                              child: Text("yo"),
                            ),

                            // second tab bar viiew widget
                            Events(),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
