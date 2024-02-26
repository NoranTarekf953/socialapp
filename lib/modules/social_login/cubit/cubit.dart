// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:udemy/modules/social_login/cubit/states.dart';
import 'package:udemy/shared/components/component.dart';

import '../../../models/create_user_model.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void loginUser({
    required String email,
    required String password,
    required BuildContext context}) {
          String errorMessage ='';

    try {
       emit(SocialLoginLoadingStates());
     FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        
        .then((value) {
      print(value.user!.email);

      emit(SocialLoginSuccessStates(uId: value.user!.uid));
    });
    } on FirebaseAuthException catch(e){
      if(e.code == 'invalid-email')errorMessage =  'invalid-email';
      else if(e.code == 'user-disabled')errorMessage = 'user-disabled';
      else if(e.code == 'user-not-found')errorMessage = 'user-not-found';
      else if(e.code == 'wrong-password')flutterToast(msg: 'invalid-email', state: ToastState.error,context: context);
      else errorMessage = 'undefined error';


      print(e.code);
      emit(SocialLoginErrorStates(error: errorMessage));
    }catch(e){
      print(e);
    }
    
   
  }

  bool userExist = false;
  Future<void> isUserExist({
    required String? uId,
    required String? name,
    required String? phone,
    required String? email,
    required String? image,
  }) async {
    try {
       FirebaseFirestore.instance.collection('Usere').get().then((value) {
      value.docs.forEach((element) {
        if (element.id == uId) userExist = true;
      });
      if (userExist == false) {
        createGoogleUser(
            uId: uId, email: email, name: name, phone: phone, image: image);
      } else {
        print(userExist);
        emit(SocialLoginWithGoogleSuccessStates(uId: uId!));
      }
    });
    } catch (e) {
      print(e.toString());
    }
   
  }

  void createGoogleUser({
    required String? uId,
    required String? email,
    required String? name,
    required String? phone,
    required String? image,
  }) {
    CreateSocialUser user = CreateSocialUser(
        name: name!,
        email: email!,
        phone: phone!,
        uId: uId!,
        isEmailVerfied: false,
        image: image ??
            'https://firebasestorage.googleapis.com/v0/b/udemyflutter-ab256.appspot.com/o/users%2FTheRiveter_AmyNelsonHeadshot_CreditChad-Peltola.jpg?alt=media&token=6f9f1b54-aa07-4481-91af-a73f7fc5b427',
        cover:
            'https://img.freepik.com/free-photo/medium-shot-girl-influencer-marketing_23-2150521905.jpg?t=st=1704192098~exp=1704192698~hmac=220634a520d6b9a0bb534a50b817a35fbd112d6475a9160b79694b116e398871',
        bio: 'write your bio');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(user.toMap())
        .then((value) {
          print(user.uId);
      emit(SocialCreateUserGoogleSuccessStates(uId: uId));
    }).catchError((e) {
      emit(SocialCreateUserGoogleErrorStates());
    });
  }

void loginWithGoogle() async {
  
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
print(credential.token);
  // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
    isUserExist(
      uId: value.user!.uid,
       name: value.user!.displayName,
        phone: value.user!.phoneNumber,
         email: value.user!.email,
          image: value.user!.photoURL);
   });
}
  /*Future<UserCredential>? loginWithGoogle() async {
    try {
       emit(SocialLoginWithGoogleLoadingStates());

     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
     GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);

    
    //print(user.user?.displayName);
     /*.then((value) {
      isUserExist(
          uId: value.user!.uid,
          name: value.user!.displayName,
          phone: value.user!.phoneNumber,
          email: value.user!.email,
          image: value.user!.photoURL);
     // emit(SocialLoginWithGoogleSuccessStates(uId:value.user!.uid));
    }).catchError((e) {
      print(e.toString());
      emit(SocialLoginWithGoogleErrorStates());
    });*/
    } catch (e) {
      print(e.toString());
    }
   
  }
*/
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisible() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisible());
  }
}
