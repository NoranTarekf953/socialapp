import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/customized_form.dart';
import 'package:udemy/shared/components/component.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

import '../../../shared/Constants/constants.dart';
import '../edit_profile/edit_profile_screen.dart';

class PersonalAccountScreen extends StatelessWidget {
  const PersonalAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
      var model = SocialCubit.get(context).userModel;

        
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            ),
          body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: SizeScreen.height(context)*0.3,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: SizeScreen.height(context) * 0.24,
                          width: double.infinity,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    model!.cover??''),
                              )),
                        ),
                      ),
                      CircleAvatar(
                        radius: SizeScreen.width(context)*0.16,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: SizeScreen.width(context) * 0.15,
                          backgroundImage: NetworkImage(
                            model.image??'',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                Text(model.name??'',
                style: Theme.of(context).textTheme.bodyMedium,),
                Text(model.bio??'',
                style: Theme.of(context).textTheme.bodySmall,),
                const SizedBox(height: 10,),
            
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('100',
                        style: Theme.of(context).textTheme.bodyMedium,),
                        Text('Posts',
                        style: Theme.of(context).textTheme.bodySmall,),
                        
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('265',
                        style: Theme.of(context).textTheme.bodyMedium,),
                        Text('Photos',
                        style: Theme.of(context).textTheme.bodySmall,),
                        
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('10k',
                        style: Theme.of(context).textTheme.bodyMedium,),
                        Text('Followers',
                        style: Theme.of(context).textTheme.bodySmall,),
                        
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Text('64',
                        style: Theme.of(context).textTheme.bodyMedium,),
                        Text('Following',
                        style: Theme.of(context).textTheme.bodySmall,),
                        
                      ],
                    ),
                  ),
                ),
                
              ],),
              const SizedBox(height: 10,),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){},
                      style: const ButtonStyle(
                        
                      ),
                       child: const Text('Add Photos')),
                  ),
                  const SizedBox(width: 15,),
                  ElevatedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    
                     child: const Icon(IconBroken.Edit,size: 20,)),
                ],
              )
              
              ,const SizedBox(height: 20,)
              ,GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: .5/ .5,
                  children: List.generate(
                      6,
                      (index) =>
                          const Image(
                            
                            image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/udemyflutter-ab256.appspot.com/o/users%2FTheRiveter_AmyNelsonHeadshot_CreditChad-Peltola.jpg?alt=media&token=6f9f1b54-aa07-4481-91af-a73f7fc5b427'
                            ))),
                )
              ],
            ),
          ),
        )
     ,
        ) ;},
    );
  }
}
