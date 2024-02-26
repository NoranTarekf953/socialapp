// ignore_for_file: unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/modules/feed/peopleLikes.dart';
import 'package:udemy/shared/Constants/constants.dart';
import 'package:udemy/shared/components/component.dart';
import 'package:udemy/shared/styles/colors.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

import '../../models/post_model.dart';
import '../add_post/add_post_screen.dart';
import '../post_datail/post_detail.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
         SocialCubit.get(context).getUser();

        return BlocConsumer<SocialCubit, SocialStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var model = SocialCubit.get(context).userModel;
                var cubit = SocialCubit.get(context);
                return ConditionalBuilder(
                  condition: cubit.posts.isNotEmpty && model != null,
                  builder: (context) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
            
                        Padding(
                          padding:  EdgeInsetsDirectional.symmetric(vertical: SizeScreen.height(context)*0.02),
                          child: InkWell(
                            onTap: (){
                              navigateTo(context, AddPostScreen());
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(model!.image),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20),
                                  
                                ),
                                child: Center(
                                  child: Text('What\'s on your mind ?',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey[800],fontSize: 16),),
                                ),
                              ),
                              
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                              child: Container(
                                height: 50,
                              width: 1,
                              color: Colors.grey[300],),
                            ),
                            const Icon(IconBroken.Image)
            
                              ],
                            ),
                          ),
                        ),
                  
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                             return  PostItem(
                                  posts: SocialCubit.get(context).posts[index],
                                  index: index,
                                );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemCount: SocialCubit.get(context).posts.length),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
      }
    );
 
  }
}

class PostItem extends StatelessWidget {
  final PostModel posts;
  final int index;
  const PostItem({super.key, required this.posts, required this.index});
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    //cubit.getComments(postId: cubit.postsId[index]);

    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.all(5),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(posts.image),
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
                            posts.name,
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
                        posts.dateTime.toString(),
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
                posts.text,
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
                          padding: const EdgeInsets.symmetric(horizontal: 3),
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
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            '#software',
                            style: TextStyle(color: defaultColor),
                          )),
                    ),
                  ],
                ),
              ),
              if (posts.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(posts.postImage),
                        )),
                  ),
                ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      navigateTo(context, PeopleLikes(postId: cubit.postsId[index]));
                    },
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
                        cubit.posts[index].likes.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            ,
                      ),
                    ]),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          PostDetails(
                            postId: cubit.postsId[index],
                            post: cubit.posts[index],
                            likes: cubit.posts[index].likes!,
                          ));
                    },
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
                          cubit.posts[index].comments.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              ,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              myDivider(),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          PostDetails(
                            postId: cubit.postsId[index],
                            post: cubit.posts[index],
                            likes: cubit.posts[index].likes!,
                          ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(cubit.userModel!.image),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Write an comment ...',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  )),
                  //Spacer(),
                  InkWell(
                    //splashColor: Colors.red,
                    onTap: () {
                      cubit.likePost(cubit.postsId[index]);
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
                        cubit.myLikes[index]==null ? 
                        Text(
                                'Like',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    ,
                              )
                            : Text(
                                'Liked',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeScreen.width(context) * 0.02,
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
                              ,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
