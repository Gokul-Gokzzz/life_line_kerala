import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/usermodel/member_details.dart';
import 'package:lifelinekerala/service/api_service.dart';

class UserDetailsScreen extends StatefulWidget {
  final String memberId;

  UserDetailsScreen({required this.memberId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = ApiService().fetchUserData(widget.memberId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          try {
            final memberDetails =
                snapshot.data!['memberDetails'] as MemberDetails;
            final familyDetails =
                snapshot.data!['familyDetails'] as List<FamilyDetails>;
            final helpReceived =
                snapshot.data!['helpReceived'] as List<HelpReceived>;

            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text('Member Details',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Name: ${memberDetails.name}'),
                Text('Mobile: ${memberDetails.mobile}'),
                // Add more member details...

                SizedBox(height: 20),
                if (familyDetails.isNotEmpty) ...[
                  Text('Family Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ...familyDetails.map((family) => ListTile(
                        title: Text(family.name),
                        subtitle: Text('Relation: ${family.relation}'),
                      )),
                ] else
                  Text('No family details available'),

                SizedBox(height: 20),
                if (helpReceived.isNotEmpty) ...[
                  Text('Help Received',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ...helpReceived.map((help) => ListTile(
                        title: Text(help.helpType),
                        subtitle: Text('Amount: ${help.creditedAmount}'),
                      )),
                ] else
                  Text('No help received data available'),
              ],
            );
          } catch (e) {
            return Center(child: Text('Something went wrong: $e'));
          }
        },
      ),
    );
  }
}
