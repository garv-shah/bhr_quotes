import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:bhr_quotes/utils/components.dart';
import 'package:bhr_quotes/utils/login_functions.dart';

/// This is the login page for users.
///
/// Utilising the FlutterFire UI [SignInScreen] class, it handles all logins,
/// registering and forgotten passwords.
///
/// More documentation can be viewed [here](https://github.com/cgs-math/app#login-page)
SignInScreen loginPage() {
  return SignInScreen(
    showAuthActionSwitch: false,
    // These are actions such as forgot password.
    actions: [
      ForgotPasswordAction((context, email) {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ForgotPasswordScreen(
                email: email,
                headerMaxExtent: 200,
                headerBuilder: headerIcon(context, Icons.lock),
                sideBuilder: sideIcon(context, Icons.lock),
              ),
            ));
      }),
    ],
    // Images and headers are built using the utility functions found in the
    // login_functions file.
    headerBuilder: (context, constraints, _) {
      return header("BHR Quotes", context);
    },
    sideBuilder: sideImage('assets/app_icon.svg'),
    subtitleBuilder: (context, action) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Text('welcome to the quotes doc!'),
      );
    },
    footerBuilder: (context, action) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('By signing in, you agree to sign your life away',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
    },
  );
}
