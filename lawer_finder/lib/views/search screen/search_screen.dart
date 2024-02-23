// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/widgets/bullet_text_widget.dart';
import 'package:lawer_finder/widgets/custom_rich_text.dart';
import 'package:lawer_finder/widgets/punishment_main_title.dart';
import 'package:lawer_finder/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/suggestion_step_widget.dart';

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
                    Text(
                      'Crime-Name: ${firstDocument['name of crime']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),

                    Divider(),
                    Text(
                      'Details:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      '${firstDocument['details']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    Divider(),
                    Text(
                      'Punishment as per Bangladeshi law:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      firstDocument['punishment_title'],
                      style: TextStyle(color: Colors.white),
                    ),

                    /// step one
                    PunishmentMainTitle(
                      Title: firstDocument['punishment_main_title_one'],
                      number: 'i)',
                    ),
                    BulletText(
                      Title: firstDocument['punishment_one'],
                    ),
                    PunishmentMainTitle(
                      Title: firstDocument['punishment_main_title_two'],
                      number: 'ii)',
                    ),
                    BulletText(
                      Title: firstDocument['punishment_two'],
                    ),
                    Divider(),
                    Text(
                      'Probable step maybe taken for solution: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// step two
                    SuggestionText(
                      Title: firstDocument["suggestion_step_one"],
                    ),
                    SuggestionText(
                      Title: firstDocument["suggestion_step_two"],
                    ),
                    SuggestionText(
                      Title: firstDocument["suggestion_step_three"],
                    ),
                    SuggestionText(
                      Title: firstDocument["suggestion_step_four"],
                    ),
                    SuggestionText(
                      Title: firstDocument["suggestion_step_five"],
                    ),
                    SuggestionText(
                      Title: firstDocument["suggestion_step_six"],
                    ),
                    Divider(),
                    Text(
                      'Contact information for filing complaints: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRichText(
                              title: 'Address: ',
                              subtitle: '${firstDocument['station_addrrss']}',
                            ),
                            CustomRichText(
                              title: 'Duty Officer:',
                              subtitle: '${firstDocument['duty_officer']}',
                            ),
                            CustomRichText(
                              title: 'National Emergency Service:',
                              subtitle: '999',
                            ),
                            CustomRichText(
                              title: 'DMP: ',
                              subtitle: '${firstDocument['dmp']}',
                            ),
                            CustomRichText(
                              title: "DMP's Cyber Crime Unit : ",
                              subtitle: 'cyberunit@dmp.gov.bd',
                            ),
                            CustomRichText(
                              title: "CID Cyber Unit:",
                              subtitle: 'cyber@police.gov.bd',
                            ),
                            CustomRichText(
                              title: "Phone ",
                              subtitle: '${firstDocument['call']}',
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    final Uri url = Uri(
                                        scheme: 'tel',
                                        path: firstDocument['police_call']);

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
                                        scheme: 'tel',
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
