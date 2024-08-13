import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storyteller/constants/keys_constants.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/helpers/login_helper.dart';
import 'package:storyteller/helpers/shared_preferences.dart';
import 'package:storyteller/initilizing/supabase.dart';
import 'package:storyteller/model/user_model.dart';
import 'package:storyteller/supabase_calls/user.dart';
import 'package:storyteller/util/routes/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../util/routes/routes_constants.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  void login(BuildContext context) {
    if (emailController.text.isEmpty) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.emailEmpty,
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (passwordController.text.isEmpty) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.passwordEmpty,
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (passwordController.text.length < 6) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.passwordError,
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (isValidEmailFormat(emailController.text) == false) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.emailError,
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      loginusingEmail(context);
    }
  }

  loginusingEmail(BuildContext context) async {
    try {
      final AuthResponse res = await SupaFlow.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (session != null && user != null) {
        UserModel userModel = await SupaBaseCalls().getuserDetails();

        SharedPreferencesUtil.setString(
            KeyConstants.userName, userModel.userName ?? "");

        SharedPreferencesUtil.setBool(KeyConstants.isTagsSelected,
            userModel.usersTags?.isEmpty ?? true ? false : true);

        ctx!.go(RouteConstants.home);
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.invalidCredentials,
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(ctx!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
