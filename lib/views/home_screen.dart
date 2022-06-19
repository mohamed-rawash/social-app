import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/uitl/constance.dart';
import 'package:social_app/uitl/toast-service.dart';
import 'package:social_app/view_model/states/home_states.dart';
import 'package:social_app/widgets/post_widget.dart';

import '../view_model/cubits/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is CreateNewPostSuccessState){
            if(state.isSuccess) {
              ToastService.toast(context, "New post add successfully", Colors.greenAccent);
            }
          }
        },
        builder: (context, state) {
          List<PostModel> posts = HomeCubit.get(context).newsFeedPosts;
          return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => state is! GetUserFromFireStoreLoadingState && state is! GetNewsFeedPostsLoadingState,
            widgetBuilder: (BuildContext context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      color: Colors.amber,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: blackColor,
                            size: 32,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              'Please verify your email',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(fontSize: 22, color: Colors.black),
                            ),
                          ),
                          TextButton(
                            child: const Text(
                              'SEND',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 25),
                            ),
                            style: TextButton.styleFrom(
                                primary: Colors.amber,
                                minimumSize: Size(10.w, 3.h)),
                            onPressed: () {
                              FirebaseAuth.instance.currentUser!
                                  .sendEmailVerification()
                                  .then((value) {
                                ToastService.toast(
                                    context, 'Check your email', Colors.green);
                              }).catchError((error) {
                                ToastService.toast(
                                    context, error.toString(), Colors.red);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  Card(
                    elevation: 8,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Image.network(
                          'https://img.freepik.com/free-photo/overjoyed-attractive-woman-shows-size-something-big-surprised-by-huge-object_273609-24982.jpg?t=st=1649076293~exp=1649076893~hmac=9bc6ac4bf117d2ba59f4742f974b0da0735d4842ef778bb6c24dc9a9dfb5cb6f&w=900',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate With Friends',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) => PostWidget(post: posts[index], index: index,),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            fallbackBuilder: (BuildContext context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 2,
              ),
            ),
          );
        });
  }
}
