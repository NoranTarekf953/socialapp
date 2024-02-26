import 'package:flutter/material.dart';
import 'package:udemy/modules/social_login/social_login.dart';
import 'package:udemy/shared/Constants/constants.dart';
import 'package:udemy/shared/components/component.dart';
import 'package:udemy/shared/styles/colors.dart';

import 'social_register/social_register.dart';

class SocialOnBoarding extends StatelessWidget {
  const SocialOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        SizedBox(
          height: SizeScreen.height(context),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                
                'assets/images/Social_OnBoarding.jpg',fit: BoxFit.fitHeight,
                height: double.infinity,),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaterialButton(
                      onPressed: (){
                        navigateTo(context, SocialLogInScreen());
                      },
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                       child:  Text('SignIn',

                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: defaultColor,fontWeight: FontWeight.w500),)
                       ),
                       const SizedBox(height: 20,),
                         MaterialButton(
                      onPressed: (){
                        navigateTo(context, SocialRegisterScreen());
                      },
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                       child:  Text('SignUp',

                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: defaultColor,fontWeight: FontWeight.w500),)
                       ),              ],
              ),
            )
            ],
          ),
        ),
      ],
    )
    );
  }
}