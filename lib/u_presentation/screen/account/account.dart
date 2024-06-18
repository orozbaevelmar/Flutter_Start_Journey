import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:start_journey/u_presentation/widget/text_field.dart';
import 'package:start_journey/utils/constants/color_const.dart';
import 'package:start_journey/utils/constants/text_style_const.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: Icon(
                Icons.account_circle,
                size: 100,
              ),
            ),
            Text(
              'Orozbaev Elmarbek',
              style: GoogleFonts.frankRuhlLibre(fontSize: 30),
            ),
            SizedBox(height: 40),
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.shade100,
              ),
              child: IntlPhoneField(
                style: MTextStyle.ui_14Regular(Color(0xff000000)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Phone number',
                  hintStyle: MTextStyle.ui_16Medium(MColor.gray_04),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                initialCountryCode: 'KG',
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                controller: _phoneNumberController,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.shade100,
              ),
              child: CustomTextField(
                title: 'email',
                keyboardType: TextInputType.emailAddress,
                controller: TextEditingController(),
                hintText: 'email@gmail.com',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
