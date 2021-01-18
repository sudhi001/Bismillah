import 'package:Bismillah/widget/common.dialog.view.dart';
import 'package:Bismillah/widget/top.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DialogUtils {
  static void showSettings(BuildContext context,Widget content) async {
    await showModalBottomSheet(
        isScrollControlled: false,
        enableDrag: false,
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (_) => CommonDialogView(Scaffold(
          backgroundColor: Colors.transparent,
          appBar: ModalNavBarView("Application Settings"),
                  body: content,
        )));
  }
 

}
