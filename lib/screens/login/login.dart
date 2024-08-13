import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storyteller/constants/app_constants.dart';
import 'package:storyteller/constants/image_constnats.dart';
import 'package:storyteller/constants/string_constants.dart';
import 'package:storyteller/screens/login/login_provider.dart';
import 'package:storyteller/util/routes/routes_constants.dart';

import '../widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = AppConstants().getWidth(context);
    double height = AppConstants().getHeight(context);
    return Consumer<LoginProvider>(builder: (context, value, widget) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                ImageConstants.logo,
                width: width,
                height: height / 4,
                fit: BoxFit.contain,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(StringConstants.signInMsg,
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    StringConstants.loginScreenMsg,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              TextField(
                controller: value.emailController,
                decoration:
                    InputDecoration(hintText: StringConstants.emailHint),
              ),
              TextField(
                controller: value.passwordController,
                obscureText: value.obscureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      value.obscureText = !value.obscureText;
                      setState(() {});
                    },
                    icon: Icon(
                      value.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: StringConstants.passwordHint,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  value.login(context);
                },
                child: Text(StringConstants.signIn),
              ),
              // Align(
              //     alignment: Alignment.centerRight,
              //     child: TextButton(
              //         onPressed: () {
              //           //TODO Forgot password
              //           context.push(RouteConstants.forgotPassword);
              //         },
              //         child: Text(StringConstants.forgotPassword))),
              Text.rich(
                TextSpan(text: StringConstants.newUser, children: [
                  TextSpan(
                      text: StringConstants.newUserText,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(RouteConstants.register);
                        },
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary))
                ]),
                textAlign: TextAlign.center,
              ),
              getTermsAndConditions()
            ],
          ),
        ),
      );
    });
  }
}
