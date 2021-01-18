import 'dart:ui';
import 'package:Bismillah/utils/app_preference.dart';
import 'package:Bismillah/widget/dialog.utils.dart';
import 'package:Bismillah/widget/top.navigation.dart';
import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class HomePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageViewSate();
}

class HomePageViewSate extends State<HomePageView> {
  final location = new Location();
  String locationError;
  CalculationMethod _method = CalculationMethod.dubai;
  PrayerTimes prayerTimes;
  geo.Address address;
  Coordinates coordinates;
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
          Container(decoration: _boxDecoration()),
          _bodyWidget(),
          Align(
            child: Image.asset("images/bottom_bg.png"),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            child: SafeArea(
              child: Image.asset(
                "images/top_bg.png",
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
          _method = value;
          if (coordinates != null) {
            prayerTimes = PrayerTimes(coordinates,
                DateComponents.from(DateTime.now()), _method.getParameters());
          }
        });
      }
    });
  }

  _boxDecoration() {
    return BoxDecoration(
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

  _bodyWidget() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(7.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Every Morning is beautiful when we talk to Allah first',
                style: TextStyle(fontFamily: "Bismillah", fontSize: 30),
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
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        geo.Geocoder.local
            .findAddressesFromCoordinates(new geo.Coordinates(
                locationData.latitude, locationData.longitude))
            .then((value) {
          if (!mounted) {
            return;
          }
          if (value != null && value.isNotEmpty) {
            setState(() {
              address = value.first;
            });
          }
        });
        setState(() {
          coordinates =
              Coordinates(locationData.latitude, locationData.longitude);
          prayerTimes = PrayerTimes(coordinates,
              DateComponents.from(DateTime.now()), _method.getParameters());
        });
        _refreshCalculationMethod();
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });

    super.initState();
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

  Future<LocationData> getLocationData() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  _buildPrayerList() {
    if (prayerTimes != null) {
      String method = _getMethod();
      print(prayerTimes.currentPrayer());
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Prayer Times for Today',
              style: TextStyle(fontFamily: "Bismillah", fontSize: 35),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            '($method)',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 8),
          _buildRow('Fajr', prayerTimes.fajr,
              prayerTimes.nextPrayer() == Prayer.fajr),
          _buildRow('Sunrise', prayerTimes.sunrise,
              prayerTimes.nextPrayer() == Prayer.sunrise),
          _buildRow('Dhuhr', prayerTimes.dhuhr,
              prayerTimes.nextPrayer() == Prayer.dhuhr),
          _buildRow(
              'Asr', prayerTimes.asr, prayerTimes.nextPrayer() == Prayer.asr),
          _buildRow('Maghrib', prayerTimes.maghrib,
              prayerTimes.nextPrayer() == Prayer.maghrib),
          _buildRow('Isha ', prayerTimes.isha,
              prayerTimes.nextPrayer() == Prayer.isha),
          if (address != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${address.locality}, ${address.subAdminArea}, ${address.adminArea}',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12),
              ),
            ),
        ],
      );
    }
    if (locationError != null) {
      return Text(locationError);
    }
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: Center(child: Text('Waiting for Your Location...')));
  }

  _buildRow(String title, DateTime data, bool isNextPrayer) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: NeumorphicText(
              title,
              style: NeumorphicStyle(
                depth: 1,
                color: isNextPrayer ? Color(0xFFFED61F) : Colors.black,
              ),
              textAlign: TextAlign.center,
              textStyle: NeumorphicTextStyle(
                fontFamily: "Bismillah",
                fontSize: 27,
              ),
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

  String _getMethod() {
    String method;
    switch (prayerTimes.calculationParameters.method) {
      case CalculationMethod.muslim_world_league:
        method = 'Muslim World League';
        break;
      case CalculationMethod.egyptian:
        method = 'Egyptian General Authority';
        break;
      case CalculationMethod.dubai:
        method = 'UAE';
        break;
      case CalculationMethod.karachi:
        method = 'University of Islamic Sciences, Karachi';
        break;
      case CalculationMethod.kuwait:
        method = 'Kuwait';
        break;
      case CalculationMethod.moon_sighting_committee:
        method = 'Moonsighting Committee';
        break;
      case CalculationMethod.singapore:
        method = 'Singapore';
        break;
      case CalculationMethod.north_america:
        method = 'ISNA';
        break;
      case CalculationMethod.other:
        method = 'Fajr angle: 0, Isha angle: 0.';
        break;
      case CalculationMethod.qatar:
        method = 'Umm al-Qura used in Qatar.';
        break;
      case CalculationMethod.umm_al_qura:
        method = 'Umm al-Qura University, Makkah';
        break;
      default:
    }
    return method;
  }
}
