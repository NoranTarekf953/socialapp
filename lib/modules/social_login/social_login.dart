// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/Social_screen.dart';
import 'package:udemy/modules/social_login/cubit/cubit.dart';
import 'package:udemy/modules/social_login/cubit/states.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';

import '../../../shared/Constants/constants.dart';
import '../../../shared/components/customized_form.dart';
import '../../shared/components/component.dart';
import '../../../shared/styles/colors.dart';
import '../social_register/social_register.dart';

class SocialLogInScreen extends StatelessWidget {
   SocialLogInScreen({super.key});
 final emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorStates) {
            // عشان الستاتس  حتى لو غلط ومش متسجل مش هيعتبره ايرور
            //فلازم اتاكد من الstatus
            //اللي جوا الريسبونس بتاعي
              flutterToast(
                  msg: state.error,
                  context: context,
                  state: ToastState.error);
            
          }
          if(state is SocialLoginSuccessStates ) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId
            ).then((value) {
              uId=state.uId;
            navigateAndFinish(context,  SocialScreen(0));

            }).catchError((e){
              print(e.toString());});
          }
           if(state is SocialLoginWithGoogleSuccessStates ) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId
            ).then((value) {
              uId=state.uId;
            navigateAndFinish(context,  SocialScreen(0));
                        //SocialCubit.get(context).getUser();


            }).catchError((e){
              print(e.toString());});
          } 
           if(state is SocialCreateUserGoogleSuccessStates ) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId
            ).then((value) {
              uId=state.uId;
            navigateAndFinish(context,  SocialScreen(0));
            //SocialCubit.get(context).getUser();

            }).catchError((e){
              print(e.toString());});
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: Container(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Log In',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: defaultColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 55),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundedFormField(
                          labelText: 'e-mail',
                          prefixIcon: Icons.email,
                          textType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          controller: emailController),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundedFormField(
                          labelText: 'password',
                          prefixIcon: Icons.password,
                          textType: TextInputType.text,
                          suffixIcon: SocialLoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formkey.currentState!.validate()) {

                              SocialLoginCubit.get(context).loginUser(
                                context: context,
                                 email: emailController.text,
                                password: passwordController.text);
                            }
                          },
                          onTapSuffix: () {
                            SocialLoginCubit.get(context).changePasswordVisible();
                          },
                          secure: SocialLoginCubit.get(context).isPassword,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          controller: passwordController),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          condition: state is! SocialLoginLoadingStates,
                          builder: (context) => Container(
                              padding: const EdgeInsetsDirectional.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  color: Colors.deepPurple[400]),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).loginUser(
                                      context: context,
                                      email: emailController.text,
                                      password:passwordController.text);
                                  }
                                },
                                child: Text(
                                  'Log In ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                          fallback: (context) => Center(
                                child: CircularProgressIndicator(
                                    color: defaultColor),
                              )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You don\'t have an account ? ',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[600]),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, SocialRegisterScreen());
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                          
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          SocialLoginCubit.get(context).loginWithGoogle();
                        },
                        child:  const CircleAvatar(
                          
                          backgroundColor: Colors.white,
                              backgroundImage: AssetImage('assets/images/Google_Logo.png'),
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  
  }}