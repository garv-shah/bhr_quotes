import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bhr_quotes/quote_creator.dart';
import 'package:bhr_quotes/quotes.dart';
import 'package:bhr_quotes/utils/components.dart';
import 'package:bhr_quotes/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visual_editor/controller/controllers/editor-controller.dart';
import 'package:visual_editor/documents/models/document.model.dart';
import 'package:visual_editor/editor/models/editor-cfg.model.dart';
import 'package:visual_editor/main.dart';

import 'auth/landing_page.dart';
import 'bubbles.dart';

class QuoteEditor extends StatefulWidget {
  @override
  State<QuoteEditor> createState() => _QuoteEditorState();
}

class _QuoteEditorState extends State<QuoteEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Quote'),
        icon: const Icon(Icons.add),
        onPressed: () async {
          DocumentReference<Map<String, dynamic>> newQuote =
              await FirebaseFirestore.instance.collection('quotes_list').add({
            'quote': [
              {"insert": "\n"}
            ],
            'createdAt': Timestamp.now()
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Theme(
                        data: AppThemes.darkTheme,
                        child: CreateQuote(
                          document: [
                            {"insert": "\n"}
                          ],
                          onSave: (List<dynamic> data) {
                            FirebaseFirestore.instance
                                .collection('quotes_list')
                                .doc(newQuote.id)
                                .update({'quote': data});
                          },
                        ),
                      )));
        },
      ),
      body: Column(
        children: [
          header('Edit Quotes', context, fontSize: 20, backArrow: true, customBackLogic: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(
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
            )));
          }),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('quotes_list')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, quotesSnapshot) {
                if (quotesSnapshot.connectionState == ConnectionState.active) {
                  if (quotesSnapshot.data?.docs.isEmpty ?? true) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 16.0, 50.0, 16.0),
                      child: Text("No quotes yet, try adding one!"),
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: quotesSnapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> quoteData =
                              quotesSnapshot.data?.docs[index].data()
                                  as Map<String, dynamic>;

                          String? documentID =
                              quotesSnapshot.data?.docs[index].id;

                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(36.0, 6.0, 36.0, 6.0),
                            child: Card(
                                elevation: 5,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    VisualEditor(
                                      scrollController: ScrollController(),
                                      focusNode: FocusNode(),
                                      controller: EditorController(
                                          document: DocumentM.fromJson(
                                              quoteData['quote'])),
                                      config: EditorConfigM(
                                        scrollable: true,
                                        autoFocus: true,
                                        expands: false,
                                        padding: const EdgeInsets.fromLTRB(
                                            16.0, 42.0, 16.0, 42.0),
                                        readOnly: true,
                                        keyboardAppearance:
                                            Theme.of(context).brightness,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Theme(
                                                            data: AppThemes
                                                                .darkTheme,
                                                            child: CreateQuote(
                                                              document:
                                                                  quoteData[
                                                                      'quote'],
                                                              onSave:
                                                                  (List<dynamic>
                                                                      data) {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'quotes_list')
                                                                    .doc(
                                                                        documentID)
                                                                    .update({
                                                                  'quote': data
                                                                });
                                                              },
                                                            ),
                                                          )));
                                            },
                                            icon: Icon(Icons.edit)),
                                        SizedBox(width: 20),
                                        IconButton(
                                            onPressed: () {
                                              showOkCancelAlertDialog(
                                                      okLabel: 'Confirm',
                                                      title: 'Delete Quote',
                                                      message:
                                                          'Are you sure you want to delete this quote?',
                                                      context: context)
                                                  .then((result) async {
                                                if (result ==
                                                    OkCancelResult.ok) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .runTransaction((Transaction
                                                          myTransaction) async {
                                                    myTransaction.delete(
                                                        quotesSnapshot
                                                            .data!
                                                            .docs[index]
                                                            .reference);
                                                  });
                                                }
                                              });
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                )),
                          );
                        });
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
