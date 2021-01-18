
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CommonDialogView extends StatefulWidget {
  final Widget childWidget;
  CommonDialogView(this.childWidget);
  @override
  _CommonDialogViewState createState() => _CommonDialogViewState();
}

class _CommonDialogViewState extends State<CommonDialogView> {
  @override
  Widget build(BuildContext context) {

    return Neumorphic(
      margin: EdgeInsets.all(10),
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          depth: -5,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(32)),
          color: Colors.white),
      child: widget.childWidget,
      padding: EdgeInsets.all(18),
    );
        
  }
}
