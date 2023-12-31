import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';

class PostsModel {
  String key;
  String userName;
  String userImage;
  String userPhone;
  String userEmail;
  Timestamp timestamp;
  List<String> imageUrls;
  String category;
  String condition;
  String title;
  String price;
  String description;
  String location;
  List<String> fav;
  List<String> view;

  PostsModel({
    required this.key,
    required this.userName,
    required this.userImage,
    required this.userPhone,
    required this.userEmail,
    required this.timestamp,
    required this.imageUrls,
    required this.category,
    required this.condition,
    required this.title,
    required this.price,
    required this.description,
    required this.location,
    required this.fav,
    required this.view,
  });

  factory PostsModel.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return PostsModel(
      key: document.id,
      userName: data[AppStrings.userNameField] ?? AppStrings.emptyText,
      userImage: data[AppStrings.userImageField] ?? AppStrings.emptyText,
      userPhone: data[AppStrings.userPhoneField] ?? AppStrings.emptyText,
      userEmail: data[AppStrings.userEmailField] ?? AppStrings.emptyText,
      timestamp: data[AppStrings.timestampField] ?? Timestamp.now(),
      imageUrls: List<String>.from(data[AppStrings.imageUrlsField] ?? []),
      category: data[AppStrings.categoryField] ?? AppStrings.emptyText,
      condition: data[AppStrings.conditionField] ?? AppStrings.emptyText,
      title: data[AppStrings.titleField] ?? AppStrings.emptyText,
      price: data[AppStrings.priceField] ?? AppStrings.emptyText,
      description: data[AppStrings.descriptionField] ?? AppStrings.emptyText,
      location: data[AppStrings.locationField] ?? AppStrings.emptyText,
      fav: List<String>.from(data[AppStrings.favField] ?? []),
      view: List<String>.from(data[AppStrings.viewField] ?? []),
    );
  }
}
