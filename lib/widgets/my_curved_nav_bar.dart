
import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/color_utils.dart';
import '../utils/size_config.dart';
import '../utils/size_config.dart';
import '../utils/size_config.dart';
import '../utils/size_config.dart';
import '../utils/size_config.dart';
import '../utils/size_config.dart';
import '../utils/size_config.dart';

class MyCurvedNavBar extends StatefulWidget {

  final List<String> items;
  final int index;
  final Color color;
  final Color buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int> onTap;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;
  final Color barIconColor;
  final Color selectedIconColor;
  final BoxDecoration parentDecoration;

  MyCurvedNavBar({
    Key? key,
    required this.items,
    this.index = 0,
    this.color = Colors.white,
    required this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    required this.onTap,
    this.barIconColor = const Color(0xFFA4A4A4),
    this.selectedIconColor = Colors.white,
    this.animationCurve = Curves.easeOut,
    required this.parentDecoration,
    this.animationDuration = const Duration(milliseconds: 400),
    required this.height,
  })  : assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        super(key: key);

  @override
  MyCurvedNavBarState createState() => MyCurvedNavBarState();
}

class MyCurvedNavBarState extends State<MyCurvedNavBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  double _buttonHide = 0;
  late String _icon;
  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index];
    _endingIndex = widget.index;
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(MyCurvedNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: widget.parentDecoration,
      height: widget.height,
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: -3*SizeConfig.heightMultiplier,
            left: Directionality.of(context) == TextDirection.rtl
                ? null
                : _pos * size.width,
            right: Directionality.of(context) == TextDirection.rtl
                ? _pos * size.width
                : null,
            width: size.width / _length,
            child: Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  -(1 - _buttonHide) * 80,
                ),
           /*     child: Material(
                  color: widget.buttonBackgroundColor ?? widget.color,
                  type: MaterialType.circle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _icon,
                  ),
                ),*/
                child : Container(
                  height: 12 * SizeConfig.imageSizeMultiplier,
                  width: 12 * SizeConfig.imageSizeMultiplier,
                  //margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      color: ColorUtils.text_red
                      /*gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ColorUtils.startGradient, ColorUtils.endGradient],
                          stops: [0.1,.8]
                      )*/
                  ),
                  child: Center(
                    child: SvgPicture.asset(_icon,color: widget.selectedIconColor,width: _endingIndex==3 ||  _endingIndex == 4? 6*SizeConfig.imageSizeMultiplier : 5*SizeConfig.imageSizeMultiplier,height: _endingIndex==3 || _endingIndex == 4? 6*SizeConfig.imageSizeMultiplier : 5*SizeConfig.imageSizeMultiplier,),
                  )
                )
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 ,
            child: CustomPaint(
              painter: NavCustomPainter(
                  _pos, _length, widget.color, Directionality.of(context)),
              child: Container(
                height: widget.height,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: widget.height,
              alignment: Alignment.center,
                child: Row(
                    children: widget.items.map((item) {
                      int index = widget.items.indexOf(item);
                      return NavButton(
                        height: widget.height,
                        onTap: _buttonTap,
                        position: _pos,
                        length: _length,
                        index: widget.items.indexOf(item),
                        child: Center(child: SvgPicture.asset(item,color: widget.barIconColor,width: index==3 || index == 4? 6.5*SizeConfig.imageSizeMultiplier : 5.5*SizeConfig.imageSizeMultiplier,height: index==3 || index == 4? 6.5*SizeConfig.imageSizeMultiplier : 5.5*SizeConfig.imageSizeMultiplier,)),
                      );
                    }).toList())),
          ),
        ],
      ),
    );
  }

  void setPage(int index){
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if(_endingIndex!=index){
      if (widget.onTap != null) {
        widget.onTap(index);
      }
      final newPosition = index / _length;
      setState(() {
        _startingPos = _pos;
        _endingIndex = index;
        _animationController.animateTo(newPosition,
            duration: widget.animationDuration, curve: widget.animationCurve);
      });
    }
  }
}


class NavCustomPainter extends CustomPainter {

  late double loc;
  late double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(double startingLoc, int itemsLength, this.color, this.textDirection) {

    final span = 1.0 / itemsLength;
    s = 0.2;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.05) * size.width, 0)
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.03,
        loc * size.width,
        size.height * 0.4,
        (loc + s * 0.50) * size.width,
        size.height * 0.50,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.40,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.030,
        (loc + s + 0.05) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class NavButton extends StatelessWidget {

  final double position;
  final int length;
  final int index;
  final double height;
  final ValueChanged<int> onTap;
  final Widget child;

  NavButton({required this.onTap, required this.position, required this.length, required this.index, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: Container(
            height: height,
            child: Transform.translate(
              offset: Offset(
                  0, difference < 1.0 / length ? verticalAlignment * 40 : 0),
              child: Opacity(
                  opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
                  child: child),
            )),
      ),
    );
  }
}
