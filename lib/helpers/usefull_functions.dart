import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:storyteller/util/routes/index.dart';

void showCustomSnackBar(String title, String message, ContentType contentType) {
  final snackBar = SnackBar(
    elevation: 0,
    clipBehavior: Clip.none,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      titleFontSize: 17,
      message: message,
      inMaterialBanner: true,
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(ctx!)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
