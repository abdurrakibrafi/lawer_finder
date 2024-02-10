// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/widgets/custom_rich_text.dart';
import 'package:lawer_finder/widgets/text.dart';

class SearchScreen extends StatefulWidget {
  final String keyword;

  const SearchScreen({
    Key? key,
    required this.keyword,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String searchKeyword = widget.keyword
        .toLowerCase(); // Convert to lowercase for case-insensitive search

    // Fetch data from Firestore using the search keyword
    Query query = _firestore
        .collection('search')
        .where('crime_name', isEqualTo: searchKeyword.toLowerCase());

    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: AppTheme.higlightColor,
        centerTitle: true,
        title: PText(
          text: AppConstant.searchScreen,
          fontSize: 24.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: query.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var documents = snapshot.data!.docs;

              if (documents.isEmpty) {
                return Center(
                  child: Text(
                    'No results found for "$searchKeyword"',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              var firstDocument = documents[0];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Crime Name: ${firstDocument['crime_name']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Crime Details: ${firstDocument['details']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  Divider(),
                  Center(
                    child: Text(
                      'Lawyer Suggest',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichText(
                            title: 'Lawyer Name:',
                            subtitle: firstDocument['lawyerName'],
                          ),
                          CustomRichText(
                            title: 'Phone:',
                            subtitle: firstDocument['lawyerPhone'],
                          ),
                          CustomRichText(
                            title: 'Case Handle Area:',
                            subtitle: firstDocument['caseHandleArea'],
                          ),
                          CustomRichText(
                            title: 'Office Location',
                            subtitle: firstDocument['officeLocation'],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Implement action for message button
                                },
                                child: Text("Message"),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement action for call button
                                },
                                child: Text("Call"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
