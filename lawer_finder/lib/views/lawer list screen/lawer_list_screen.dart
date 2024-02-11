// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/widgets/custom_rich_text.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class LawerListScreen extends StatefulWidget {
  const LawerListScreen({Key? key}) : super(key: key);

  @override
  State<LawerListScreen> createState() => _LawerListScreenState();
}

class _LawerListScreenState extends State<LawerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.higlightColor,
        centerTitle: true,
        title: PText(
          text: AppConstant.lawerTitle,
          fontSize: 24.0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
        child: InkWell(
          onTap: () {
            // Handle the onTap action
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: Offset(2, 2),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: Offset(-2, -2),
                ),
              ],
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('lawer_list')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    if (index < 0 || index >= snapshot.data!.docs.length) {
                      return SizedBox.shrink();
                    }

                    var lawerData = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRichText(
                                title: 'Lawyer Name:',
                                subtitle: lawerData['lawer_name'],
                              ),
                              CustomRichText(
                                title: 'Phone:',
                                subtitle: lawerData['phone'],
                              ),
                              CustomRichText(
                                title: 'Office Location',
                                subtitle: lawerData['office'],
                              ),
                              CustomRichText(
                                title: 'Experience ',
                                subtitle: lawerData['expericne'],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      final Uri url = Uri(
                                          scheme: 'sms',
                                          path: lawerData['phone']);

                                      if (await launchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text("Message"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final Uri url = Uri(
                                          scheme: 'tel',
                                          path: lawerData['phone']);

                                      if (await launchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text("Call"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
