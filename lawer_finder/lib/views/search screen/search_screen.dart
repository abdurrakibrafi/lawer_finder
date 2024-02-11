// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/widgets/custom_rich_text.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

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
    String searchKeyword = widget.keyword;

    Query query = _firestore
        .collection('search')
        .where('crime_name', arrayContains: searchKeyword);

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
      body: SingleChildScrollView(
        child: Padding(
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
                        'Crime Name: ${firstDocument['name of crime']}',
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
                        'Crime Solution',
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
                      'Crime Solution: ${firstDocument['solution']}',
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
                              subtitle: '${firstDocument['lawyer']}',
                            ),
                            CustomRichText(
                              title: 'Phone:',
                              subtitle: '${firstDocument['phone']}',
                            ),
                            CustomRichText(
                              title: 'Case Handle Area:',
                              subtitle: '${firstDocument['case_area_lawer']}',
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    final Uri url = Uri(
                                        scheme: 'sms',
                                        path: firstDocument['phone']);

                                    if (await launchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text("Message"),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    final Uri url = Uri(
                                        scheme: 'sms',
                                        path: firstDocument['phone']);

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
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
