import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/post_model.dart';
import 'package:udemy/shared/components/customized_form.dart';

import '../../shared/Constants/constants.dart';

class PeopleLikes extends StatelessWidget {
  final String postId;
  const PeopleLikes({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getLikes(postId: postId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
                context: context, title: Text('People who reacted')),
            body:  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SocialCubit.get(context).peolpleLikesModel.isEmpty?
                          Center(child:Text('No Likes',style: Theme.of(context).textTheme.displayMedium,)):
                         ListView.separated(
                          itemBuilder: (context, index) =>
                            PeopleLiked(
                              user: SocialCubit.get(context).peolpleLikesModel[index]),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                          itemCount:
                              SocialCubit.get(context).peolpleLikesModel.length),
                    ),
               
          );
        },
      );
    });
  }
}

class PeopleLiked extends StatelessWidget {
  LikeModel user;

  PeopleLiked({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            radius: SizeScreen.width(context) * 0.07,
            backgroundImage: NetworkImage(user.userImage),
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
