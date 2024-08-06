import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storyteller/constants/string_constants.dart';

import '../../constants/image_constnats.dart';
import '../../util/routes/routes_constants.dart';
import 'signup_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: ChangeNotifierProvider<SignupProvider>(
          create: (context) => SignupProvider(),
          builder: (context, wid) {
            return Consumer<SignupProvider>(builder: (context, value, widget) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        ImageConstants.logo,
                        width: width,
                        height: height / 4,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(StringConstants.createAccount,
                              style: Theme.of(context).textTheme.titleLarge),
                          Text(
                            StringConstants.pleaseSignup,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.emailController,
                        decoration: InputDecoration(
                            hintText: StringConstants.emailHint),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.nmaeController,
                        decoration:
                            InputDecoration(hintText: StringConstants.nameHint),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.usernameController,
                        decoration: InputDecoration(
                            hintText: StringConstants.userNameHint),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.passwordController,
                        decoration: InputDecoration(
                            hintText: StringConstants.passwordHint),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: value.confirmPasswordController,
                        decoration: InputDecoration(
                            hintText: StringConstants.confirmPasswordHint),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            value.signup(context);
                          },
                          child: Text(StringConstants.newUserText)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(text: StringConstants.alreadyAUser, children: [
                          TextSpan(
                              text: StringConstants.signIn,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.push(RouteConstants.login);
                                },
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary))
                        ]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            });
          }),
    );
  }
}
