import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ModalNavBarView extends PreferredSize {

  final String title;
  ModalNavBarView(this.title);
  @override
  Size get preferredSize => Size.fromHeight(49);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
          NeumorphicButton(
            
            style: NeumorphicStyle(
              lightSource: LightSource.bottom,
              depth: -2,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.stadium(),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Icon(Icons.close,color: Colors.white,),
            onPressed: (){
              Navigator.pop(context);
            }),
        ],
      ),
    );
  }
}
