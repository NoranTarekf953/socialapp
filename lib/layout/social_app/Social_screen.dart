// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

class SocialScreen extends StatefulWidget {
  int initialIndex = 0;

  SocialScreen(this.initialIndex, {super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen>
    with SingleTickerProviderStateMixin {
  static late TabController tabController;
  late int initialIndex;
  List<Widget> tabs = [
    const Tab(
      icon: Icon(IconBroken.Home),
    ),
    const Tab(
      icon: Icon(IconBroken.Chat),
    ),
  
    const Tab(
      icon: Icon(IconBroken.Profile),
    ),
    const Tab(
      icon: Icon(IconBroken.Notification),
    ),
    const Tab(
      icon: Icon(Icons.menu),
    ),
   
   
  ];
  @override
  void initState() {
    initialIndex = widget.initialIndex;
    tabController = TabController(length: 5, vsync: this);
    tabController.index = initialIndex;
    tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    //tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        /*if (state is SocialAddPostState) {
          navigateTo(context, AddPostScreen());
        }*/
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: tabController.index == 0
              ? AppBar(
                  title: const Text('Social App'),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Notification,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Search,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                  
                  bottom: TabBar(
                    tabs: tabs,
                    controller: tabController,
                    onTap: (value) {
                      cubit.changeTabBar(value);
                    },
                  ),
                )
              : AppBar(
                  title: TabBar(
                    tabs: tabs,
                    controller: tabController,
                    onTap: (value) {
                      cubit.changeTabBar(value);
                    },
                  ),
                ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBarView(
                physics: const RangeMaintainingScrollPhysics(),
                controller: tabController,
                children: cubit.screens,
              )),

          /*  bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
cubit.changeNavBar(index);
            },
            currentIndex: cubit.currentindex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home'),
                BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats'),
                BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: 'Post'),

                BottomNavigationBarItem(
                icon: Icon(IconBroken.User),
                label: 'Users'),
                BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings'),
            ]),
            
*/
        );
      },
    );
  }
}
