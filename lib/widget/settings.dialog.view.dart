import 'dart:ui';

import 'package:Bismillah/utils/app_preference.dart';
import 'package:adhan/adhan.dart';
import 'package:buy_me_a_coffee_widget/buy_me_a_coffee_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SettingsDialogView extends StatefulWidget {
  @override
  _SettingsDialogViewState createState() => _SettingsDialogViewState();
}

class _SettingsDialogViewState extends State<SettingsDialogView> {
  CalculationMethod _method = CalculationMethod.dubai;
  BuyMeACoffeeThemeData theme = TealTheme();
  @override
  void initState() {
    super.initState();
    AppPreference.getCalculationMethod().then((value) {
      if (value != null) {
        setState(() {
          _method = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
              _buildCalculationMethod(),
               SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 100,
                  child:  BuyMeACoffeeWidget(
                      sponsorID: "sudhis",
                      theme: theme,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  _buildCalculationMethod() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Calculation Method",
            style: TextStyle(color: Colors.black),
          ),
          flex: 1,
        ),
        Expanded(
          flex: 1,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                iconEnabledColor: Colors.black,
                isExpanded: true,
                style: TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                value: _method,
                items: [
                  DropdownMenuItem(
                    child: Text("UAE"),
                    value: CalculationMethod.dubai,
                  ),
                  DropdownMenuItem(
                    child: Text("Muslim World League"),
                    value: CalculationMethod.muslim_world_league,
                  ),
                  DropdownMenuItem(
                      child: Text("Egyptian General Authority"),
                      value: CalculationMethod.egyptian),
                  DropdownMenuItem(
                      child: Text("University of Islamic Sciences, Karachi"),
                      value: CalculationMethod.karachi),
                  DropdownMenuItem(
                      child: Text("Kuwait"), value: CalculationMethod.kuwait),
                  DropdownMenuItem(
                      child: Text("Moonsighting Committee"),
                      value: CalculationMethod.moon_sighting_committee),
                  DropdownMenuItem(
                      child: Text("Singapore"),
                      value: CalculationMethod.singapore),
                  DropdownMenuItem(
                      child: Text("ISNA"),
                      value: CalculationMethod.north_america),
                  DropdownMenuItem(
                      child: Text("Fajr angle: 0, Isha angle: 0."),
                      value: CalculationMethod.other),
                  DropdownMenuItem(
                      child: Text("Umm al-Qura used in Qatar."),
                      value: CalculationMethod.qatar),
                  DropdownMenuItem(
                      child: Text("Umm al-Qura University, Makkah"),
                      value: CalculationMethod.umm_al_qura)
                ],
                onChanged: (value) async {
                  await AppPreference.setCalculationMethod(value);
                  setState(() {
                    _method = value;
                  });
                }),
          ),
        )
      ],
    );
  }
}
