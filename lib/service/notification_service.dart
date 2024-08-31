import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lifelinekerala/model/notificationmodel/notification_model.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String _url =
      'https://lifelinekeralatrust.com/api/v1/user/get_notifications';

  Future<List<NotificationModel>?> fetchNotifications(String memberId) async {
    try {
      final response = await _dio.post(
        _url,
        data: {
          'member_id': memberId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List?;
        if (data != null && data.isNotEmpty) {
          return data.map((json) => NotificationModel.fromJson(json)).toList();
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      return null;
    }
  }

  Future<void> markAsSeen(String notificationId) async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/notifications_seen',
        data: {
          'notification_id': notificationId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        print('Failed to mark notification as seen.');
      }
    } catch (e) {
      print('Error marking notification as seen: $e');
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/notifications_clear_all',
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        print('Failed to clear all notifications.');
      }
    } catch (e) {
      print('Error clearing all notifications: $e');
    }
  }

  Future<int> getUnreadCount(String memberId) async {
    try {
      final response = await _dio.post(
        _url,
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List?;
        return data?.where((n) => n['is_seen'] == 0).length ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      log('Error fetching unread count: $e');
      return 0;
    }
  }
}
