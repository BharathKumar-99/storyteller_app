import 'package:flutter/material.dart';
import '../constants/string_constants.dart';

Widget getTermsAndConditions() {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: StringConstants.termsAgreement,
          style: TextStyle(color: Colors.grey.shade300),
        ),
        const TextSpan(
          text: StringConstants.termsOfService,
        ),
        TextSpan(
          text: StringConstants.andText,
          style: TextStyle(color: Colors.grey.shade300),
        ),
        const TextSpan(
          text: StringConstants.privacyPolicy,
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );
}
