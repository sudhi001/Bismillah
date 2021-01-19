import 'package:adhan/adhan.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension PrayerExtension on Prayer {
  String name() {
    return this.toString().split('.').last.capitalize();
  }
}

extension CalculationMethodExtension on CalculationMethod {
  String toShortString() {
    return this.toString().split('.').last;
  }

  String methodName() {
    switch (this) {
      case CalculationMethod.muslim_world_league:
        return 'Muslim World League';
      case CalculationMethod.egyptian:
        return 'Egyptian General Authority';
      case CalculationMethod.dubai:
        return 'UAE';
      case CalculationMethod.karachi:
        return 'University of Islamic Sciences, Karachi';
      case CalculationMethod.kuwait:
        return 'Kuwait';
      case CalculationMethod.moon_sighting_committee:
        return 'Moonsighting Committee';
      case CalculationMethod.singapore:
        return 'Singapore';
      case CalculationMethod.north_america:
        return 'ISNA';
      case CalculationMethod.other:
        return 'Fajr angle: 0, Isha angle: 0.';
      case CalculationMethod.qatar:
        return 'Umm al-Qura used in Qatar.';
      case CalculationMethod.umm_al_qura:
        return 'Umm al-Qura University, Makkah';
      default:return "";
    }
  }
}

CalculationMethod enumValueFromString<CalculationMethodT>(
        String key, Iterable<CalculationMethod> values) =>
    values.firstWhere(
      (v) => v != null && key == v.toShortString(),
      orElse: () => null,
    );
