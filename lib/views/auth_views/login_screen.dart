import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/uitl/constance.dart';
import 'package:social_app/view_model/cubits/auth_cubit.dart';
import 'package:social_app/view_model/states/auth_states.dart';
import 'package:social_app/views/auth_views/register_screen.dart';
import 'package:social_app/views/control_screen.dart';
import 'package:social_app/widgets/default_buttons.dart';
import 'package:social_app/widgets/input_field.dart';
import 'package:social_app/widgets/route_navigation.dart';

import '../../uitl/toast-service.dart';
import '../../view_model/cubits/home_cubit.dart';
import '../../widgets/loding_dialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login_screen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          showDialogW(
              context: context,
              content: const Center(
                child: LodingIndicat(),
              ));
        }
        if (state is LoginSuccessState) {
          Navigator.pop(context);
          Navigator.pushReplacement(context, Navigation.animationRoute(child: const ControlScreen()));
          HomeCubit.get(context).getUserFromFireStore(uid: FirebaseAuth.instance.currentUser!.uid);
        }
        if (state is LoginErrorState) {
          Navigator.pop(context);
          ToastService.toast(context, state.error!, accentColor);
        }
      },
      builder: (context, state) {
        AuthCubit _cubit = AuthCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      'assets/images/cold-mountain-background-g.gif',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  )),
                ),
              ),
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Form(
                      key: _cubit.loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Text(
                                'Log-in',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(letterSpacing: 3, fontSize: 50),
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h
                          ),
                          InputField(
                            title: 'Email',
                            hint: 'Your email id',
                            validator: (val) => null,
                            onSaved: (val) => _cubit.email = val,
                          ),
                          SizedBox(height: 1.h),
                          InputField(
                            title: 'Password',
                            hint: 'Password',
                            suffixIcon: IconButton(
                              icon: _cubit.isPasswordInvisible
                                  ? const Icon(Icons.visibility_off_outlined,
                                      color: primaryColor)
                                  : const Icon(Icons.visibility_outlined,
                                      color: accentColor),
                              iconSize: 24.sp,
                              splashRadius: 24,
                              onPressed: () =>
                                  _cubit.changePasswordVisibility(),
                            ),
                            isPassword: _cubit.isPasswordInvisible,
                            validator: (val) => null,
                            onSaved: (val) => _cubit.password = val,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                child: Text(
                                  'Forget Password?',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.white70,
                                    shape: const StadiumBorder()),
                                onPressed: () {},
                              )
                            ],
                          ),
                          SizedBox(height: 2.h),
                          AuthButton(
                            title: 'Login',
                            onPressed: () {
                              _cubit.loginFormKey.currentState!.save();
                              _cubit.signIn();
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              TextButton(
                                child: Text(
                                  'Sign-up',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.white70,
                                    shape: const StadiumBorder()),
                                onPressed: () => Navigator.pushReplacement(
                                    context, Navigation.animationRoute(child: const RegisterScreen())),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                height: 2,
                                color: grayColor,
                              )),
                              const Text(' Or login with '),
                              Expanded(
                                  child: Container(
                                height: 2,
                                color: grayColor,
                              )),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                icon:  const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                                iconSize: 40,
                                splashRadius: 30,
                                onPressed: (){},
                              ),
                              SizedBox(width: 2.w),
                              IconButton(
                                icon:  const FaIcon(FontAwesomeIcons.facebookF, color: Colors.blue),
                                iconSize: 40,
                                splashRadius: 30,
                                onPressed: (){},
                              ),
                              SizedBox(width: 2.w),
                              IconButton(
                                icon:  const FaIcon(FontAwesomeIcons.twitter, color: Colors.blueAccent),
                                iconSize: 40,
                                splashRadius: 30,
                                onPressed: (){},
                              ),
                              SizedBox(width: 2.w),
                              IconButton(
                                icon:  const FaIcon(FontAwesomeIcons.githubAlt, color: Colors.black),
                                iconSize: 40,
                                splashRadius: 30,
                                color: Colors.black,
                                onPressed: (){},
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
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
