// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/view_model/states/home_states.dart';
import 'package:social_app/views/chat_screen.dart';
import 'package:social_app/views/home_screen.dart';
import 'package:social_app/views/setting_Screen.dart';
import 'package:social_app/views/user_screen.dart';

import '../../models/user_model.dart';
import '../services/fire_store_service.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  int currentIndex = 0;
  int currentScreen = 0;

  List<Widget> screens = [
    HomeScreen(),
    const ChatScreen(),
    const UserScreen(),
    const SettingScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  final _imagePicker = ImagePicker();

  File? profileImage;
  File? profileCover;

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  String profilePicUrl = '';
  String profileCoverUrl = '';

  File? postImage;
  TextEditingController postText = TextEditingController();

  List<PostModel> newsFeedPosts = [];
  List<PostModel> userPosts = [];

  bool isLike = false;
  List<int> postLikesCount = [];
  List<bool> postISLiked = [];

  List<UserModel> allUsers = [];

  TextEditingController commentController = TextEditingController();
  bool isComment = false;

  bool isMessageEmpty = true;
  TextEditingController messageController = TextEditingController();

  changeBottomNavBar(int index) {
    if (index == 1) getAllUsers();
    if (index == 2) {
      emit(NewPostNavigationState());
    } else {
      if (index > 2) {
        currentScreen = index - 1;
      } else {
        currentScreen = index;
      }
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  Future<void> getUserFromFireStore({required String uid}) async {
    emit(GetUserFromFireStoreLoadingState());
    try {
      DocumentSnapshot<Object?> _userInfo =
      await Firestore().getUserFromFireStore(uid);
      userModel = UserModel.fromJson(_userInfo.data() as Map<String, dynamic>);
      emit(GetUserFromFireStoreSuccessState());
    } on FirebaseAuthException catch (error) {
      emit(GetUserFromFireStoreErrorState(error: error.message!));
    }
  }

  Future<void> pickProfileImage() async {
    final pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(PickedUserImageSuccessState());
    } else {
      String message = "You didn't chose any pic";
      print(message);
      emit(PickedUserImageErrorState(message));
    }
  }

  Future<void> pickProfileCover() async {
    final pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileCover = File(pickedImage.path);
      emit(PickedUserCoverSuccessState());
    } else {
      String message = "You didn't chose any pic";
      print(message);
      emit(PickedUserCoverErrorState(message));
    }
  }

  uploadProfileImageToFireStorage() async {
    emit(UploadProfilePicLoadingState());
    Reference _ref = FirebaseStorage.instance
        .ref()
        .child("users/${FirebaseAuth.instance.currentUser!.uid}/profilePic");
    try {
      await _ref.putFile(profileImage!);
      profilePicUrl = await _ref.getDownloadURL();
      print("*-* " * 10);
      print(profilePicUrl);
      print("*-* " * 10);
      emit(UploadProfilePicSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadProfilePicErrorState(error.message!));
    }
  }

  uploadProfileCoverToFireStorage() async {
    emit(UploadProfileCoverLoadingState());
    Reference _ref = FirebaseStorage.instance
        .ref()
        .child("users/${FirebaseAuth.instance.currentUser!.uid}/profileCover");
    try {
      await _ref.putFile(profileCover!);
      profileCoverUrl = await _ref.getDownloadURL();
      print("*-* " * 10);
      print(profileCoverUrl);
      print("*-* " * 10);
      emit(UploadProfileCoverSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadProfileCoverErrorState(error.message!));
    }
  }

  updateUserData() async {
    emit(UpdateUserDataLoadingState());
    try {
      UserModel _userModel = UserModel(
          id: userModel!.id,
          email: userModel!.email,
          name: nameController.text,
          phone: userModel!.phone,
          image: profilePicUrl.isEmpty ? userModel!.image : profilePicUrl,
          coverImage:
          profileCoverUrl.isEmpty ? userModel!.coverImage : profileCoverUrl,
          bio: bioController.text);

      await Firestore().updateUser(
          uId: FirebaseAuth.instance.currentUser!.uid,
          userData: _userModel.toJson());
      await getUserFromFireStore(uid: FirebaseAuth.instance.currentUser!.uid);

      emit(UpdateUserDataSuccessState());
    } catch (error) {
      print(error);
      emit(UpdateUserDataErrorState(error.toString()));
    }
  }

  pickedPostImage() async {
    final pickedImage =
    await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(PickedPostImageSuccessState());
    } else {
      String message = "You didn't chose any pic";
      emit(PickedPostImageErrorState(message));
    }
  }

  removePostImage() {
    postImage = null;
    emit(RemovePostPhotoState());
  }

  String getRandomString(int length) {
    String chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  createNewPost() async {
    emit(CreateNewPostLoadingState());
    String postId = getRandomString(60);
    String? postImageUrl;
    if (postImage != null) {
      Reference ref =
      FirebaseStorage.instance.ref().child("posts_media/$postId");
      try {
        await ref.putFile(postImage!);
        postImageUrl = await ref.getDownloadURL();

        emit(UploadPostImageSuccessState());
      } on FirebaseException catch (error) {
        print("-* " * 10);
        print(error.message);
        print("-* " * 10);
        emit(UploadPostImageErrorState(error.message!));
      }
    }

    PostModel postModel = PostModel(
      id: userModel!.id,
      postId: postId,
      name: userModel!.name,
      image: userModel!.image,
      dateTime: DateTime.now().toString(),
      text: postText.text,
      postImage: postImageUrl ?? '',
    );

    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .set(postModel.toJson());
      emit(CreateNewPostSuccessState(true));
    } on FirebaseException catch (error) {
      emit(CreateNewPostErrorState(error.toString()));
    }
  }

  getNewsFeedPosts() async {
    newsFeedPosts.clear();
    emit(GetNewsFeedPostsLoadingState());
    try {
      QuerySnapshot<Map<String, dynamic>> posts =
      await FirebaseFirestore.instance.collection("posts").get();
      for (var element in posts.docs) {
        element.reference.collection("likes").get().then((value) =>
        {
          postLikesCount.add(value.docs.length),
          newsFeedPosts.add(PostModel.fromJson(element.data())),
        });
      }
      emit(GetNewsFeedPostsSuccessState());
    } on FirebaseException catch (error) {
      emit(GetNewsFeedPostsErrorState(error.message!));
    }
  }

  getUserPosts() async {
    emit(GetUserPostsLoadingState());
    try {
      QuerySnapshot<Map<String, dynamic>> posts = await FirebaseFirestore
          .instance
          .collection("posts")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      for (var element in posts.docs) {
        userPosts.add(PostModel.fromJson(element.data()));
      }
      emit(GetUserPostsSuccessState());
    } on FirebaseException catch (error) {
      emit(GetUserPostsErrorState(error.message!));
    }
  }

  likePost({required postID, required int index}) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postID)
          .collection("likes")
          .doc(userModel!.id)
          .set({"is_like": true, "uId": userModel!.id});
      await updateLikeCount(postID: postID, index: index);
      emit(PostLikeSuccessState());
    } on FirebaseException catch (error) {
      emit(PostLikeErrorState(error.message!));
    }
  }

  disLikePost({required postID, required int index}) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postID)
          .collection("likes")
          .doc(userModel!.id)
          .delete();
      await updateLikeCount(postID: postID, index: index);
      emit(PostDisLikeSuccessState());
    } on FirebaseException catch (error) {
      emit(PostDisLikeErrorState(error.message!));
    }
  }

  updateLikeCount({required postID, required int index}) async {
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postID)
        .collection("likes")
        .get()
        .then((value) => {postLikesCount[index] = value.docs.length});
  }

  getPostsLiked() async {
    QuerySnapshot<Map<String, dynamic>> posts =
    await FirebaseFirestore.instance.collection("posts").get();

    for (var element in posts.docs) {
      List usersLiked = [];
      QuerySnapshot<Map<String, dynamic>> likes =
      await element.reference.collection("likes").get();
      for (var element in likes.docs) {
        usersLiked.add(element.reference.id);
      }
      print(usersLiked);
      if (usersLiked.contains(userModel!.id)) {
        postISLiked.add(true);
        print("true");
      } else {
        postISLiked.add(false);
      }
    }
    emit(GetPostsLikedState());
  }

  changeLikeStatus({required int index}) {
    postISLiked[index] = !postISLiked[index];
    emit(ChangeLikeStatusState());
  }

  addComment({required String postId}) async {
    emit(AddCommentLoadingState());
    String commentId = getRandomString(100);
    Comment comment = Comment(
      uId: userModel!.id,
      uName: userModel!.name,
      uImage: userModel!.image,
      postId: postId,
      commentId: commentId,
      commentText: commentController.text,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comment")
        .doc(commentId)
        .set(comment.toJson())
        .then((value) {
      emit(AddCommentSuccessState());
    }).catchError((FirebaseException error) {
      emit(AddCommentErrorState(error.message!));
    });
  }

  getAllUsers() async {
    emit(GetAllUserLoadingState());
    allUsers = [];
    try {
      QuerySnapshot<Map<String, dynamic>> users =
      await FirebaseFirestore.instance.collection('users').get();
      for (var element in users.docs) {
        if (element.data()['id'] != userModel!.id)
          allUsers.add(UserModel.fromJson(element.data()));
      }
      emit(GetAllUserSuccessState());
    } on FirebaseException catch (error) {
      emit(GetAllUserErrorState(error.message!));
    }
  }

  showSendButton() {
    if (messageController.text.isNotEmpty) {
      isMessageEmpty = true;
    } else {
      isMessageEmpty = false;
    }
    emit(ShowSendButtonStatusState());
  }

  sendMessage({required String receiverId}) {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.id,
      receiverId: receiverId,
      message: messageController.text,
      time: DateTime.now().toString(),
    );
    //Set My Chat
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.id)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) => emit(SendMessageErrorState()));

    //Set Receiver Chat
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(userModel!.id)
        .collection("messages")
        .add(messageModel.toJson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) => emit(SendMessageErrorState()));
  }

  List<MessageModel> messages = [];

  getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.id)
        .collection("chats")
        .doc(receiverId)
        .collection("messages").orderBy("time").snapshots().listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessageSuccessState());
    });
  }
}
