// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:lawer_finder/app/constants.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/widgets/custom_rich_text.dart';
import 'package:lawer_finder/widgets/text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Crime Name: Phishing',
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
              'Crime Details: Phishing is a technique used by cyber criminals to trick people into installing some malicious software, most likely through a link. “The majority of successful cyber-attacks - 91% according to a study by PhishMe - begin when curiosity, fear, or a sense of urgency entices someone to enter personal data or click on a link.”',
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
              'Crime Details: Phishing is a technique used by cyber criminals to trick people into installing some malicious software, most likely through a link. “The majority of successful cyber-attacks - 91% according to a study by PhishMe - begin when curiosity, fear, or a sense of urgency entices someone to enter personal data or click on a link.”',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomRichText(
                      title: 'Lawyer Name:',
                      subtitle: 'fghg',
                    ),
                    CustomRichText(
                      title: 'Phone:',
                      subtitle: 'fhgd',
                    ),
                    CustomRichText(
                      title: 'Case Handle Area:',
                      subtitle: 'fhf',
                    ),
                    CustomRichText(
                      title: 'Office Location',
                      subtitle: 'hfg',
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Implement your hire logic
                          },
                          child: Text("Message"),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Implement your call logic
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
        ),
      ),
    );
  }
}
