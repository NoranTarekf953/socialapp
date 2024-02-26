// ignore_for_file: unnecessary_null_comparison, must_be_immutable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/social_app/Social_screen.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/modules/social_login/social_login.dart';

import 'package:udemy/shared/components/component.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';
import 'package:udemy/shared/styles/themes.dart';
import 'layout/social_app/cubit/states.dart';
import 'modules/onBoarding.dart';
import 'shared/Constants/constants.dart';
import 'shared/bloc_observer.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> firebaseMessagingBackHandler(RemoteMessage message) async {
  print('message background');
  flutterToast(msg: ' Message background', state: ToastState.success);
}

void main() async {
  try {
    //يتاكد ان كل حاجة في الميثود خلصت وبعدين يفتح الابليكيشن
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(

    );

    if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

    await FirebaseAppCheck.instance.activate();
    Bloc.observer = MyBlocObserver();
    DioHelper.init();
    await CacheHelper.init();
//token of device
    var token = await FirebaseMessaging.instance.getToken();
    print(token);

    bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
    Widget widget;
    uId = CacheHelper.getData(key: 'uId') ?? '';
    print('uId$uId');
   

//send notification foreground

    FirebaseMessaging.onMessage.listen((event) {
      print('on message');
      flutterToast(msg: 'on Message', state: ToastState.success);
    });

//send when clicked on notification and open app
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('on message open');
      flutterToast(msg: 'on Message Open', state: ToastState.success);
    });

//send notification background when app closed
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackHandler);

    if (FirebaseAuth.instance.currentUser == null) uId = '';
    if (uId != null && uId.isNotEmpty && uId != '') {
      widget = SocialScreen(0);
    } else {
      widget = const SocialOnBoarding();
    }

    runApp(MyApp(
      isDark: isDark,
      startWidget: widget,
    ));
  } catch (e) {
    print(e.toString());
  }
}

class MyApp extends StatelessWidget {
  late bool isDark;
  late Widget startWidget;

  MyApp({
    super.key,
    required this.isDark,
    required this.startWidget,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getPosts()
        ..getUser()
        ..changeMood(sharedpref: isDark),
      child: BlocConsumer<SocialCubit, SocialStates>(
          builder: (context, index) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode:
                  // ThemeMode.dark,
                  SocialCubit.get(context).isDark
                      ? ThemeMode.dark
                      : ThemeMode.light,
              darkTheme: darkTheme,
              theme: lightTheme,
              home: Directionality(
                  textDirection: TextDirection.ltr, child: SocialLogInScreen()),
            );
          },
          listener: (context, index) {}),
    );
  }
}
