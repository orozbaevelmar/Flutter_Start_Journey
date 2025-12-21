import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/theme/app_color.dart';
import 'package:start_journey/cleanArch/core/constants/text_style_const.dart';

class ShowBottomSheet {
  static showBottomSheet(
      {required BuildContext context,
      required String title,
      required List<Widget> list}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctxt) {
        return SafeArea(
          child: Container(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(ctxt).viewInsets.bottom),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: MTextStyle.ui_20Bold(AppColor.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  for (int i = 0; i < list.length; i++) list[i]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
