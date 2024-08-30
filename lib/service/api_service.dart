import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lifelinekerala/model/confgmodel/config_model.dart';
import 'package:lifelinekerala/model/helpmodel/help_model.dart';
import 'package:lifelinekerala/model/loginmodel/login_model.dart';
import 'package:lifelinekerala/model/transactionmodel/transaction_model.dart';
import 'package:lifelinekerala/model/usermodel/user_model.dart';

class ApiService {
  final String baseUrl = 'https://lifelinekeralatrust.com/api/v1/';
  final Dio _dio = Dio();

  Future<Config> fetchConfig() async {
    final response =
        await _dio.get('https://lifelinekeralatrust.com/api/v1/config');
    if (response.statusCode == 200) {
      return Config.fromJson(response.data);
    } else {
      throw Exception('Failed to load config');
    }
  }

  //---login---Service---//
  Future<LoginModel?> login(String userName, String password) async {
    final url = "${baseUrl}auth/login";

    try {
      final response = await _dio.post(
        url,
        data: {
          'userName': userName,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        log('Login failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Login failed with error: $e');
      return null;
    }
  }

  //---user---view--//

  Future<UserProfile?> getUserView(int memberId) async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/profile',
        data: {
          'member_id': memberId.toString(),
        },
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        final userProfile = UserProfile.fromJson(response.data['data']);
        return userProfile;
      } else {
        print('Failed to load profile. Message: ${response.data['message']}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

//---- user==profilr---//
  Future<UserProfile?> getUserProfile(String memberId) async {
    final url = '${baseUrl}user/profile';

    try {
      final response = await _dio.post(
        url,
        data: {'member_id': memberId},
      );

      log('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody != null && responseBody is Map<String, dynamic>) {
          final data = responseBody['data'];
          if (data != null && data is Map<String, dynamic>) {
            return UserProfile.fromJson(data);
          } else {
            log('Invalid data format');
            return null;
          }
        } else {
          log('Invalid response format');
          return null;
        }
      } else {
        log('Failed to fetch user profile with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Failed to fetch user profile with error: $e');
      return null;
    }
  }

  //---dashboard--//
  Future<UserProfile?> getDashboard() async {
    try {
      final response = await _dio
          .get('https://lifelinekeralatrust.com/api/v1/user/dashboard');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        return UserProfile.fromJson(data['member_details']);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  //--transaction---//
  Future<List<Transaction>> getTransactionList(String memberId) async {
    const String url =
        'https://lifelinekeralatrust.com/api/v1/user/transactions';

    try {
      final response = await _dio.post(
        url,
        data: {'member_id': memberId}, // Add necessary POST data if required
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // if needed
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['list']['data'];
        return data.map((item) => Transaction.fromJson(item)).toList();
      } else {
        log('Error: ${response.statusCode}');
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Failed to load transactions: $e');
    }
  }
  //---help--list---//

  Future<List<Help>> getHelpProvidedList() async {
    const String url = 'https://lifelinekeralatrust.com/api/v1/user/help_list';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['list']['data'];
        return data.map((item) => Help.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load help list');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to load help list: $e');
    }
  }
}
