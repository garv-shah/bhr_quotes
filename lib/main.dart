import 'package:bhr_quotes/auth/landing_page.dart';
import 'package:bhr_quotes/bubbles.dart';
import 'package:bhr_quotes/quotes.dart';
import 'package:bhr_quotes/utils/theme.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Incorrect Quotes',
      home: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Theme(data: AppThemes.darkTheme,
                    child: AuthGate())));
              },
              child: Icon(Icons.login),
            ),
            body: Stack(children: [
              Bubbles(),
              QuoteBox(),
            ]),
          );
        }
      ),
    );
  }
}
