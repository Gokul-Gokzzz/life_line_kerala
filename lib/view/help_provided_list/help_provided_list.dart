// lib/view/help_provided_list/help_provided_list.dart
import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/helpmodel/help_model.dart';

import 'package:lifelinekerala/service/api_service.dart';
import 'widget/help.dart';

class HelpProvidedList extends StatefulWidget {
  const HelpProvidedList({super.key});

  @override
  State<HelpProvidedList> createState() => _HelpProvidedListState();
}

class _HelpProvidedListState extends State<HelpProvidedList> {
  late Future<List<Help>> helpList;

  @override
  void initState() {
    super.initState();
    helpList = ApiService().getHelpProvidedList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Your UI elements for the header
                SizedBox(height: 50),
                Text(
                  'Help Provided List ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
                FutureBuilder<List<Help>>(
                  future: helpList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Failed to load help list'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No help records available'));
                    } else {
                      return Column(
                        children: snapshot.data!.map((help) {
                          return Center(
                            child: Container(
                              width: 330,
                              height: 200,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.blue,
                                        child: Image.asset('assets/person.png'),
                                      ),
                                      SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            help.memberName,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  InfoRow(title: 'Type', value: help.helpType),
                                  InfoRow(
                                      title: 'Incident Date',
                                      value: help.incidentDate),
                                  InfoRow(
                                      title: 'Cheque Number',
                                      value: help.chequeNumber),
                                  InfoRow(
                                      title: 'Credited Date',
                                      value: help.creditedDate),
                                  InfoRow(
                                      title: 'Credited Amount',
                                      value: help.creditedAmount),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
