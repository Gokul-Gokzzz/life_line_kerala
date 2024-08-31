import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/helpmodel/help_model.dart';
import 'package:lifelinekerala/model/confgmodel/config_model.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'widget/help.dart';

class HelpReceivedScreen extends StatefulWidget {
  const HelpReceivedScreen({super.key});

  @override
  State<HelpReceivedScreen> createState() => _HelpReceivedScreenState();
}

class _HelpReceivedScreenState extends State<HelpReceivedScreen> {
  late Future<List<Help>> helpReceivedList;
  late Future<Config> config;

  @override
  void initState() {
    super.initState();
    config = ApiService().getConfig();
    helpReceivedList = ApiService().getHelpReceivedList('5');
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
              Row(
                children: [
                  const SizedBox(width: 260),
                  Image.asset(
                    'assets/bell.png',
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 20),
                  Image.asset(
                    'assets/logout.png',
                    height: 25,
                    width: 25,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                'Help Received List',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Help>>(
                  future: helpReceivedList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error: ${snapshot.error}');
                      return const Center(
                          child: Text('Failed to load help list'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      log('No data: ${snapshot.data}');
                      return const Center(
                          child: Text('No help records available'));
                    } else {
                      log('Data received: ${snapshot.data}');
                      return FutureBuilder<Config>(
                        future: config,
                        builder: (context, configSnapshot) {
                          if (configSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (configSnapshot.hasError) {
                            log('Error fetching config: ${configSnapshot.error}');
                            return const Center(
                                child: Text('Failed to load configuration'));
                          } else if (!configSnapshot.hasData) {
                            return const Center(
                                child: Text('No configuration data available'));
                          } else {
                            final configData = configSnapshot.data!;
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final help = snapshot.data![index];
                                final imageUrl =
                                    '${configData.baseUrls.customerImageUrl}';
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Image.network(
                                                imageUrl,
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                      Icons.person,
                                                      size: 80,
                                                      color: Colors.grey);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Family Member Name',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  help.familyMemberName,
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
                                        InfoRow(
                                            title: 'Help Type',
                                            value: help.helpType),
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
}
