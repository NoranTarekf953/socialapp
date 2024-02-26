import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/Social_screen.dart';
import 'package:udemy/modules/social_register/cubit/cubit.dart';
import 'package:udemy/modules/social_register/cubit/states.dart';
import 'package:udemy/shared/components/component.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/components/customized_form.dart';
import '../../../shared/styles/colors.dart';

class SocialRegisterScreen extends StatelessWidget {
   SocialRegisterScreen({super.key});
  final emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
    final nameController = TextEditingController();
      final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
      if(state is SocialCreateUserSuccessStates){
        CacheHelper.saveData
        (key: 'uId',
        value: state.uId).then((value){
          uId = state.uId;
        navigateAndFinish(context,  SocialScreen(0));

        });
      }
        },
        builder: (context, state) => Scaffold(
          appBar:defaultAppBar(context: context),
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
                          'Register',
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
                          labelText: 'name',
                          prefixIcon: Icons.person,
                          textType: TextInputType.text,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          controller: nameController),
                      const SizedBox(
                        height: 20,
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
                          suffixIcon: SocialRegisterCubit.get(context).suffix,
                          
                          onTapSuffix: () {
                            SocialRegisterCubit.get(context).changePasswordVisible();
                          },
                          secure: SocialRegisterCubit.get(context).isPassword,
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
                     
                      RoundedFormField(
                          labelText: 'phone',
                          prefixIcon: Icons.phone,
                          textType: TextInputType.phone,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          controller: phoneController),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          condition: state is !SocialRegisterLoadingStates ,
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
                                    SocialRegisterCubit.get(context).registerUser(
                                     name: nameController.text,
                                      email:  emailController.text,
                                      password:  passwordController.text,                           
                                      phone:  phoneController.text,
                                     );
                                  }
                                },
                                child: Text(
                                  'Register ',
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
                      ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}