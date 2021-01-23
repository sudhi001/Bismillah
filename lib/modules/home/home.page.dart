import 'dart:ui';
import 'package:Bismillah/res/app_constants.dart';
import 'package:Bismillah/res/styles.dart';
import 'package:Bismillah/utils/app_preference.dart';
import 'package:Bismillah/utils/prayerTime.handler.dart';
import 'package:Bismillah/widget/dialog.utils.dart';
import 'package:Bismillah/widget/top.navigation.dart';
import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:Bismillah/utils/extensions.dart';

class HomePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageViewSate();
}

class HomePageViewSate extends State<HomePageView> {
  final prayerTimeHandler = new PrayerTimeHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: NavBarView(() async {
        await DialogUtils.showSettings(context);
        _refreshCalculationMethod();
      }),
      body: Stack(
        children: [
          Container(decoration: AppTheme.boxDecoration),
          _bodyWidget(),
          Align(
            child: Image.asset(ImageConstants.bottomBg),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            child: SafeArea(
              child: Image.asset(
                ImageConstants.bottomTopBg,
                height: 300,
                width: 300,
              ),
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }

  _refreshCalculationMethod() {
    AppPreference.getCalculationMethod().then((value) {
      if (value != null) {
        setState(() {
          prayerTimeHandler.changeMethod(value, () {
            setState(() {});
          });
        });
      }
    });
  }

  _bodyWidget() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(7.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStringConstants.slogan,
                style: AppTextStyle.sloganStyle,
                textAlign: TextAlign.center,
              ),
            ),
            _buildNeomorphicCard(_buildPrayerList()),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshCalculationMethod();
  }

  _buildNeomorphicCard(Widget content) {
    return Neumorphic(
      margin: EdgeInsets.all(12),
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          depth: -5,
          lightSource: LightSource.bottom,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          color: Colors.transparent),
      child: content,
      padding: EdgeInsets.all(16),
    );
  }

  _buildPrayerList() {
    if (prayerTimeHandler.prayerTimes != null) {
      print(prayerTimeHandler.prayerTimes.currentPrayer());
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppStringConstants.prayerTimeTodayTitle,
              style: AppTextStyle.prayerTimeTile,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            prayerTimeHandler.prayerTimes.calculationParameters.method
                .methodName(),
            textAlign: TextAlign.right,
            style: AppTextStyle.prayerTile,
          ),
          SizedBox(height: 8),
          _buildRow(prayerTimeHandler.prayerTimes.fajr, Prayer.fajr),
          _buildRow(prayerTimeHandler.prayerTimes.sunrise, Prayer.sunrise),
          _buildRow(prayerTimeHandler.prayerTimes.dhuhr, Prayer.dhuhr),
          _buildRow(prayerTimeHandler.prayerTimes.asr, Prayer.asr),
          _buildRow(prayerTimeHandler.prayerTimes.maghrib, Prayer.maghrib),
          _buildRow(prayerTimeHandler.prayerTimes.isha, Prayer.isha),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              prayerTimeHandler.address,
              textAlign: TextAlign.right,
              style: AppTextStyle.prayerTile,
            ),
          ),
        ],
      );
    }
    if (prayerTimeHandler.locationError != null) {
      return Text(prayerTimeHandler.locationError);
    }
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: Center(child: Text(AppStringConstants.waiting)));
  }

  _buildRow(DateTime data, Prayer prayer) {
    bool isNextPrayer = prayerTimeHandler.prayerTimes.nextPrayer() == prayer;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: NeumorphicText(
              prayer.name(),
              style: NeumorphicStyle(
                depth: 1,
                color: isNextPrayer ? Color(0xFFFED61F) : Colors.black,
              ),
              textAlign: TextAlign.center,
              textStyle: AppTextStyle.prayerNameTile,
            )),
            Expanded(
              child: Text(
                DateFormat.jm().format(data),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isNextPrayer ? Color(0xFFFED61F) : Colors.white),
              ),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
