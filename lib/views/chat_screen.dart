import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/views/chat_details_screen.dart';

import '../models/user_model.dart';
import '../uitl/constance.dart';
import '../view_model/cubits/home_cubit.dart';
import '../view_model/states/home_states.dart';
import '../uitl/extentions.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {

        List users = HomeCubit.get(context).allUsers;

        return Scaffold(
          backgroundColor: primaryColor.withOpacity(0.7),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => HomeCubit.get(context).allUsers.isNotEmpty,
            widgetBuilder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: users.length,
              separatorBuilder: (context, index) => const Divider(indent: 25, height: 2, color: primaryColor,),
              itemBuilder: (context, index) => userChat(user: users[index], context: context),
            ),
            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator(color: accentColor, backgroundColor: primaryColor,),),
          ),
        );
      },
    );
  }
  Widget userChat({required UserModel user, required BuildContext context}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 10.w,
              backgroundImage: NetworkImage(
                user.image!,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                StringCasing(user.name!).toTitleCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(
                  height: 1,
                  color: whiteColor
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print("object");
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(user: user)));
      },
    );
  }
}
