import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/shared/components/component.dart';
import 'package:udemy/shared/styles/colors.dart';
import 'package:udemy/shared/styles/icon_broken.dart';

import '../settings/personal_account_screen.dart';
import '../social_login/social_login.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialSignOutSuccessState) {
          navigateTo(context, SocialLogInScreen());
        }
        //if(state is SocialNotificationState) navigateTo(context, SocialNotificationScreen());
      },
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, const PersonalAccountScreen());
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(model!.image),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'See your profile',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              SocialCubit.get(context).signOut();
                            },
                            icon: Row(
                              children: [
                                Icon(
                                  IconBroken.Logout,
                                  size: 20,
                                  color: defaultColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'SignOut',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: defaultColor),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                child: Text(
                  'Account',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      MenuItem(
                        icon: IconBroken.Profile,
                        label: 'Your Personal Info ',
                        onTap: () {
                          navigateTo(context, const PersonalAccountScreen());
                        },
                      ),
                      MenuItem(
                        icon: IconBroken.Lock,
                        label: 'Reset Password ',
                        onTap: () {},
                      ),
                      MenuItem(
                        icon: IconBroken.Notification,
                        label: 'Notifications ',
                        onTap: () {
                          cubit.changeTabBar(3);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ExpansionTileTheme(
                        data: ExpansionTileThemeData(
                            shape: Border.all(color: Colors.transparent)),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          onExpansionChanged: (value) {
                            // cubit.isTapped = value;
                            cubit.menuListTap();
                          },
                          trailing: cubit.isTapped == true
                              ? Icon(
                                  IconBroken.Arrow___Down_2,
                                  color: defaultColor,
                                )
                              : Icon(
                                  IconBroken.Arrow___Right_2,
                                  color: defaultColor,
                                ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.language,
                              color: Colors.grey[600],
                            ),
                          ),
                          title: const Text('Language'),
                          children: [
                            RadioListTile(
                                //selected: true,
                                title: const Text('English'),
                                value: 'en',
                                groupValue: cubit.Language,
                                onChanged: (value) {
                                  cubit.Language = value!;
                                }),
                            RadioListTile(
                                title: const Text('العربية'),
                                value: 'ar',
                                groupValue: cubit.Language,
                                onChanged: (value) {
                                  cubit.Language = value!;
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.dark_mode_outlined,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Dark Mode ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                                activeColor: defaultColor,
                                value: cubit.isDark,
                                onChanged: ((value) {
                                  cubit.changeMood(sharedpref: value);
                                }))
                          ],
                        ),
                      ),
                      MenuItem(
                        icon: Icons.help,
                        label: 'Help ',
                        onTap: ()=> Container(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'About Us ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Icon(
                                IconBroken.Arrow___Right_2,
                                color: defaultColor,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
 final IconData icon;
 final String label;

 final void Function()? onTap;
  const MenuItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: InkWell(
        onTap:onTap,
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(
                icon,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Icon(
              IconBroken.Arrow___Right_2,
              color: defaultColor,
            )
          ],
        ),
      ),
    );
  }
}
