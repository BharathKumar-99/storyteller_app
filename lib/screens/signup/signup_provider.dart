import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/constants/table_constants.dart';
import 'package:storyteller/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../initilizing/supabase.dart';
import '../../util/routes/index.dart';
import '../../util/routes/routes_constants.dart';

class SignupProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController nmaeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool passwordObscureText = true;
  bool confirmPasswordObscureText = true;
  bool isAdmin = false;

  void signup(BuildContext context) {
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
    } else if (nmaeController.text.isEmpty) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.nameEmpty,
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
    } else if (confirmPasswordController.text.isEmpty) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.confirmPasswordEmpty,
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (passwordController.text != confirmPasswordController.text) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.passwordMisMatch,
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      signupToSupabase(context);
    }
  }

  signupToSupabase(BuildContext context) async {
    try {
      final AuthResponse res = await SupaFlow.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final Session? session = res.session;
      final User? user = res.user;

      if (session != null && user != null) {
        UserModel userModel = UserModel(
          userId: user.id,
          name: nmaeController.text.trim(),
          email: emailController.text.trim(),
          userName: usernameController.text.trim(),
        );
        await SupaFlow.client
            .from(TableConstants.users)
            .insert(userModel.toJson())
            .select()
            .then((value) {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: StringConstants.success,
              message: StringConstants.pleaseLogin,
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          SupaFlow.client.auth.signOut();
          ctx!.go(RouteConstants.login);
        });
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: StringConstants.ohSnap,
            message: StringConstants.emailExits,
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(ctx!)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: StringConstants.ohSnap,
          message: StringConstants.emailExits,
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(ctx!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
