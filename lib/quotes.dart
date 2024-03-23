import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_editor/controller/controllers/editor-controller.dart';
import 'package:visual_editor/document/models/delta-doc.model.dart';
import 'package:visual_editor/document/models/delta/delta.model.dart';
import 'package:visual_editor/editor/models/editor-cfg.model.dart';
import 'package:visual_editor/main.dart';

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
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> quotes_list;

  Future<dynamic> getData() async {
    quotes_list = (await FirebaseFirestore.instance.collection("quotes_list").get()).docs;
  }


  List _random = [
    {
      "insert": "Welcome to the BHR incorrect quotes doc :D"
    },
    {
      "attributes": {
        "align": "center"
      },
      "insert": "\n"
    }
  ];

  late EditorController controller;

  void incrementCounter() {
    setState(() {
      Random random = new Random();
      QueryDocumentSnapshot<Map<String, dynamic>> quote = quotes_list[random.nextInt(quotes_list.length)];
      _random = quote.data()['quote'];
      controller.update(DeltaM.fromJson(_random));
    });
  }

  @override
  void initState() {
    controller = EditorController(document: DeltaDocM.fromJson(_random));
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      width: 450,
                      child: VisualEditor(
                        scrollController: ScrollController(),
                        focusNode: FocusNode(),
                        controller: controller,
                        config: EditorConfigM(
                          scrollable: true,
                          autoFocus: true,
                          expands: false,
                          padding: const EdgeInsets.fromLTRB(
                              8.0, 16.0, 8.0, 16.0),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                incrementCounter();
              },
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
