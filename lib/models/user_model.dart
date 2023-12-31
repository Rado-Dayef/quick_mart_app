import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:get/get.dart';

class UserModel {
  RxString name = AppStrings.emptyText.obs;
  RxString email = AppStrings.emptyText.obs;
  RxString profileImage = AppStrings.emptyText.obs;
  RxString phone = AppStrings.emptyText.obs;
  RxString city = AppStrings.emptyText.obs;
  RxString area = AppStrings.emptyText.obs;
  RxList chatRoomIds = RxList();

  UserModel({
    String? name,
    String? email,
    String? profileImage,
    String? phone,
    String? city,
    String? area,
    List? chatRoomIds,
  }) {
    this.name.value = name ?? AppStrings.emptyText;
    this.email.value = email ?? AppStrings.emptyText;
    this.profileImage.value = profileImage ?? AppStrings.emptyText;
    this.phone.value = phone ?? AppStrings.emptyText;
    this.city.value = city ?? AppStrings.emptyText;
    this.area.value = area ?? AppStrings.emptyText;
    this.chatRoomIds.value = chatRoomIds ?? [];
  }

  void updateFromMap(Map<String, dynamic> data) {
    name.value = data[AppStrings.nameField] ?? AppStrings.emptyText;
    email.value = data[AppStrings.emailField] ?? AppStrings.emptyText;
    profileImage.value = data[AppStrings.profileImageField] ?? AppStrings.emptyText;
    phone.value = data[AppStrings.phoneNumberField] ?? AppStrings.emptyText;
    city.value = data[AppStrings.cityField] ?? AppStrings.emptyText;
    area.value = data[AppStrings.areaField] ?? AppStrings.emptyText;
    chatRoomIds.value = data[AppStrings.chatRoomIdsField] ?? [];
  }
}
