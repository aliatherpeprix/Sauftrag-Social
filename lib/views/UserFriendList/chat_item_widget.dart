
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/utils/font_utils.dart';
import 'package:sauftrag/utils/image_utils.dart';
import 'package:sauftrag/utils/size_config.dart';

class ChatItemWidget extends StatelessWidget {

  var index;

  ChatItemWidget(this.index);

  @override
  Widget build(BuildContext context) {
    if (index % 2 == 0) {
      //This is the sent message. We'll later use data from firebase instead of index to determine the message is sent or received.
      return Container(
          child: Column(children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.amber,
                    )
                ),
                Expanded(
                  flex: 6,
                  child: Bubble(
                    color: ColorUtils.text_red,
                    nip: BubbleNip.rightTop,
                    style: BubbleStyle(
                      nipOffset: 15.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Nam pretium, purus eu consectetur rhoncus, ante diam efficitur ex, et efficitur turpis.',
                          style: TextStyle(
                              color: Colors.white,
                              //fontFamily: FontUtils.proximaNovaLight,
                              fontSize: SizeConfig.textMultiplier * 1.8
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.5),
                            child:
                            Text(
                              DateFormat('kk:mm')
                                  .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.textMultiplier * 1.6,
                                fontStyle: FontStyle.normal,
                                //fontFamily: FontUtils.proximaNovaLight,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 1),
                      child: Container(
                        width: SizeConfig.widthMultiplier * 10,
                        height: SizeConfig.heightMultiplier * 3,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImageUtils.messagePerson1,
                            width: SizeConfig.widthMultiplier * 12,
                          ),
                        ),
                      )
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end, // aligns the chatitem to right end
            ),
            /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child:
                    Text(
                      DateFormat('dd MMM kk:mm')
                          .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal),
                    ),
                    margin: EdgeInsets.only(
                        left: SizeConfig.heightMultiplier * 2,
                        top: SizeConfig.heightMultiplier * 2,
                        bottom: SizeConfig.heightMultiplier * 1,
                    ),
                  )])*/
          ]));
    } else {
      // This is a received message
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 1),
                    child: Image.asset(ImageUtils.messagePerson2,
                      width: SizeConfig.widthMultiplier * 5,
                      height: SizeConfig.widthMultiplier * 5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Bubble(
                    //borderColor: ColorUtils.silverButtonColor,
                    nip: BubbleNip.leftTop,
                    //color: Colors.amber,
                    style: BubbleStyle(
                      nipOffset: 15.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sed dui vel quam egestas ultrices. In laoreet purus eu lorem aliquet luctus. Donec ut condimentum velit. Aliquam est ante, lobortis sed nulla sed, placerat vulputate dolor. Mauris ut tellus at elit gravida finibus sit amet porta massa. Cras sapien turpis, pellentesque sit amet mattis mollis, blandit nec mauris. ',
                          style: TextStyle(
                              color: ColorUtils.text_grey,
                              //fontFamily: FontUtils.proximaNovaLight,
                              fontSize: SizeConfig.textMultiplier * 1.8
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.5),
                            child:
                            Text(
                              DateFormat('kk:mm')
                                  .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                              style: TextStyle(
                                //color: ColorUtils.companyChatColor,
                                fontSize: SizeConfig.textMultiplier * 1.6,
                                fontStyle: FontStyle.normal,
                                //fontFamily: FontUtils.proximaNovaLight,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                  ),
                ),
              ],
            ),
            /*Container(
              child:
              Text(
                DateFormat('dd MMM kk:mm')
                    .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal),
              ),
              margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
            )*/
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 3, top: SizeConfig.heightMultiplier * 3),
      );
    }  }

}