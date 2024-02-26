// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';

import 'package:udemy/shared/components/customized_form.dart';
import 'package:udemy/shared/styles/colors.dart';

import '../../../shared/Constants/constants.dart';
import '../../../shared/styles/icon_broken.dart';
import '../../models/chat_model.dart';
import '../../models/create_user_model.dart';

class ChatDetailScreen extends StatelessWidget {
  //reciever
  CreateSocialUser model;
  ChatDetailScreen({super.key, required this.model});
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
      SocialCubit.get(context).GetMessages(recieverId: model.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialSendChatSuccessState) textController.text = '';
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: SizeScreen.width(context) * 0.06,
                    backgroundImage: NetworkImage(model.image),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    model.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.messages.isNotEmpty,
              fallback: (context) => Column(
                children: [
                   const Spacer(),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 0, vertical: 0),
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10),
                            suffixIcon: Container(
                              color: Colors.grey[200],
                              child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendChat(
                                        text: textController.text,
                                        recieverId: model.uId,
                                        dateTime: DateTime.now().toString());
                                  },
                                  icon: Icon(
                                    IconBroken.Send,
                                    color: defaultColor,
                                  )),
                            )),
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        controller: textController,
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        style: GoogleFonts.gulzar(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        onFieldSubmitted: (value) {
                          SocialCubit.get(context).sendChat(
                              text: value,
                              recieverId: model.uId,
                              dateTime: DateTime.now().toString());
                        },
                      ),
                    ),
                  ),
                
                ],
              ),
              
              builder: (context) {
              return  Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                   // flex: 5,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          if ( 
                              cubit.userModel!.uId==cubit.messages[index].senderId) {
                            return myMessagesBuilder(cubit.messages[index]);
                          } else {
                           return messageBuilder(cubit.messages[index]);
                          }
                        },
                        separatorBuilder: ((context, index) => const SizedBox(
                              height: 10,
                            )),
                        itemCount: cubit.messages.length),
                  ),
                  SizedBox(height: 10,),
                 // const Spacer(),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                       color: Colors.grey[200],
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          suffixIcon: Container(
                            color: Colors.grey[200],
                            child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendChat(
                                      text: textController.text,
                                      recieverId: model.uId,
                                      dateTime: DateTime.now().toString());
                                },
                                icon: Icon(
                                  IconBroken.Send,
                                  color: defaultColor,
                                )),
                          )),
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      controller: textController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      style: GoogleFonts.gulzar(
                          fontSize: 18, fontWeight: FontWeight.w400),
                      onFieldSubmitted: (value) {
                        SocialCubit.get(context).sendChat(
                            text: value,
                            recieverId: model.uId,
                            dateTime: DateTime.now().toString());
                      },
                    ),
                  ),
                ],
              ),
            );
  
              },
              ),
                      );
        },
      );
    });
  }

  Widget messageBuilder(MessageModel model) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(model.text),
        ),
      ),
    );
  }

  Widget myMessagesBuilder(MessageModel model) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            color: defaultColor[100],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(model.text),
        ),
      ),
    );
  }
}
