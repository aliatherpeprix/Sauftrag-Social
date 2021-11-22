
import 'package:flutter/material.dart';
import 'package:sauftrag/app/locator.dart';
import 'package:sauftrag/utils/color_utils.dart';
import 'package:sauftrag/viewModels/main_view_model.dart';
import 'package:stacked/stacked.dart';

class ChatInputField extends StatelessWidget {

  final TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return Container(
          child: Row(
            children: <Widget>[
              Material(
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 1.0),
                  child: new IconButton(
                    onPressed: (){},
                    icon: new Icon(Icons.face),
                    color: ColorUtils.lightTextColor,
                  ),
                ),
                color: Colors.white,
              ),

              // Text input
              Flexible(
                child: Container(
                  child: TextField(
                    style: TextStyle(color: Colors.black,
                        fontSize: 15.0
                    ),
                    controller: textEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message',
                      // hintStyle: TextStyle(
                      //     color: ColorUtils.addressDetailTextColor
                      // ),
                    ),
                  ),
                ),
              ),

              // Send Message Button
              Material(
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 8.0),
                  child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () => {},
                    //color: ColorUtils.addressDetailTextColor,
                  ),
                ),
                color: Colors.white,
              ),
            ],
          ),
          width: double.infinity,
          height: 50.0,
          decoration: new BoxDecoration(
              border: new Border(
                  top: new BorderSide(color: ColorUtils.lightTextColor, width: 0.5)),
              color: Colors.white),
        );
      },
    );
  }
}