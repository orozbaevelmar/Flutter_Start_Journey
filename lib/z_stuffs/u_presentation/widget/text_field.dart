// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:start_journey/z_stuffs/utils/constants/color_const.dart';
import 'package:start_journey/z_stuffs/utils/constants/text_style_const.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.name,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    hidePassword = widget.isPassword ? true : false;
    super.initState();
  }

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 5),
        Icon(
          Icons.arrow_drop_down_outlined,
          size: 22,
          color: MColor.black,
        ),
        SizedBox(width: 5),
        Icon(
          Icons.email,
          color: Colors.blue,
          size: 20,
        ),
        const SizedBox(height: 4),
        Expanded(
          child: TextField(
            controller: widget.controller,
            obscureText: hidePassword,
            enableSuggestions: !(widget.isPassword),
            autocorrect: !(widget.isPassword),
            scrollPadding: const EdgeInsets.only(bottom: 200),
            style: MTextStyle.ui_14Regular(Color(0xff000000)),
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: MTextStyle.ui_16Medium(MColor.gray_04),
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 48, minHeight: 0),
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Icon(
                          hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18,
                        ),
                      )
                    : const SizedBox(height: 0, width: 0),
                //filled: true,
                //fillColor: MColor.gray_01,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                isDense: true,
                constraints: const BoxConstraints(),
                border: InputBorder.none
                /* enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: MColor.greenPrimary, width: 1),
              ), */
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          ),
        ),
      ],
    );
  }
}
