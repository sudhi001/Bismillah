import 'package:Bismillah/res/app_constants.dart';
import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart' as geo;
import 'package:location/location.dart';

class PrayerTimeHandler {
  
  final location = new Location();
  geo.Address _address;
  PrayerTimes _prayerTimes;
  CalculationMethod _method = CalculationMethod.dubai;
  Coordinates _coordinates;
  String _locationError;

  String get locationError => _locationError;
  Coordinates get coordinates => _coordinates;
  CalculationMethod get method => _method;
  PrayerTimes get prayerTimes => _prayerTimes;
  String get address => _address != null
      ? '${_address.locality}, ${_address.subAdminArea}, ${_address.adminArea}'
      : '';

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

  void changeMethod(CalculationMethod value,VoidCallback refresh) {
    _method = value;
    if (_coordinates != null) {
      _prayerTimes = PrayerTimes(_coordinates,
          DateComponents.from(DateTime.now()), _method.getParameters());
    } else {
      getLocationData().then((locationData) {
        if (locationData != null) {
          geo.Geocoder.local
              .findAddressesFromCoordinates(new geo.Coordinates(
                  locationData.latitude, locationData.longitude))
              .then((value) {
            if (value != null && value.isNotEmpty) {
              _address = value.first;
            }
          });
          _coordinates =
              Coordinates(locationData.latitude, locationData.longitude);
          _prayerTimes = PrayerTimes(_coordinates,
              DateComponents.from(DateTime.now()), _method.getParameters());
              refresh();
        } else {
          _locationError = AppStringConstants.loadingText;
          refresh();
        }
      });
    }
  }
}
