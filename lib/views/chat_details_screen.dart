import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/uitl/constance.dart';

import '../uitl/extentions.dart';
import '../view_model/cubits/home_cubit.dart';
import '../view_model/states/home_states.dart';

class ChatDetailsScreen extends StatefulWidget {
  final UserModel user;

  ChatDetailsScreen({required this.user});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    HomeCubit.get(context)
        .messageController
        .addListener(HomeCubit.get(context).showSendButton);
  }

  @override
  void dispose() {
    HomeCubit.get(context).messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        HomeCubit.get(context).getMessages(receiverId: widget.user.id!);
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 5.w,
                      backgroundImage: NetworkImage(
                        widget.user.image!,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        StringCasing(widget.user.name!).toTitleCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(height: 1, color: whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            cubit.messages.isNotEmpty,
                        widgetBuilder: (context) => ListView.builder(
                          itemCount: cubit.messages.length,
                          itemBuilder: (context, index) => cubit
                                      .messages[index].receiverId ==
                                  widget.user.id
                              ? buildMyMessage(message: cubit.messages[index])
                              : buildMessage(message: cubit.messages[index]),
                        ),
                        fallbackBuilder: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: accentColor,
                            backgroundColor: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 8,
                      margin: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Message',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: whiteColor),
                            border: InputBorder.none,
                            suffixIcon: cubit.isMessageEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                      size: 32,
                                      color: accentColor,
                                    ),
                                    splashRadius: 24,
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      cubit.sendMessage(
                                          receiverId: widget.user.id!);
                                      cubit.messageController.clear();
                                    },
                                  )
                                : const SizedBox(),
                          ),
                          cursorColor: accentColor,
                          autofocus: true,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: whiteColor, fontSize: 24),
                          controller: cubit.messageController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage({required MessageModel message}) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0, right: 4, left: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
              child: Text(
                message.message!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: primaryColor),
              ),
            ),
          ),
        ),
      );

  Widget buildMyMessage({required MessageModel message}) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0, left: 4, right: 10),
          child: Container(
            decoration: BoxDecoration(
              color: accentColor.withOpacity(.6),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
              child: Text(
                message.message!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
      );
}
