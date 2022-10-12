import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String type;
  String message;
  FieldValue timestamp;
  String? photoUrl;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.message,
    required this.timestamp,
  });

  Message.imageMessage({
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
      'message': message,
      'timestamp': timestamp,
    };
  }

  Message fromMap(Map<String, dynamic> map) {
    return Message(
        senderId: map['senderId'],
        receiverId: map['receiverId'],
        type: map['type'],
        message: map['message'],
        timestamp: map['timestamp']);
  }
}
