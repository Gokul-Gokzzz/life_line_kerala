import 'package:flutter/material.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'package:lifelinekerala/model/usermodel/user_model.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();
  UserProfile? _userProfile;
  bool _isLoading = true;
  bool _showFullDetails = false;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final profile = await _apiService.getUserProfile('5');
    setState(() {
      _userProfile = profile;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _userProfile != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: 20),
                          _buildProfileHeader(),
                          const SizedBox(height: 20),
                          _buildProfileDetails(),
                        ],
                      ),
                    ),
                  )
                : const Center(child: Text('Failed to load user details')),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Image.asset(
          'assets/menus.png', // Replace with your menu icon asset
          height: 30,
          width: 30,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                suffixIcon: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Image.asset(
          'assets/bell.png', // Replace with your notification icon asset
          height: 25,
          width: 25,
        ),
        const SizedBox(width: 5),
        Image.asset(
          'assets/logout.png', // Replace with your logout icon asset
          height: 25,
          width: 25,
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    'assets/person.png', // Replace with your person icon asset
                    height: 80,
                    width: 80,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userProfile!.name ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(_userProfile!.districtName ?? 'N/A'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Personal Details',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Edit your details',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildProfileDetail('Name', _userProfile!.name ?? 'N/A'),
          _buildProfileDetail('Lifeline ID', _userProfile!.lifelineId ?? 'N/A'),
          _buildProfileDetail(
              'Account Amount', _userProfile!.accountAmount.toString()),
          _buildProfileDetail('Mobile', _userProfile!.mobile ?? 'N/A'),
          _buildProfileDetail('UPI ID', _userProfile!.upiId ?? 'N/A'),
          _buildProfileDetail('Place', _userProfile!.place ?? 'N/A'),
          _buildProfileDetail(
              'District Name', _userProfile!.districtName ?? 'N/A'),
          _buildProfileDetail(
              'Aadhaar Number', _userProfile!.aadhaarNumber ?? 'N/A'),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              setState(() {
                _showFullDetails = !_showFullDetails;
              });
            },
            child: Text(
              _showFullDetails ? 'Show Less' : 'Show Full Details',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          if (_showFullDetails) _buildFullProfileDetails(),
        ],
      ),
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildFullProfileDetails() {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileDetail('Email', _userProfile!.email ?? 'N/A'),
          _buildProfileDetail('Address', _userProfile!.address ?? 'N/A'),
          _buildProfileDetail('IFSC Code', _userProfile!.ifscCode ?? 'N/A'),
          _buildProfileDetail('Image', _userProfile!.image ?? 'N/A'),
          _buildProfileDetail('Signature', _userProfile!.signature ?? 'N/A'),
          _buildProfileDetail(
              'Other Documents', _userProfile!.otherDocumentDetails ?? 'N/A'),
          _buildProfileDetail(
            'Created At',
            _formatDate(_userProfile!.createdAt),
          ),
          _buildProfileDetail(
            'Updated At',
            _formatDate(_userProfile!.updatedAt),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
    } catch (e) {
      return 'Invalid date format';
    }
  }
}
