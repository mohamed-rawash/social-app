import 'package:social_app/view_model/cubits/home_cubit.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetUserFromFireStoreLoadingState extends HomeStates {}
class GetUserFromFireStoreSuccessState extends HomeStates {}
class GetUserFromFireStoreErrorState extends HomeStates {
  final String error;

  GetUserFromFireStoreErrorState({required this.error});
}

class ChangeBottomNavBarState extends HomeStates {}

class NewPostNavigationState extends HomeStates {}

class PickedUserImageSuccessState extends HomeStates {}
class PickedUserImageErrorState extends HomeStates {
  final String message;

  PickedUserImageErrorState(this.message);
}
class PickedUserCoverSuccessState extends HomeStates {}
class PickedUserCoverErrorState extends HomeStates {
  final String message;

  PickedUserCoverErrorState(this.message);
}

class UploadProfilePicLoadingState extends HomeStates {}
class UploadProfilePicSuccessState extends HomeStates {}
class UploadProfilePicErrorState extends HomeStates {
  final String message;

  UploadProfilePicErrorState(this.message);
}

class UploadProfileCoverLoadingState extends HomeStates {}
class UploadProfileCoverSuccessState extends HomeStates {}
class UploadProfileCoverErrorState extends HomeStates {
  final String message;

  UploadProfileCoverErrorState(this.message);
}

class UpdateUserDataLoadingState extends HomeStates {}
class UpdateUserDataSuccessState extends HomeStates {}
class UpdateUserDataErrorState extends HomeStates {
  final String message;

  UpdateUserDataErrorState(this.message);
}

class PickedPostImageSuccessState extends HomeStates {}
class PickedPostImageErrorState extends HomeStates {
  final String message;

  PickedPostImageErrorState(this.message);
}

class UploadPostImageSuccessState extends HomeStates {}
class UploadPostImageErrorState extends HomeStates {
  final String message;

  UploadPostImageErrorState(this.message);
}

class CreateNewPostLoadingState extends HomeStates {}
class CreateNewPostSuccessState extends HomeStates {
  bool isSuccess = false;

  CreateNewPostSuccessState(this.isSuccess);
}
class CreateNewPostErrorState extends HomeStates {
   String message;

  CreateNewPostErrorState(this.message);
}

class RemovePostPhotoState extends HomeStates {}


class GetNewsFeedPostsLoadingState extends HomeStates {}
class GetNewsFeedPostsSuccessState extends HomeStates {}
class GetNewsFeedPostsErrorState extends HomeStates {
  final String message;

  GetNewsFeedPostsErrorState(this.message);
}

class GetUserPostsLoadingState extends HomeStates {}
class GetUserPostsSuccessState extends HomeStates {}
class GetUserPostsErrorState extends HomeStates {
  final String message;

  GetUserPostsErrorState(this.message);
}

class PostLikeSuccessState extends HomeStates {}
class PostLikeErrorState extends HomeStates {
  final String message;

  PostLikeErrorState(this.message);
}

class PostDisLikeSuccessState extends HomeStates {}
class PostDisLikeErrorState extends HomeStates {
  final String message;

  PostDisLikeErrorState(this.message);
}

class GetPostLikeCountState extends HomeStates {}

class ChangeLikeStatusState extends HomeStates {}

class GetPostsLikedState extends HomeStates {}

class GetAllUserLoadingState extends HomeStates {}
class GetAllUserSuccessState extends HomeStates {}
class GetAllUserErrorState extends HomeStates {
  final String message;

  GetAllUserErrorState(this.message);
}

class AddCommentLoadingState extends HomeStates {}
class AddCommentSuccessState extends HomeStates {}
class AddCommentErrorState extends HomeStates {
  final String message;

  AddCommentErrorState(this.message);
}

class ShowSendButtonStatusState extends HomeStates {}

class SendMessageSuccessState extends HomeStates {}
class SendMessageErrorState extends HomeStates {}
class GetMessageSuccessState extends HomeStates {}
class GetMessageErrorState extends HomeStates {}