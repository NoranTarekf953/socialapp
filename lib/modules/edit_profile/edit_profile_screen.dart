import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/customized_form.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

import '../../../shared/Constants/constants.dart';

class EditProfileScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit.get(context).userModel;
        nameController.text = model!.name;
        phoneController.text = model.phone;
        bioController.text = model.bio;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: const Text('Edit Profile'), actions: [
            TextButton(
                onPressed: () {
                  cubit.updateUserData(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                },
                child: Text(
                  'Update',
                  style: GoogleFonts.gulzar(
                      fontSize: 16, fontWeight: FontWeight.w500),
                )),
            const SizedBox(
              width: 10,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is SocialUpdateDataLoadingState)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: LinearProgressIndicator(),
                    ),
                  SizedBox(
                    height: SizeScreen.height(context) * 0.3,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: SizeScreen.height(context) * 0.24,
                                width: double.infinity,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: cubit.coverImage == null
                                            ? NetworkImage(model.cover ?? '')
                                            : FileImage(cubit.coverImage ??
                                                File('')) as ImageProvider)),
                              ),
                              CircleAvatar(
                                  radius: 18,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.pickCoverImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 20,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: SizeScreen.width(context) * 0.16,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: SizeScreen.width(context) * 0.15,
                                backgroundImage: cubit.profileImage == null
                                    ? NetworkImage(
                                        model.image ?? '',
                                      )
                                    : FileImage(cubit.profileImage ?? File(''))
                                        as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.pickProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 20,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  cubit.uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text);
                                },
                                child: const Text('Upload Profile')),
                          ),
                        if (cubit.coverImage != null)
                          const SizedBox(
                            width: 15,
                          ),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  cubit.uploadCoverImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text);
                                },
                                child: const Text('Upload Cover')),
                          ),
                      ],
                    ),
                  RoundedFormField(
                      textType: TextInputType.name,
                      labelText: 'Name',
                      prefixIcon: IconBroken.Profile,
                      validate: (value) {
                        if (value == null) return 'name must not be empty';
                        return null;
                      },
                      controller: nameController),
                  const SizedBox(
                    height: 5,
                  ),
                  RoundedFormField(
                      textType: TextInputType.text,
                      labelText: 'Bio',
                      prefixIcon: IconBroken.Info_Circle,
                      validate: (value) {
                        if (value == null) return 'Bio must not be empty';
                        return null;
                      },
                      controller: bioController),
                  const SizedBox(
                    height: 5,
                  ),
                  RoundedFormField(
                      textType: TextInputType.phone,
                      labelText: 'Phone',
                      prefixIcon: IconBroken.Call,
                      validate: (value) {
                        if (value == null) return 'phone must not be empty';
                        return null;
                      },
                      controller: phoneController),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
