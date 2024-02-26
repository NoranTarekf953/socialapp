import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:udemy/layout/social_app/Social_screen.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/Constants/constants.dart';
import 'package:udemy/shared/components/customized_form.dart';
import 'package:udemy/shared/components/component.dart';

import '../../../shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState ) {
          textController.clear();
          SocialCubit.get(context).postImage=null;
navigateAndFinish(context, SocialScreen(0));

        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit.get(context).userModel;
        return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: const Text('Create Post'),
              actions: [
                TextButton(
                    onPressed: () {
                      if (cubit.postImage == null) {
                        cubit.createPost(
                            text: textController.text,
                            dateTime: dateTimeFormat);
                      } else {
                        cubit.uploadPostImage(
                            text: textController.text,
                            dateTime: dateTimeFormat);
                      }
                    },
                    child: Text(
                      'Post',
                      style: GoogleFonts.gulzar(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                const SizedBox(
                  width: 10,
                )
              ],
            ),

            body: Padding(
              padding: const EdgeInsetsDirectional.all(20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    if (state is SocialUploadPostImageLoadingState)
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: LinearProgressIndicator()),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: cubit.profileImage == null
                              ? NetworkImage(
                                  model!.image,
                                )
                              : FileImage(cubit.profileImage ?? File(''))
                                  as ImageProvider,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            model!.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: TextFormField(
                        maxLines: null,
                        controller: textController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write your post .....'),
                      ),
                    ),
                    //Spacer(),
                    if (cubit.postImage != null)
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: SizeScreen.height(context) * 0.3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          cubit.postImage ?? File('')))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                    onPressed: () {
                                      cubit.removePostImage();
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      size: 15,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                cubit.pickPostImage();
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconBroken.Image),
                                  Text('add photos')
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                textController.text ='#';
                              }, child: const Text('# Tags')),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ));
      },
    );
  }
}
