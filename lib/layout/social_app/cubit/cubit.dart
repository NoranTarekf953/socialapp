// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';

import 'package:udemy/shared/Constants/constants.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/chat_model.dart';
import '../../../models/create_user_model.dart';
import '../../../models/post_model.dart';
import '../../../modules/chats/chat_screen.dart';
import '../../../modules/feed/feed_screen.dart';
import '../../../modules/menu_screen/menu_screen.dart';
import '../../../modules/notifications/notifications_screen.dart';
import '../../../modules/users/users_screen.dart';
import '../../../shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(SocialSignOutSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialSignOutErrorState());
    });
  }

  CreateSocialUser? userModel;
  void getUser() {
    try {
      emit(SocialGetUserLoadingState());
      FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .get()
          .then((value) {
        print(value.data().toString());
        if (value.data() != null) {
          userModel = CreateSocialUser.fromjson(value.data());
          print(userModel!.name);
          emit(SocialGetUserSuccessState());
        }
      }).catchError((e) {
        print('error in get user ${e.toString()}');
        emit(SocialGetUserErrorState());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  int currentindex = 0;

  List<Widget> screens = [
    const FeedScreen(),
    const SocialChatScreen(),
    //AddPostScreen(),
    const UsersScreen(),
    const SocialNotificationScreen(),
    const MenuScreen()
  ];

  List<String> titles = ['Home', 'Chats', 'Add Post', 'Users', 'Settings'];
  void changeTabBar(index) {
    if (index == 3) {
      currentindex = 3;
      emit(SocialNotificationState());
    } else {
      currentindex = index;
      emit(SocialChangeNavState());
    }
  }

  bool isTapped = false;
  void menuListTap() {
    isTapped = !isTapped;
    print(true);
    emit(SocialTappedSuccessState());
  }

  String Language = 'en';

  bool isDark = false;

  void changeMood({bool? sharedpref}) {
    if (sharedpref != null) {
      isDark = sharedpref;
      emit(SocialChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(SocialChangeModeState());
      });
    }
  }

  File? profileImage;
  Future pickProfileImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picker != null) {
      profileImage = File(picker.path);
      print(picker.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future pickCoverImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picker != null) {
      coverImage = File(picker.path);
      print(picker.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        //عشان يبدا يدخل على ال فاير ستورج
        .ref()
        //يدخل جوا وهيسمي الصورة بايه وفي فايل ايه
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        //ابدا رفع الصورة
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(name: name, bio: bio, phone: phone, image: value);
      }).catchError((e) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateDataLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((e) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void updateUserData(
      {required String name,
      required String bio,
      required String phone,
      String? image,
      String? cover}) {
    //  emit(SocialUpdateDataLoadingState());
    CreateSocialUser createUser = CreateSocialUser(
        name: name,
        email: userModel!.email,
        phone: phone,
        uId: userModel!.uId,
        bio: bio,
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        isEmailVerfied: false);

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .update(createUser.toMap())
        .then(
      (value) {
        getUser();
        // emit(SocialUpdateDataSuccessState());
      },
    ).catchError((e) {
      emit(SocialUpdateDataErrorState());
      print('error in update ${e.toString()}');
    });
  }

//create post
  File? postImage;
  Future pickPostImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picker != null) {
      postImage = File(picker.path);
      print(picker.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({required String text, String dateTime = ''}) {
    emit(SocialUploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        //عشان يبدا يدخل على ال فاير ستورج
        .ref()
        //يدخل جوا وهيسمي الصورة بايه وفي فايل ايه
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        //ابدا رفع الصورة
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
            text: text, dateTime: DateTime.now().toString(), postImage: value);
      }).catchError((e) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  void createPost(
      {required String text,
       String dateTime = '',
        String postImage = ''}) {
    emit(SocialUploadPostImageLoadingState());

    PostModel postModel = PostModel(
      comments: 0,
      likes: 0,
      isLikedByMe: false,
        text: text,
        name: userModel!.name,
        uId: userModel!.uId,
        postImage: postImage,
        image: userModel!.image,
        dateTime: dateTimeFormat);

    FirebaseFirestore.instance.collection('Posts').add(postModel.toMap()).then(
      (value) {
        emit(SocialCreatePostSuccessState());
      },
    ).catchError((e) {
      emit(SocialCreatePostErrorState());
      print('error in update ${e.toString()}');
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
        postsId=[];
        posts=[];
       // likemodel =[];
      event.docs.forEach((element)async {
         postsId.add(element.id);
          posts.add(PostModel.fromjson(element.data()));
          var likes = await element.reference.collection('Likes').get();
          var comments = await element.reference.collection('Comments').get();
          bool LikedByMe = false;
           await element.reference.collection('Likes').get()
           .then((value){
            value.docs.forEach((element) {
              if(element.id == userModel!.uId) LikedByMe = true;
              else LikedByMe = false;
            });
           });

          await FirebaseFirestore.instance.collection('Posts').doc(element.id)
          .update({
            'likes':likes.docs.length,
            'comments':comments.docs.length,
            'isLikedByMe':LikedByMe
          
          });
          
         getLikes(postId: element.id);
        
        emit(SocialGetPostsSuccessState());
      });
    });
  }
bool isLiked =false;
   bool isLikedByme = false;
  void likePost(String postId) {
    try {
       LikeModel likeModel = LikeModel(
        name: userModel!.name,
        uId: userModel!.uId,
        userImage: userModel!.image,
        dateTime: FieldValue.serverTimestamp().toString());
         
          isLikedByme =!isLikedByme;
isLikedByme == true ?
   FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uId)
        .set(likeModel.toMap())
        .then((value) {
         // if(likeModel.uId==userModel!.uId) isLikedByme =true;
          getPosts();
      emit(SocialLikePostsSuccessState());
      
    }).catchError((e) {
      emit(SocialLikePostsErrorState());
    }):
    disLiked(postId: postId);
    } catch (e) {
      print(e.toString());
    }
   


   
  }
   void disLiked({required String postId}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uId)
        .delete()
        .then((value) {
      getPosts();
      print('DisLiked');
      emit(SocialDisLikePostsSuccessState());
    }).catchError((e) {
      emit(SocialDisLikePostsSuccessState());
    });
  }
    
    
    List<LikeModel> peolpleLikesModel = [];
    List<LikeModel> myLikes = [];
  void getLikes({required String postId}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      peolpleLikesModel.clear();
      myLikes.clear();
      event.docs.forEach((element) {
        peolpleLikesModel.add(LikeModel.fromjson(element.data()));
        if(element.id == userModel!.uId) {
          myLikes.add(LikeModel.fromjson(element.data()));
          printFullText('my likes ${myLikes.length}');
        }
//if(element.id == userModel!.uId) isLikedByme = true;
//else isLikedByme =false;
        emit(SocialGetLikesSuccessState());
      });
    });
  }
/*
  Future<bool> likedByMe({required String postId})async{

bool isLikedByMe = false;
FirebaseFirestore.instance
.collection('Posts')
.doc(postId)
.get()
.then((value) async{
var likes =await value.reference.collection('Likes').get();
likes.docs.forEach((element) {
  if(element.id == userModel!.uId){
    isLikedByMe = true;
    disLiked(postId: postId);
  }
});
if(isLikedByMe == false) {
  likePost(postId);
}
print(isLikedByMe);
      emit(SocialLikePostsSuccessState());

});
return isLikedByMe;
  }

 

 */

  //List<LikeModel> likemodel = [];
  /*void getLikes({required String postId}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      likemodel.clear();

      event.docs.forEach((element) {
        likemodel.add(LikeModel.fromjson(element.data()));
        
                  print(isLiked);


        // print(likemodel);
        emit(SocialGetCommentsSuccessState());
      });
    });
  }*/

  void AddComment(
      {required String postId,
      required String comment,
      String commentImage = '',
      required String date}) {
    CommentModel commentModel = CommentModel(
        commentImage: commentImage,
        name: userModel!.name,
        uId: userModel!.uId,
        comment: comment,
        userImage: userModel!.name,
        dateTime: dateTimeFormat);
    emit(SocialAddCommentLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .add(commentModel.toMap())
        .then((value) {
      getPosts();
      emit(SocialAddCommentSuccessState());
    }).catchError((e) {
      emit(SocialAddCommentErrorState());
    });
  }

  List<CommentModel> comments = [];
  void getComments({required String postId}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      comments.clear();
      event.docs.forEach((element) {
        comments.add(CommentModel.fromjson(element.data()));

       // print(comments);
        emit(SocialGetCommentsSuccessState());
      });
    });
  }

  File? commentImage;
  Future pickCommentImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picker != null) {
      commentImage = File(picker.path);
      print(picker.path);
      emit(SocialCommentImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCommentImagePickedErrorState());
    }
  }

  void uploadCommentImage({required String text, required String postId}) {
    emit(SocialUploadCommentImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        //عشان يبدا يدخل على ال فاير ستورج
        .ref()
        //يدخل جوا وهيسمي الصورة بايه وفي فايل ايه
        .child(
            'commentsImage/${Uri.file(commentImage!.path).pathSegments.last}')
        //ابدا رفع الصورة
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
       // print(value);
        AddComment(
            postId: postId,
            date: dateTimeFormat,
            comment: text,
            commentImage: value);
      }).catchError((e) {
        emit(SocialUploadCommentImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadCommentImageErrorState());
    });
  }

  void removeCommentImage() {
    commentImage = null;
    emit(SocialRemoveCommentImageSuccessState());
  }

  List<CreateSocialUser> users = [];

  void GetAllUsers() {
    users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        if (element.id != userModel!.uId) {
          users.add(CreateSocialUser.fromjson(element.data()));
        }
        emit(SocialGetAllUsersSuccessState());
      });
    }).catchError((e) {
      print(e.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }

  void sendChat(
      {required String text,
      required String recieverId,
      required String dateTime}) {
    MessageModel model = MessageModel(
        senderId: userModel!.uId,
        recieverId: recieverId,
        text: text,
        dateTime: dateTime);
    //set to my chats
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('Chats')
        .doc(recieverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendChatSuccessState());
    }).catchError((e) {
      emit(SocialSendChatErrorState());
    });
//set to reciever chat
    FirebaseFirestore.instance
        .collection('Users')
        .doc(recieverId)
        .collection('Chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendChatSuccessState());
    }).catchError((e) {
      emit(SocialSendChatErrorState());
    });
  }

  List<MessageModel> messages = [];
  void GetMessages({required String recieverId}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('Chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages.clear();
      event.docs.forEach((element) {
        messages.add(MessageModel.fromjson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}
