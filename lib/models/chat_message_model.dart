import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';

class ChatMessageModel {
  String key;
  Timestamp timestamp;
  String senderEmail;
  String message;
  bool isSeen;

  ChatMessageModel({
    required this.key,
    required this.senderEmail,
    required this.timestamp,
    required this.message,
    required this.isSeen,
  });

  factory ChatMessageModel.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return ChatMessageModel(
      key: document.id,
      senderEmail: data[AppStrings.senderEmailField] ?? AppStrings.emptyText,
      message: data[AppStrings.messageField] ?? AppStrings.emptyText,
      timestamp: data[AppStrings.timestampField] ?? Timestamp.now(),
      isSeen: data[AppStrings.isSeenField] ?? Timestamp.now(),
    );
  }
}
