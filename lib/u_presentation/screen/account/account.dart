import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green.shade100,
              ),
              child: IntlPhoneField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Phone number',
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
          ],
        ),
      ),
    );
  }
}
