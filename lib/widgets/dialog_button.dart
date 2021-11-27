
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sauftrag/utils/extensions.dart';

class DialogButton extends StatelessWidget {

  final String? buttonText;
  final VoidCallback? buttonPress;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? buttonBackground;

  const DialogButton(
      {Key? key,
        @required this.buttonText,
        this.buttonPress,
        this.width,
        this.height,
        this.margin,
        this.buttonBackground,
      }
      )
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: buttonBackground,
        //color:  isBusy? Colors.grey : null
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)),
        onPressed: buttonPress,
        child: Text(
          buttonText!,
          style: TextStyle(
            fontSize: 2.t,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}