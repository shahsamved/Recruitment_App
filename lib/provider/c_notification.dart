import 'package:flutter/foundation.dart';

class CNotification {
  final int id;
  final String type;
  final String message;
  final DateTime time;
  final String imageUrl;

  CNotification({
    @required this.id,
    @required this.type,
    @required this.imageUrl,
    @required this.time,
    @required this.message,
  });
}

class CandidateNotificationP with ChangeNotifier {
  List<CNotification> _items = [
    CNotification(
        id: 1,
        type: 'System',
        imageUrl:
            'https://developers.google.com/web/updates/images/generic/notifications.png',
        time: DateTime.now(),
        message: 'This is a Test Notification - 1'),
    CNotification(
        id: 2,
        type: 'System',
        imageUrl:
            'https://developers.google.com/web/updates/images/generic/notifications.png',
        time: DateTime.now(),
        message: 'This is a Test Notification - 2'),
    CNotification(
        id: 3,
        type: 'Promotion',
        imageUrl:
            'https://developers.google.com/web/updates/images/generic/notifications.png',
        time: DateTime.now(),
        message: 'This is a Test Notification - 3'),
    CNotification(
        id: 4,
        type: 'System',
        imageUrl:
            'https://developers.google.com/web/updates/images/generic/notifications.png',
        time: DateTime.now(),
        message: 'This is a Test Notification - 4'),
  ];

  List<CNotification> get items {
    return [..._items];
  }

  CNotification findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
