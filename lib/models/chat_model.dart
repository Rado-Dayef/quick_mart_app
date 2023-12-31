import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';

class ChatModel {
  String key;
  List images;
  List emails;
  List names;
  Timestamp timestamp;

  ChatModel({
    required this.key,
    required this.images,
    required this.emails,
    required this.names,
    required this.timestamp,
  });

  factory ChatModel.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return ChatModel(
      key: document.id,
      images: data[AppStrings.imagesField] ?? [],
      emails: data[AppStrings.emailsField] ?? [],
      names: data[AppStrings.namesField] ?? [],
      timestamp: data[AppStrings.timestampField] ?? Timestamp.now(),
    );
  }
}
