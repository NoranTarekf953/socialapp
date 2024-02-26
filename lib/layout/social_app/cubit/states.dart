abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialSignOutSuccessState extends SocialStates {}

class SocialSignOutErrorState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {
  String? uId;
  SocialGetUserSuccessState({this.uId});
}

class SocialGetUserErrorState extends SocialStates {}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {}

class SocialChangeNavState extends SocialStates {}
class SocialNotificationState extends SocialStates {}


class SocialAddPostState extends SocialStates {}

class SocialTappedSuccessState extends SocialStates {}

class SocialChangeModeState extends SocialStates {}


class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUpdateDataLoadingState extends SocialStates {}

class SocialUpdateDataSuccessState extends SocialStates {}

class SocialUpdateDataErrorState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

//create post

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialUploadPostImageLoadingState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialRemovePostImageSuccessState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {}

//Likes
class SocialLikePostsSuccessState extends SocialStates {}

class SocialLikePostsErrorState extends SocialStates {}

class SocialDisLikePostsSuccessState extends SocialStates {}

class SocialDisLikePostsErrorState extends SocialStates {}
//Comments
class SocialAddCommentLoadingState extends SocialStates {}

class SocialAddCommentSuccessState extends SocialStates {}

class SocialAddCommentErrorState extends SocialStates {}

class SocialGetCommentsSuccessState extends SocialStates {}

class SocialGetLikesLoadingState extends SocialStates {}

class SocialGetLikesSuccessState extends SocialStates {}

class SocialCommentImagePickedSuccessState extends SocialStates {}

class SocialCommentImagePickedErrorState extends SocialStates {}

class SocialUploadCommentImageLoadingState extends SocialStates {}

class SocialUploadCommentImageErrorState extends SocialStates {}
class SocialRemoveCommentImageSuccessState extends SocialStates {}

//chats
class SocialSendChatSuccessState extends SocialStates {}

class SocialSendChatErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}
