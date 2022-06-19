import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/uitl/extentions.dart';
import 'package:social_app/uitl/toast-service.dart';
import 'package:social_app/view_model/cubits/auth_cubit.dart';
import 'package:social_app/view_model/states/auth_states.dart';
import 'package:social_app/views/auth_views/login_screen.dart';
import 'package:social_app/views/control_screen.dart';
import 'package:social_app/widgets/default_buttons.dart';
import 'package:social_app/widgets/input_field.dart';
import 'package:social_app/widgets/route_navigation.dart';

import '../../uitl/constance.dart';
import '../../view_model/cubits/home_cubit.dart';
import '../../widgets/loding_dialog.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String routeName = '/register_screen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          showDialogW(
              context: context,
              content: const Center(
                child: LodingIndicat(),
              ));
        }
        if (state is RegisterSuccessState) {
          Navigator.pushReplacement(context, Navigation.animationRoute(child: const ControlScreen()));
          HomeCubit.get(context).getUserFromFireStore(uid: FirebaseAuth.instance.currentUser!.uid);
        }
        if (state is RegisterErrorState) {
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
                      key: _cubit.registerFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Text(
                                'Sign-in',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(letterSpacing: 3, fontSize: 50),
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          InputField(
                            title: 'Name',
                            hint: 'Your name',
                            validator: (val) =>
                                Validator(val!).isValidUserName()
                                    ? null
                                    : 'Please enter a valid Name',
                            onSaved: (val) => _cubit.userName = val,
                          ),
                          SizedBox(height: 0.5.h),
                          InputField(
                            title: 'Email',
                            hint: 'Your email id',
                            validator: (val) => Validator(val!).isValidEmail()
                                ? null
                                : 'Please enter a valid email',
                            onSaved: (val) => _cubit.email = val,
                          ),
                          const SizedBox(height: 15),
                          InputField(
                            title: 'Contact no.',
                            hint: 'Your contact number',
                            validator: (val) => Validator(val!).isValidPhoneNo()
                                ? null
                                : 'Please enter a valid phone no. like "+2***********"',
                            onSaved: (val) => _cubit.phone = val,
                          ),
                          const SizedBox(height: 15),
                          InputField(
                            title: 'Password',
                            hint: 'Password',
                            suffixIcon: IconButton(
                              icon: _cubit.isPasswordInvisible
                                  ? const Icon(Icons.visibility_off_outlined,
                                      color: primaryColor)
                                  : const Icon(Icons.visibility_outlined,
                                      color: accentColor),
                              iconSize: 32,
                              splashRadius: 24,
                              onPressed: () =>
                                  _cubit.changePasswordVisibility(),
                            ),
                            isPassword: _cubit.isPasswordInvisible,
                            controller: _cubit.passwordController,
                            validator: (val) => Validator(val!)
                                    .isValidPassword()
                                ? null
                                : "Please enter a valid password, password must contain lower char, upper char, numbers and symbol",
                            onSaved: (val) => _cubit.password = val,
                          ),
                          const SizedBox(height: 15),
                          InputField(
                            title: 'Confirm password',
                            hint: 'Confirm password',
                            suffixIcon: IconButton(
                              icon: _cubit.isPasswordInvisible
                                  ? const Icon(Icons.visibility_off_outlined,
                                      color: primaryColor)
                                  : const Icon(Icons.visibility_outlined,
                                      color: accentColor),
                              iconSize: 32,
                              splashRadius: 24,
                              onPressed: () =>
                                  _cubit.changePasswordVisibility(),
                            ),
                            isPassword: true,
                            validator: (val) {
                              if (val != _cubit.passwordController.text) {
                                return 'Has\'t match passwords';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          AuthButton(
                            title: 'Signup',
                            onPressed: () {
                              if (_cubit.registerFormKey.currentState!
                                  .validate()) {
                                _cubit.registerFormKey.currentState!.save();
                                _cubit.signUp();
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Have an account? ",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              TextButton(
                                child: Text(
                                  'Log-in',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                style: TextButton.styleFrom(
                                    primary: Colors.white70,
                                    shape: const StadiumBorder()),
                                onPressed: () => Navigator.pushReplacement(
                                    context, Navigation.animationRoute(child: const LoginScreen())),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
