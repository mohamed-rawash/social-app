import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/uitl/cache_helper.dart';
import 'package:social_app/uitl/theme_service.dart';
import 'package:social_app/view_model/bloc_observer.dart';
import 'package:social_app/view_model/cubits/auth_cubit.dart';
import 'package:social_app/view_model/cubits/home_cubit.dart';
import 'package:social_app/views/auth_views/login_screen.dart';
import 'package:social_app/views/auth_views/register_screen.dart';
import 'package:social_app/views/control_screen.dart';
import 'package:social_app/views/home_screen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await CacheHelper.init();
  BlocOverrides.runZoned(
        () {
          runApp(const SocialApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class SocialApp extends StatelessWidget {
  const SocialApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()..getUserFromFireStore(uid: FirebaseAuth.instance.currentUser!.uid)..getPostsLiked()..getNewsFeedPosts()),
      ],
      child: Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeService.light,
              home: FirebaseAuth.instance.currentUser == null? const LoginScreen(): const ControlScreen(),
              routes: {
                LoginScreen.routeName: (_) => const LoginScreen(),
                RegisterScreen.routeName: (_) => const RegisterScreen(),
                HomeScreen.routeName: (_) =>  HomeScreen(),
              },
            );
          }
      )
    );
  }
}
