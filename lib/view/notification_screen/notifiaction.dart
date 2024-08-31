import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/notificationmodel/notification_model.dart';
import 'package:lifelinekerala/service/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>?> _notifications;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final notifications = await NotificationService().fetchNotifications('5');
    setState(() {
      _notifications = Future.value(notifications);
      _unreadCount = notifications?.where((n) => n.isSeen == 0).length ?? 0;
    });
  }

  void _markAsSeen(String notificationId) async {
    await NotificationService().markAsSeen(notificationId);
    _loadNotifications(); // Refresh notifications after marking as seen
  }

  void _clearAllNotifications() async {
    await NotificationService().clearAllNotifications();
    _loadNotifications(); // Refresh notifications after clearing all
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Handle the icon button press
                },
              ),
              if (_unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    child: Center(
                      child: Text(
                        '$_unreadCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: _clearAllNotifications,
          ),
        ],
      ),
      body: FutureBuilder<List<NotificationModel>?>(
        future: _notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                title: Text(notification.type),
                subtitle: Text(notification.description),
                tileColor:
                    notification.isSeen == 1 ? Colors.white : Colors.blue,
                textColor:
                    notification.isSeen == 1 ? Colors.black : Colors.white,
                onTap: () {
                  if (notification.isSeen == 0) {
                    _markAsSeen(notification.id.toString());
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
