import 'dart:developer';

import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:start_journey/cleanArch/core/constants/string_constants.dart';

mixin Validator {
  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.required;
    } else if (!RegExp(
      r'^.+@[a-zA-Z]+\.[a-zA-Z]+(\.?[a-zA-Z]+)$',
    ).hasMatch(value)) {
      return StringConstants.invalidEmail;
    }
    return null;
  }

  String? isValidPhone(String phone, String isoCode) {
    final loggedPhone = PhoneNumber.parse(
      phone,
      destinationCountry: IsoCode.values.byName(isoCode),
    );
    if (!loggedPhone.isValid()) {
      log("IN VALID PHONE");
      return StringConstants.invalidFormat;
    }
    log("VALID PHONE");
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.required;
    }

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final hasNumberOrSpecial = RegExp(
      r'[0-9!@#$%^&*(),.?":{}|<>]',
    ).hasMatch(value);

    if (value.length < 7) {
      return StringConstants.passwordMinLen;
    }

    if (!hasUppercase) {
      return StringConstants.atLeastOneUppercase;
    }
    if (!hasLowercase) {
      return StringConstants.atLeastOneLowercase;
    }
    if (!hasNumberOrSpecial) {
      return StringConstants.atLeastNumberOrSpecialChar;
    }

    return null;
  }

  // Confirm password validation
  String? validateRepeatPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return StringConstants.required;
    } else if (value != password) {
      return StringConstants.confirmPasswordDoesNotMatch;
    }
    return null;
  }

  // Name validation
  String? validateRequiredField(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.required;
    }
    return null;
  }
}
