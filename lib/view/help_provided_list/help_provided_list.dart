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
  late Future<List<HelpModel>> _helpList;
  List<HelpModel>? _filteredHelpList;
  UserProfile? _userProfile;

  Config? _config;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _helpList = Future.value([]);
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    _config = await ApiService().getConfig();
    _userProfile = await ApiService().getUserProfile();
    final helpList = await ApiService().getHelpProvidedList();
    setState(() {
      _filteredHelpList = helpList;
    });
  }

  Future<void> _refreshHelpList() async {
    final helpList = await ApiService().getHelpProvidedList();
    setState(() {
      _filteredHelpList = helpList;
    });
  }

  void _filterHelpList(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredHelpList = _filteredHelpList;
      });
    } else {
      setState(() {
        _filteredHelpList = _filteredHelpList?.where((help) {
          final memberNameLower = help.memberName.toLowerCase();
          final searchLower = query.toLowerCase();
          return memberNameLower.contains(searchLower);
        }).toList();
      });
    }
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
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          suffixIcon: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:
                                const Icon(Icons.search, color: Colors.white),
                          ),
                        ),
                        onChanged: _filterHelpList,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 20),
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
                child: FutureBuilder<List<HelpModel>>(
                  future: _helpList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error: ${snapshot.error}');
                      return const Center(
                          child: Text('Failed to load help list'));
                    } else if (!snapshot.hasData ||
                        _filteredHelpList == null ||
                        _filteredHelpList!.isEmpty) {
                      log('No data: ${snapshot.data}');
                      return const Center(child: Text('No help provided.'));
                    } else {
                      log('Data received: ${snapshot.data}');
                      return RefreshIndicator(
                        onRefresh: _refreshHelpList,
                        child: ListView.builder(
                          itemCount: _filteredHelpList!.length,
                          itemBuilder: (context, index) {
                            final help = _filteredHelpList![index];
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
                                    InfoRow(
                                        title: 'Type', value: help.helpType),
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
                        ),
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
