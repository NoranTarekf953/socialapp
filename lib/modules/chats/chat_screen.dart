import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/Constants/constants.dart';
import 'package:udemy/shared/components/component.dart';

import '../../models/create_user_model.dart';
import '../chats_datails/chat_detail_screen.dart';


class SocialChatScreen extends StatelessWidget {
  
  const SocialChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).GetAllUsers();
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state) {
            
          },
          builder: (context, state) {
        
            return ConditionalBuilder(
              condition: SocialCubit.get(context).users.isNotEmpty && state is !SocialGetAllUsersLoadingState,
               builder: (context)=> Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
               itemBuilder: (context,index)=>chatsItem(context: context, user: SocialCubit.get(context).users[index]),
                separatorBuilder:(context,index)=> myDivider(),
                 itemCount: SocialCubit.get(context).users.length),
            ),
                fallback: (context)=>const Center(child: CircularProgressIndicator(),));
          },
        );
      }
    );
  }
  Widget chatsItem({
    required BuildContext context,
   required CreateSocialUser user
  }){
    return  InkWell(
                  onTap: (){
                    navigateTo(context, ChatDetailScreen( model: user,));
                  },
                  child: Row(
                  children: [
                    CircleAvatar(
                      radius: SizeScreen.width(context)*0.07,
                      backgroundImage: NetworkImage(
                        user.image
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                 
                   
                  ],
                                ),
                );
             
  }
}