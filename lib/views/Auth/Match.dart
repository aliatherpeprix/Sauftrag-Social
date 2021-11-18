import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sauftrag/utils/size_config.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.widthMultiplier * 3,
        child: Center(
          child: Column(
            children: [
              Container(
                child: Text("data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
