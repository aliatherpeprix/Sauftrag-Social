import 'package:flutter/material.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/dimensions.dart';
import 'package:sauftrag/utils/extensions.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/widgets/back_arrow_with_container.dart';


class Barprofile extends StatefulWidget {
  @override
  _BarprofileState createState() => _BarprofileState();
}

class _BarprofileState extends State<Barprofile> {

  List people = [
    {
      'name' : "Nellie Mendez",
      'detail' : "Lorem ipsum dolor sit amet, consectetur adipiscing \nelit. Integer pulvinar blandit magna.",
      'image' : ImageUtils.Nil,
    },
    {
      'name' : "Ron Wright",
      'detail' : "Lorem ipsum dolor sit amet, consectetur adipiscing \nelit. Integer pulvinar blandit magna.",
      'image' : ImageUtils.ron
    }
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            children: [
              Container(
                child: SafeArea(
                  child:
                      Stack(
                        children: [
                          Container(
                            width: 370.w,
                            height: 35.h,
                            child: Image.asset(ImageUtils.BarProfileImage,fit: BoxFit.fill,)
                          ),
                          Positioned(
                            top: 5.h,
                              left: 5.w,
                              child: Container(
                                width: 10.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child:  BackArrowContainer()
                              )),

                          Positioned(
                              top: 30.6.h,
                              child: Container(
                            width: 16.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: Image.asset(ImageUtils.barCircle),
                          ))

                        ],
                      ),
              ),

              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding,vertical: Dimensions.verticalPadding),
                    child:  Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("John Milton's Bar",style: TextStyle(fontFamily: FontUtils.modernistBold),),
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    color: ColorUtils.red_color,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 40),
                                    child: Center(child: Text("Join",style: TextStyle(color: ColorUtils.white),)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [Text("198",style: TextStyle(fontSize: 2.5.t,color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                                SizedBox(height: 2.h,),
                                  Text("Followers",style: TextStyle(fontSize: 1.5.t),)
                                ],
                              ),
                              SizedBox(
                                height: 6.h,
                                child: VerticalDivider(
                                    color: Colors.grey[300],
                                  ),

                              ),
                              Column(
                                children: [Text("50",style: TextStyle(fontSize: 2.5.t,color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                                  SizedBox(height: 2.h,),
                                  Text("Following",style: TextStyle(fontSize: 1.5.t),)
                                ],
                              ),
                              SizedBox(
                                height: 6.h,
                                child: VerticalDivider(
                                  color: Colors.grey[300],
                                ),

                              ),
                              Column(
                                children: [Text("291",style: TextStyle(fontSize: 2.5.t,color: ColorUtils.red_color,fontFamily: FontUtils.modernistBold),),
                                  SizedBox(height: 2.h,),
                                  Text("Posts",style: TextStyle(fontSize: 1.5.t),)
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 3.5.h,),
                          Row(
                            children: [
                              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. \nInteger pulvinar blandit magna. Donec bibendum velit \nvitae lacus rutrum mollis tempus vitae leo. Ut \ncommodo, elit sit amet pretium dapibus, arcu orci \ntempor massa.",style: TextStyle(fontFamily: FontUtils.modernistRegular,fontSize: 2.2.t),)
                            ],
                          ),

                          TabBar(
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
                                text: "News Feed",
                              ),
                              Tab(
                                text: "Ratings",
                              ),
                              Tab(
                                text: "Events",
                              ),
                            ],
                          ),
                          Container(
                            height: 15.h,
                            child: TabBarView(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return Material(
                                          elevation: 20,
                                          child: Card(
                                            shadowColor: Colors.grey[500],
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.horizontalPadding),
                                              width: 6.h,
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow:[
                                                  // BoxShadow(
                                                  //   spreadRadius: 6,
                                                  //   color: Colors.grey,
                                                  //   offset: Offset(0.0, 1.0), //(x,y)
                                                  //   blurRadius: 6.0,
                                                  // ),
                                                ],
                                              ),
                                              child:  Column(
                                                  children: [

                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 6.h,
                                                          width: 8.w,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(image: AssetImage(people[index]['image']))
                                                          ),
                                                        ),
                                                      SizedBox(width: 5.w,),
                                                      Text(people[index]["name"],style: TextStyle(fontFamily: FontUtils.modernistBold),),
                                                      SizedBox(width: 28.w,),
                                                      IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded,color: Colors.grey[500],)),

                                                    ],),

                                                    Row(children: [
                                                      Text(people[index]['detail'],style: TextStyle(fontFamily: FontUtils.modernistRegular,fontSize: 2.t),)
                                                    ],),
                                                    Divider(),
                                                    Row(children: [
                                                      Image.asset(ImageUtils.comment,scale: 5,),
                                                      SizedBox(width: 2.w,),
                                                      Text("68",style: TextStyle(color: Colors.grey[500],fontFamily: FontUtils.modernistRegular),),
                                                      SizedBox(width: 8.w,),

                                                     Image.asset(ImageUtils.like,scale: 5,),
                                                      SizedBox(width: 2.w,),
                                                      Text("68",style: TextStyle(color: Colors.grey[500],fontFamily: FontUtils.modernistRegular),),
                                                    ],),
                                                  ],
                                                ),
                                              ),
                                          ),

                                        );
                                      },
                                  ),
                                  Container(),
                                  Container(),
                                ]),
                          ),

                        ],
                      ),
                    ),
                ),
              ),

            ]
          ),
        
      ),
    );
  }
}
