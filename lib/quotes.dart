import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      width: 3.0,
      color: Colors.black54,
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(30.0) //                 <--- border radius here
    ),
    color: Color.fromRGBO(83, 158, 224, 0.7),
  );
}

class QuoteBox extends StatefulWidget {
  @override
  State<QuoteBox> createState() => _QuoteBoxState();
}

class _QuoteBoxState extends State<QuoteBox> {
  var _mFacts;

  Future<dynamic> getData() async {

    final DocumentReference document = FirebaseFirestore.instance.collection("quotes").doc('list');

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async{
      setState(() {
        _mFacts = (snapshot.data() as Map<String,dynamic>)['quote'];
        print(_mFacts);
      });
    });
  }


  String? _random = '`Welcome to the BHR incorrect quotes doc :D';

  void incrementCounter() {
    setState(() {
      Random random = new Random();
      _random = _mFacts[random.nextInt(_mFacts.length)];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    Widget getQuote(name) {
      if (name.split(":")[0] == "https") {
        return Column(
          children: <Widget>[
            SizedBox(height: 20),
            Image.network(
              name,
              height: height / 3,
            ),
            SizedBox(height: 20)
          ],
        );
      } else {
        print(name);
        return RichText(
          text: TextSpan(
            text: name.split("`")[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            children: <TextSpan>[
              TextSpan(text: name.split("`")[1], style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              )),
            ],
          ),
          textAlign: TextAlign.center,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(30.0),
                decoration:
                myBoxDecoration(), //             <--- BoxDecoration here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('BHRs', style: GoogleFonts.neucha().copyWith(fontSize: 60)),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [ for (var name in '$_random'.split(";")) getQuote(name) ]
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: incrementCounter,
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromRGBO(255, 250, 148, 1),
                backgroundColor: Color.fromRGBO(219, 174, 59, 0.85),
                elevation: 8.0,
                padding: EdgeInsets.all(20.0),
                animationDuration: Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Color.fromRGBO(156, 136, 86, 1), width: 3.0),
                ),
              ),
              child: Text('Click Me!', style: GoogleFonts.comfortaa().copyWith(fontSize: 16, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
