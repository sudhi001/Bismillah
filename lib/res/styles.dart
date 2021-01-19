import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppTheme {
  static final String defaultFontFamily = "Bismillah";
  static final NeumorphicThemeData lightTheme = NeumorphicThemeData(
    baseColor: Color(0xFF04AB9A),
    lightSource: LightSource.topLeft,
    depth: 3,
  );
  static final NeumorphicThemeData darkTheme = NeumorphicThemeData(
    baseColor: Color(0xFF007974),
    lightSource: LightSource.topLeft,
    depth: 3,
  );
  static final boxDecoration=BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFF007974),
          Color(0xFF04AB9A),
        ],
      ),
    );
}

class AppTextStyle {
   static final prayerNameTile= NeumorphicTextStyle(
                fontFamily: "Bismillah",
                fontSize: 27,
              );
    static final prayerTile=TextStyle(fontSize: 12);
  static final prayerTimeTile=TextStyle(fontFamily: AppTheme.defaultFontFamily, fontSize: 35);
  static final sloganStyle= TextStyle(fontFamily:AppTheme.defaultFontFamily, fontSize: 30);
  static final appTitleStyle = NeumorphicTextStyle(
    fontFamily: AppTheme.defaultFontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 70,
  );

  static final modalTitleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 18,
  );
}

