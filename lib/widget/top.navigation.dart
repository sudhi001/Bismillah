import 'package:Bismillah/res/app_constants.dart';
import 'package:Bismillah/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NavBarView extends PreferredSize {

 final Function onSettings;
 NavBarView(this.onSettings);
  @override
  Size get preferredSize => Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NeumorphicText(
              AppStringConstants.applicationName,
              style: NeumorphicStyle(
                depth: 4,
                color: Color(0xFF061F58),
              ),
              textAlign: TextAlign.center,
              textStyle: AppTextStyle.appTitleStyle,
            ),
            NeumorphicButton(
              style: NeumorphicStyle(
                lightSource: LightSource.bottomRight,
                depth: -5,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.stadium(),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Icon(Icons.settings,color: Colors.white,),
              onPressed: onSettings,
            )
          ],
        ),
      ),
    );
  }
}
