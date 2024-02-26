import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/customized_form.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icon_broken.dart';
import '../../models/post_model.dart';
import '../../shared/components/component.dart';

class PostDetails extends StatelessWidget {
  String postId;
  final PostModel post;
  final int likes;

  PostDetails(
      {super.key,
      required this.postId,
      required this.post,
      required this.likes});
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
      SocialCubit.get(context).getComments(postId: postId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialAddCommentSuccessState) {
            commentController.text = '';

            //SocialCubit.get(context).removeCommentImage();
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          var model = SocialCubit.get(context).userModel;
          return Scaffold(
            appBar: defaultAppBar(context: context),
          
            body: Padding(
              padding: const EdgeInsetsDirectional.only(
                  bottom: 15, start: 15, end: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: SizeScreen.height(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(post.image),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    post.name,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: defaultColor,
                                    size: 15,
                                  ),
                                ],
                              ),
                              Text(
                                post.dateTime,
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_horiz,
                                size: 22,
                              ))
                        ],
                      ),
                      myDivider(),
                      Text(
                        post.text,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w400, height: 1.23),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 5, top: 2),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                              child: MaterialButton(
                                  onPressed: () {},
                                  minWidth: 1,
                                  height: 1,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text(
                                    '#software',
                                    style: TextStyle(color: defaultColor),
                                  )),
                            ),
                            SizedBox(
                              height: 25,
                              child: MaterialButton(
                                  onPressed: () {},
                                  minWidth: 1,
                                  height: 1,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text(
                                    '#software',
                                    style: TextStyle(color: defaultColor),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      if (post.postImage != '')
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.symmetric(vertical: 5),
                          child: Container(
                            height: SizeScreen.height(context) * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(post.postImage),
                                )),
                          ),
                        ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(children: [
                              const Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                likes.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey[700]),
                              ),
                            ]),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                const Icon(
                                  IconBroken.Chat,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  cubit.comments.length.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      myDivider(),
                      Expanded(
                        child: Row(
                          children: [
                            const Spacer(),
                        
                            //Spacer(),
                            InkWell(
                              onTap: () {
                                //cubit.likePost(postId);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Heart,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  //cubit.isLiked == false?
                                   Text(
                                          'Like',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w500),
                                        )
                                      /*: Text(
                                          'Liked',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500),
                                        )*/
                                ],
                              ),
                            ),
                            SizedBox(
                              width: SizeScreen.width(context) * 0.05,
                            ),
                            InkWell(
                              splashColor: Colors.red,
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Upload,
                                    color: Colors.green,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Share',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      cubit.comments.isEmpty
                          ? Expanded(
                            child: SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    'No Comments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                          )
                          : SizedBox(
                              height: SizeScreen.height(context),
                              child: cubit.comments.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No Comments',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(color: Colors.grey[400]),
                                      ),
                                    )
                                  : Expanded(
                                    child: ListView.separated(
                                        //shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            CommentItem(
                                                comment: cubit.comments[index]),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 15,
                                        ),
                                        itemCount: cubit.comments.length,
                                      ),
                                  ))
                   ,Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          //color: Colors.red,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage:
                                    NetworkImage(cubit.userModel!.image),
                              ),
                              SizedBox(
                                width: SizeScreen.width(context) * 0.03,
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                  onTapOutside: (event) => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
                                  controller: commentController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 5,
                                  style: GoogleFonts.gulzar(
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                  onFieldSubmitted: (value) {
                                    cubit.AddComment(
                                        postId: postId,
                                        comment: commentController.text,
                                        date: FieldValue.serverTimestamp()
                                            .toString());
                                            cubit.removeCommentImage();
                                  },
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cubit.pickCommentImage();
                                      },
                                      icon: Icon(
                                        IconBroken.Image,
                                        color: defaultColor,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        if (cubit.commentImage == null) {
                                          cubit.AddComment(
                                              postId: postId,
                                              comment: commentController.text,
                                              date: FieldValue.serverTimestamp()
                                                  .toString());
                                        } else {
                                          cubit.uploadCommentImage(
                                              text: commentController.text,
                                              postId: postId);
                                        }
                                      },
                                      icon: Icon(
                                        IconBroken.Send,
                                        color: defaultColor,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        if (cubit.commentImage != null)
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 90,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            cubit.commentImage ?? File('')))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: defaultColor.shade100),
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.removeCommentImage();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 12,
                                      )),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class CommentItem extends StatelessWidget {
  CommentModel comment;
  CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);

    return Card(
      shadowColor: Colors.white,
      elevation: 1,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color.fromARGB(250, 245, 245, 245),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(cubit.userModel!.image),
                ),
                SizedBox(
                  width: SizeScreen.width(context) * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          comment.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 15,
                        ),
                      ],
                    ),
                    Text(
                      DateTime.now().toString(),
                      // posts.dateTime,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      comment.comment,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (cubit.commentImage != null)
                      Container(
                        height: 90,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(cubit.commentImage??File('')))),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
