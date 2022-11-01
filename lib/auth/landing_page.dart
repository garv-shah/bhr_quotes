import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bhr_quotes/auth/login_page.dart';
import 'package:bhr_quotes/quote_editor.dart';

/// This is the Auth Gate and acts as a router to redirect a user to the
/// respective page based on their status.
///
/// More documentation can be viewed [here](https://github.com/cgs-math/app#landing-page)
class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        // If user state has an error.
        if (authSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${authSnapshot.error}"),
            ),
          );
        }

        // User is not signed in: user state does not have data
        if (!authSnapshot.hasData) {
          return loginPage();
        }

        // User is signed in: user state has data
        if (authSnapshot.hasData) {
          return QuoteEditor();
        }

        // If user is signed in and all checks are passed.
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
