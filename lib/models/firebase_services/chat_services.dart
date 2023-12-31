import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/nav_bar_controller.dart';
import 'package:com.rado.quick_mart/models/chat_message_model.dart';
import 'package:com.rado.quick_mart/models/chat_model.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatService {
  static NavBarController navBarController = Get.find();
  static String currentUserEmail = AppStrings.currentUserEmail;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference userCollection = firestore.collection(AppStrings.usersCollection);
  static CollectionReference chatRoomsCollection = firestore.collection(AppStrings.chatRoomsField);

  /// This function to create a new chat room.
  static Future<void> createChatRooms(PostsModel post) async {
    List<String> ids = [AppStrings.currentUserEmail, post.userEmail];
    ids.sort();
    String chatRoomId = ids.join(AppStrings.underScoreText);
    DocumentReference chatRoomDocument = chatRoomsCollection.doc(chatRoomId);

    try {
      bool chatRoomExists = await chatRoomDocument.get().then((doc) => doc.exists);

      /// Check if the chat room is not exited to create a new room with the default message from the system.
      if (!chatRoomExists) {
        Map<String, dynamic> chatRoomData = {
          AppStrings.imagesField: [navBarController.user.value.profileImage.value, post.userImage],
          AppStrings.namesField: [navBarController.user.value.name.value, post.userName],
          AppStrings.emailsField: [currentUserEmail, post.userEmail],
          AppStrings.timestampField: FieldValue.serverTimestamp(),
        };

        /// Add new chat room id to the current user collection.
        await userCollection.doc(AppStrings.currentUserEmail).set(
          {
            AppStrings.chatRoomIdsField: FieldValue.arrayUnion([chatRoomId])
          },
          SetOptions(merge: true),
        );

        /// Add new chat room id to the receiver user collection.
        await userCollection.doc(post.userEmail).set(
          {
            AppStrings.chatRoomIdsField: FieldValue.arrayUnion([chatRoomId])
          },
          SetOptions(merge: true),
        );
        await chatRoomDocument.set(chatRoomData);
        CollectionReference messagesCollection = chatRoomDocument.collection(AppStrings.messagesCollection);
        bool hasMessages = await messagesCollection.limit(1).get().then((querySnapshot) => querySnapshot.docs.isNotEmpty);
        if (!hasMessages) {
          await messagesCollection.doc(AppStrings.systemText).set(
            {
              AppStrings.isSeenField: true,
              AppStrings.senderEmailField: AppStrings.appTitle,
              AppStrings.messageField: AppStrings.firstChatMessageText,
              AppStrings.timestampField: FieldValue.serverTimestamp(),
            },
          ).then(
            (value) => messagesCollection.doc().set(
              {
                AppStrings.isSeenField: false,
                AppStrings.senderEmailField: currentUserEmail,
                AppStrings.messageField: post.title + AppStrings.hiWithLNText + post.userName + AppStrings.isItemAvailableText,
                AppStrings.timestampField: FieldValue.serverTimestamp(),
              },
            ),
          );
        }
      }
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorCreatingNewChatToast + e.toString());
    }
  }

  /// This function to fetch all the current user chat rooms.
  static Stream<List<ChatModel>> fetchCurrentUserChatRoomsInStream() {
    try {
      return chatRoomsCollection.where(AppStrings.emailsField, arrayContains: currentUserEmail).orderBy(AppStrings.timestampField, descending: true).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<ChatModel> chatRooms = querySnapshot.docs.map(
            (DocumentSnapshot document) {
              return ChatModel.fromFirestore(document);
            },
          ).toList();
          return chatRooms;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to send new message.
  static Future<void> sendNewMessage(String chatRoomId, String message) async {
    CollectionReference messagesCollection = chatRoomsCollection.doc(chatRoomId).collection(AppStrings.messagesCollection);
    FieldValue timestamp = FieldValue.serverTimestamp();
    try {
      /// Add new message.
      await messagesCollection.add(
        {
          AppStrings.senderEmailField: currentUserEmail,
          AppStrings.messageField: message,
          AppStrings.timestampField: timestamp,
          AppStrings.isSeenField: false,
        },
      );

      /// Update chat room with the timestampField of the last message.
      await chatRoomsCollection.doc(chatRoomId).update(
        {
          AppStrings.timestampField: timestamp,
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorUploadingToast + e.toString());
    }
  }

  /// This function to fetch all the current user chat room messages.
  static Stream<List<ChatMessageModel>> fetchChatRoomMessagesInStream(String chatRoomId) {
    CollectionReference messagesCollection = chatRoomsCollection.doc(chatRoomId).collection(AppStrings.messagesCollection);
    try {
      return messagesCollection.orderBy(AppStrings.timestampField, descending: true).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<ChatMessageModel> messages = querySnapshot.docs.map(
            (DocumentSnapshot document) {
              Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
              return ChatMessageModel(
                key: document.id,
                senderEmail: data?[AppStrings.senderEmailField] ?? AppStrings.emptyText,
                message: data?[AppStrings.messageField] ?? AppStrings.emptyText,
                isSeen: data?[AppStrings.isSeenField] ?? false,
                timestamp: data?[AppStrings.timestampField] ?? Timestamp.now(),
              );
            },
          ).toList();
          return messages;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to fetch chat room by the room id.
  static Future<ChatModel?> fetchChatRoomById(String chatRoomId) async {
    DocumentSnapshot chatSnapshot = await chatRoomsCollection.doc(chatRoomId).get();
    try {
      /// Check if the chat room is exist then return the chat room.
      if (chatSnapshot.exists) {
        return ChatModel.fromFirestore(chatSnapshot);
      } else {
        return null;
      }
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return null;
    }
  }

  /// This function to mark the new messages as seen.
  static Future<void> markMessageAsSeen(String chatRoomId, ChatMessageModel lastMessage) async {
    try {
      /// Get the reference to the specific message.
      DocumentReference messageRef = chatRoomsCollection.doc(chatRoomId).collection(AppStrings.messagesCollection).doc(lastMessage.key);

      /// Update isSeen field to true.
      lastMessage.senderEmail != currentUserEmail ? await messageRef.update({AppStrings.isSeenField: true}) : null;
    } catch (e) {
      debugPrint(AppStrings.errorFetchingToast + e.toString());
    }
  }
}
