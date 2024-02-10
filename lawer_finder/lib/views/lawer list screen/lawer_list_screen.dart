// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/widgets/custom_rich_text.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  itemBuilder: (context, index) {
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
                                title: 'Lawer Name:',
                                subtitle: lawerData['lawer_name'],
                              ),
                              CustomRichText(
                                title: 'Phone:',
                                subtitle: lawerData['phone'],
                              ),
                              CustomRichText(
                                title: 'Case Handle Area:',
                                subtitle: lawerData['case'],
                              ),
                              CustomRichText(
                                title: 'Office Location',
                                subtitle: lawerData['office'],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implement your hire logic
                                    },
                                    child: Text("Hire Me"),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implement your call logic
                                    },
                                    child: Text("Call Me"),
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
