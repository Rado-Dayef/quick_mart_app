import 'package:awesome_icons/awesome_icons.dart';
import 'package:com.rado.quick_mart/controllers/nav_bar_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppStrings {
  static var currentUser = FirebaseAuth.instance.currentUser;
  static NavBarController navBarController = Get.put(NavBarController());

  // App
  static const String appSubTitle = "Discover, Shop, Enjoy!";
  static const String appTitle = "Quick Mart";
  static String currentUserAddress = currentUser == null ? emptyText : "${navBarController.user.value.city}, ${navBarController.user.value.area}";
  static String currentUserEmail = currentUser == null ? emptyText : currentUser!.email!;

  // Routes
  static const String forgotPasswordRout = "/forgetPassword";
  static const String firstPostRout = "/firstPost";
  static const String categoryRout = "/category";
  static const String userChatRout = "/userChat";
  static const String editPostRout = "/editAd";
  static const String accountRout = "/account";
  static const String profileRout = "/profile";
  static const String settingRout = "/setting";
  static const String libraryRout = "/library";
  static const String addPostRout = "/addAd";
  static const String searchRout = "/search";
  static const String signupRout = "/signup";
  static const String splashRout = "/splash";
  static const String navBarRout = "/navBar";
  static const String loginRout = "/login";
  static const String chatRout = "/chat";
  static const String postRout = "/post";
  static const String homeRout = "/home";

  // Images
  static const String authBackgroundImage = "assets/images/authBackground.png";

  // Screens
  static const String homeSubTitleText = "Scroll, Shop, Smile. Your Joyful Marketplace.";
  static const String addPostSubTitleText = "Create a listing for your item with ease.";
  static const String accountSubTitleText = "Manage Your Profile and Preferences.";
  static const String categorySubTitleText = "Discover Your Perfect Categories.";
  static const String librarySubTitleText = "Where Stories and Goods Unite.";
  static const String chatSubTitleText = "Where Words Create Connections.";
  static const String chatRoomsText = "Chat Rooms";
  static const String addPostText = "Add Post";
  static const String accountText = "Account";
  static const String libraryText = "Library";
  static const String homeText = "Home";

  // Collection, Documents, Fields Name
  static const String receiverProfileImageField = "receiverProfileImage";
  static const String senderProfileImageField = "senderProfileImage";
  static const String profileImageField = "profileImage";
  static const String chatRoomsCollection = "chatRooms";
  static const String phoneNumberField = "phoneNumber";
  static const String descriptionField = "description";
  static const String chatRoomIdsField = "chatRoomIds";
  static const String senderEmailField = "senderEmail";
  static const String messagesCollection = "messages";
  static const String authUsersDocument = "authUsers";
  static const String chatRoomsField = "chatRooms";
  static const String userEmailField = "userEmail";
  static const String userImageField = "userImage";
  static const String userPhoneField = "userPhone";
  static const String timestampField = "timestamp";
  static const String imageUrlsField = "imageUrls";
  static const String conditionField = "condition";
  static const String userNameField = "userName";
  static const String categoryField = "category";
  static const String locationField = "location";
  static const String postsCollection = "posts";
  static const String usersCollection = "users";
  static const String messageField = "message";
  static const String emailsField = "emails";
  static const String imagesField = "images";
  static const String isSeenField = "isSeen";
  static const String namesField = "names";
  static const String emailField = "email";
  static const String titleField = "title";
  static const String priceField = "price";
  static const String nameField = "name";
  static const String cityField = "city";
  static const String areaField = "area";
  static const String iconField = "icon";
  static const String viewField = "view";
  static const String keyField = "key";
  static const String favField = "fav";

  // Base URLs
  static const String profileImageNameBase = "_profile_image.jpg";
  static const String profileImagesBase = "profileImages/";
  static const String postsImagesBase = "postsImages/";
  static const String imagesTypeBase = "image/jpg";

  // Assets
  static const String splashJson = "assets/jsons/splashJson.json";

  //Fonts
  static const String timesFont = "Times";
  static const String eloraFont = "Elora";

  // Messages
  static const String changePasswordMessage = "Are you sure that you want to change your password ?";
  static const String deleteAccountMessage = "Please confirm your password to delete your account.";
  static const String deletePostMessage = "Are you sure that you want to delete this post ?";
  static const String errorSendingMessage = "Error sending password reset email: ";
  static const String imageFailedUploadingMessage = "Failed uploading your image";
  static const String noPostsForCategoryMessage = "No ads for that category yet";
  static const String logoutMessage = "Are you sure that you want to logout ?";
  static const String errorUploadingImageMessage = "Error uploading image: ";
  static const String noAdsForSearchMessage = "No ads for that search";
  static const String noFavPostsYetMessage = "No favorite ads yet";
  static const String noAdsForYouYetMessage = "No ads for you yet";
  static const String noChatsYetMessage = "No chats for you yet";
  static const String noRelatedAdaMessage = "No related ads";
  static const String noAdsYetMessage = "No ads yet";

  // Toasts
  static const String emailSentSuccessfullyToast = "Email sent successfully, please check your email to reset your password.";
  static const String yourEmailNotInOurDatabaseToast = "Your email is not in our database, Try to signup with that email.";
  static const String passwordChanedSuccessfullyToast = "Password changed successfully.";
  static const String accountDeletedSuccessfullyToast = "Account deleted successfully.";
  static const String connectionErrorToast = "Please check your internet connection.";
  static const String selectConditionToast = "PLease select condition for your item.";
  static const String selectCategoryToast = "PLease select category for your item.";
  static const String verifyEmailFirstToast = "Please verify your email first.";
  static const String emailCanNotBeEditedToast = "Email field can't be edited.";
  static const String errorResettingPasswordToast = "Error resetting password";
  static const String uploadImageToast = "PLease upload image for your item.";
  static const String itemAlreadyOpenedToast = "This item is already opened.";
  static const String errorCreatingNewChatToast = "Error creating new chat: ";
  static const String errorDeletingAccountToast = "Error deleting account: ";
  static const String deletedSuccessfullyToast = "Deleted successfully.";
  static const String updatedSuccessfullyToast = "Updated successfully.";
  static const String emptyMessageToast = "can't send empty message.";
  static const String errorUploadingToast = "Error uploading: ";
  static const String imageEditToast = "Image can't be edited.";
  static const String errorDeletingToast = "Error deleting: ";
  static const String errorFetchingToast = "Error fetching: ";
  static const String errorUpdatingToast = "Error updating: ";

  // Validations
  static const String oldPasswordLargerThen24Validate = "Old password can't be larger then 24 letters";
  static const String newPasswordLargerThen24Validate = "New password can't be larger then 24 letters";
  static const String oldPasswordLessThen8Validate = " Old password can't be less then 8 letters";
  static const String newPasswordLessThen8Validate = " New password can't be less then 8 letters";
  static const String passwordLargerThen24Validate = "Password can't be larger then 24 letters";
  static const String nameLargerThen24Validate = "User name can't be larger then 24 letters";
  static const String phoneNumberBadlyFormattedValidate = "Phone Number is badly formatted";
  static const String badlyFormattedPhoneNumberValidate = "Phone Number is badly formatted";
  static const String passwordLessThen8Validate = "Password can't be less then 8 letters";
  static const String nameLessThen4Validate = "User name can't be less then 4 letters";
  static const String phoneNumberEmptyValidate = "Phone Number can't be empty";
  static const String newPasswordEmptyValidate = "New password can't be empty";
  static const String oldPasswordEmptyValidate = "Old password can't be empty";
  static const String descriptionEmptyValidate = "Description can't be empty";
  static const String emailEmptyValidate = "Email address can't be empty";
  static const String emailMessingAtSignValidate = "Email is messing '@'";
  static const String invalidPhoneNumberValidate = "Invalid Phone Number";
  static const String passwordEmptyValidate = "Password can't be empty";
  static const String titleEmptyValidate = "Title can't be empty";
  static const String priceEmptyValidate = "Price can't be empty";
  static const String cityEmptyValidate = "City can't be empty";
  static const String areaEmptyValidate = "Area can't be empty";

  // Placeholders
  static const String descriptionPlaceholder = "Enter item description";
  static const String titlePlaceholder = "Enter item title";
  static const String pricePlaceholder = "Enter item price";

  // Else
  static const String uploadImageButtonText = "Click here to upload your item images";
  static const String mailtoText = "mailto:<quick0mart0shop@gmail.com>?subject=";
  static const String isItemAvailableText = ", Is this item still available";
  static const String alreadyHaveAnAccountText = "already have an account";
  static const String uploadedSuccessfullyText = "Uploaded Successfully";
  static const String updatedSuccessfullyText = "Updated Successfully";
  static const String doNotHaveAnAccountText = "Don't have an account";
  static const String forgotPasswordButtonText = "Forgot Password ?";
  static const String firstChatMessageText = "Welcome to the chat!";
  static const String nameEmptyText = "User name can't be empty";
  static const String confirmPasswordText = "Confirm Password";
  static const String connectionErrorText = "connection error";
  static const String selectCategoryText = "Select Category";
  static const String accountSettingText = "Account Setting";
  static const String changePasswordText = "Change Password";
  static const String forgotPasswordText = "Forgot Password";
  static const String conditionErrorText = "condition error";
  static const String descriptionTitleText = "Description: ";
  static const String deleteAccountText = "Delete Account";
  static const String categoryErrorText = "category error";
  static const String notAvailableText = "Not Available";
  static const String emailAddressText = "Email Address";
  static const String conditionTitleText = "Condition: ";
  static const String categoryTitleText = "Category: ";
  static const String newPasswordText = "New Password";
  static const String oldPasswordText = "Old Password";
  static const String editProfileText = "Edit Profile";
  static const String phoneNumberText = "Phone Number";
  static const String descriptionText = "Description";
  static const String electronicsText = "Electronics";
  static const String relatedAdsText = "Related ads";
  static const String imageErrorText = "image error";
  static const String categoriesText = "Categories";
  static const String propertiesText = "Properties";
  static const String dateFormat = "MMMM dd, yyyy";
  static const String contactUsText = "Contact Us";
  static const String showLessText = "   showLess";
  static const String signupButtonText = "Signup?";
  static const String imagesExtensionText = ".jpg";
  static const String furnitureText = "Furniture";
  static const String conditionText = "Condition";
  static const String nameMessageSpaceText = ": ";
  static const String loginButtonText = "Login?";
  static const String userNameText = "User Name";
  static const String favoriteText = "Favorite";
  static const String showMoreText = "showMore";
  static const String passwordText = "Password";
  static const String categoryText = "Category";
  static const String vehiclesText = "Vehicles";
  static const String confirmText = "Confirm";
  static const String jewelryText = "Jewelry";
  static const String fashionText = "Fashion";
  static const String forYouText = "For you";
  static const String seeAllText = "See all";
  static const String hiWithLNText = "\nHi ";
  static const String cancelText = "Cancel";
  static const String searchText = "Search";
  static const String updateText = "Update";
  static const String logoutText = "Logout";
  static const String changeText = "Change";
  static const String deleteText = "Delete";
  static const String signupText = "Signup";
  static const String uploadText = "Upload";
  static const String imagesText = "Images";
  static const String healthText = "Health";
  static const String beautyText = "Beauty";
  static const String sportsText = "Sports";
  static const String systemText = "System";
  static const String underScoreText = "_";
  static const String timeFormat = "hh:mm";
  static const String numberZeroText = "0";
  static const String numberOneText = "1";
  static const String backSlashText = "/";
  static const String otherText = "Other";
  static const String loginText = "Login";
  static const String priceText = "Price";
  static const String titleText = "Title";
  static const String emailText = "Email";
  static const String infoText = "Info";
  static const String cityText = "City";
  static const String okayText = "Okay";
  static const String areaText = "Area";
  static const String moreText = "More";
  static const String telText = "tel: ";
  static const String usedText = "Used";
  static const String youText = "You: ";
  static const String sendText = "Send";
  static const String atSignText = "@";
  static const String spaceText = " ";
  static const String adsText = "Ads";
  static const String newText = "New";
  static const String emptyText = "";
  static const String hiText = "Hi ";
  static const String dotText = ".";

  // Lists
  static const List<String> categoriesList = [
    vehiclesText,
    propertiesText,
    electronicsText,
    fashionText,
    furnitureText,
    healthText,
    beautyText,
    sportsText,
    jewelryText,
    otherText,
  ];
  static const List categories = [
    {titleField: vehiclesText, iconField: Icons.directions_car_filled_rounded},
    {titleField: electronicsText, iconField: Icons.electric_bolt_rounded},
    {titleField: propertiesText, iconField: Icons.home_work_rounded},
    {titleField: fashionText, iconField: FontAwesomeIcons.tshirt},
    {titleField: furnitureText, iconField: Icons.chair_rounded},
    {titleField: healthText, iconField: Icons.health_and_safety_rounded},
    {titleField: beautyText, iconField: FontAwesomeIcons.glasses},
    {titleField: sportsText, iconField: Icons.motorcycle_rounded},
    {titleField: jewelryText, iconField: Icons.diamond_rounded},
    {titleField: otherText, iconField: Icons.devices_other_rounded},
  ];
}
