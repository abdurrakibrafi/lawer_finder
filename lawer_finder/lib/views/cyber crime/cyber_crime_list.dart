import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lawer_finder/app/theme.dart';
import 'package:lawer_finder/widgets/custom_rich_text.dart';
import 'package:lawer_finder/widgets/text.dart';

class CyberList extends StatefulWidget {
  const CyberList({Key? key}) : super(key: key);

  @override
  State<CyberList> createState() => _CyberListState();
}

class _CyberListState extends State<CyberList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppTheme.higlightColor,
        centerTitle: true,
        title: PText(
          text: "Cyber Crime List",
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
              stream:
                  FirebaseFirestore.instance.collection('crime').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    print("Data length: ${snapshot.data!.docs.length}");
                    if (index >= snapshot.data!.docs.length) {
                      return Container();
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
                                title: 'Crime Name: ',
                                subtitle: lawerData['name'],
                              ),
                              CustomRichText(
                                title: 'Brief Details: ',
                                subtitle: lawerData['details'],
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
