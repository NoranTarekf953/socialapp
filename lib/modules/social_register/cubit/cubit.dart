// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/social_register/cubit/states.dart';

import '../../../models/create_user_model.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,

    }) {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword
    (email: email, password: password)
        .then((value) {
          print(value.user!.email);
          userCreate(
            name: name,
           email: email,
            phone: phone,
            uId: value.user!.uid,
            );

    }).catchError((error) {
      print('error in RegisterUser ${error.toString()}');
      emit(SocialRegisterErrorStates());
    });
  }


void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,


    }){
CreateSocialUser createUser = CreateSocialUser(
  name: name,
   email: email,
    phone: phone,
     uId: uId,
     bio: 'write a Bio ...',
     image: 'https://img.freepik.com/free-photo/close-up-portrait-cheerful-glamour-girl-with-cute-make-up-smiling-white-teeth-looking-happy-camera-standing-blue-background_1258-70300.jpg?w=996&t=st=1704043274~exp=1704043874~hmac=a913fb87ad55b6c248e5266dfd0132fe6979340ddf4f6c5000c36a00edfbd658',
     cover: 'https://img.freepik.com/free-photo/medium-shot-girl-influencer-marketing_23-2150521905.jpg?t=st=1704192098~exp=1704192698~hmac=220634a520d6b9a0bb534a50b817a35fbd112d6475a9160b79694b116e398871',
     isEmailVerfied: false
     );

      FirebaseFirestore.instance
      .collection('Users')
      .doc(uId)
      .set(createUser.toMap())
      .then((value){
        print(createUser.uId);
        emit(SocialCreateUserSuccessStates( uId: createUser.uId??''));
      }).catchError((e){
        print('error in create user ${e.toString()}');
        emit(SocialCreateUserErrorStates());
      });

}
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisible() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisible());
  }
}
