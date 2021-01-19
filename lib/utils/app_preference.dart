import 'package:Bismillah/utils/extensions.dart';
import 'package:adhan/adhan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static SharedPreferences _pref;
  static Future<SharedPreferences> getSharedPreference() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
    return _pref;
  }

  static Future<void> clear() async {
    (await getSharedPreference()).clear();
  }

  static setCalculationMethod(CalculationMethod method) async {
    setCalculationMethodSync(method, await getSharedPreference());
  }

  static Future<bool> setCalculationMethodSync(
      CalculationMethod method, SharedPreferences pref) {
    return pref?.setString("calculation_method", method.toShortString());
  }

  static Future<CalculationMethod> getCalculationMethod() async {
    return getCalculationMethodSync(await getSharedPreference());
  }

  static CalculationMethod getCalculationMethodSync(SharedPreferences pref) {
    String _calculationMethod = pref.getString("calculation_method");
    if (_calculationMethod != null)
      return enumValueFromString(_calculationMethod, CalculationMethod.values);
    return null;
  }
}

