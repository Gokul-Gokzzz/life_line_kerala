import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/confgmodel/config_model.dart';
import 'package:lifelinekerala/model/helpmodel/help_model.dart';
import 'package:lifelinekerala/model/usermodel/user_model.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'widget/help.dart';

class HelpProvidedList extends StatefulWidget {
  const HelpProvidedList({super.key});

  @override
  State<HelpProvidedList> createState() => _HelpProvidedListState();
}

class _HelpProvidedListState extends State<HelpProvidedList> {
  late Future<List<Help>> helpList;
  UserProfile? _userProfile;
  Config? _config;

  @override
  void initState() {
    super.initState();
    // Initialize helpList with an empty Future
    helpList = Future.value([]);
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    _config = await ApiService().getConfig(); // Fetch Config
    _userProfile = await ApiService().getUserProfile('5'); // Fetch UserProfile
    helpList = ApiService().getHelpProvidedList('5'); // Fetch Help List
    setState(() {}); // Update the state after data fetching is done
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Help Provided List',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Help>>(
                  future: helpList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error: ${snapshot.error}');
                      return const Center(
                          child: Text('Failed to load help list'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      log('No data: ${snapshot.data}');
                      return const Center(child: Text(''));
                    } else {
                      log('Data received: ${snapshot.data}');
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final help = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
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
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: buildProfileImage(),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            help.memberName,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
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
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    if (_config == null ||
        _userProfile == null ||
        _userProfile!.image.isEmpty) {
      return const Icon(Icons.person, size: 80, color: Colors.grey);
    }

    final imageUrl =
        '${_config!.baseUrls.customerImageUrl}/${_userProfile!.image}';

    return Image.network(
      imageUrl,
      height: 80,
      width: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.person, size: 80, color: Colors.grey);
      },
    );
  }
}
