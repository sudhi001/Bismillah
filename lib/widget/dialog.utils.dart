import 'package:Bismillah/res/app_constants.dart';
import 'package:Bismillah/widget/common.dialog.view.dart';
import 'package:Bismillah/widget/settings.dialog.view.dart';
import 'package:Bismillah/widget/top.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DialogUtils {
  /// To show the Bottom sheet model - Settings screen
  static Future showSettings(BuildContext context) async {
    return showModalBottomSheet(
        isScrollControlled: false,
        enableDrag: false,
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (_) => CommonDialogView(Scaffold(
              backgroundColor: Colors.transparent,
              appBar: ModalNavBarView(AppStringConstants.settingScreenName),
              body: SettingsDialogView(),
            )));
  }
}
