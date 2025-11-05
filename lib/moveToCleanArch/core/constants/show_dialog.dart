import 'package:flutter/material.dart';
import 'package:start_journey/old_stuffs/u_presentation/widget/custom_button.dart';

import 'package:start_journey/moveToCleanArch/core/constants/app_color.dart';

class ShowDialog {
  static Future<bool?> showDialogSetting(
      {required BuildContext context,
      required String title,
      required String content,
      required VoidCallback onTapYes,
      required String yesButtonText}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отменить'),
            ),
            TextButton(
              onPressed: onTapYes,
              child: Text(yesButtonText),
            ),
          ],
        );
      },
    );
  }

  static void showDialogOnScreen({
    required BuildContext context,
    required String title,
    required VoidCallback onTapYes,
    required VoidCallback onTapNo,
  }) {
    showDialog(
      context: context,
      builder: (ctxt) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: AppColor.greenPrimary,
              fontSize: 20,
            ),
            // textAlign: TextAlign.,
          ),
          titlePadding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          actions: [
            SizedBox(
              width: 100,
              child: CustomButton(title: 'Нет', onTap: onTapNo),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100,
              child: CustomButton(title: 'Да', onTap: onTapYes),
            ),
          ],
        );
      },
    );
  }
}
