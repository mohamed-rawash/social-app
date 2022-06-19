import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/uitl/toast-service.dart';
import 'package:social_app/view_model/cubits/home_cubit.dart';
import 'package:social_app/view_model/states/home_states.dart';
import 'package:social_app/views/home_screen.dart';
import 'package:social_app/widgets/route_navigation.dart';

import '../uitl/constance.dart';
import '../uitl/extentions.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is CreateNewPostSuccessState) {
          HomeCubit.get(context).currentIndex = 0;
          HomeCubit.get(context).postText.clear();
          HomeCubit.get(context).getNewsFeedPosts();
          Navigator.pop(context);
        } else if (state is CreateNewPostErrorState) {
          ToastService.toast(context, "Error occurred, Please try again", Colors.red);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Post",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            titleSpacing: 0.0,
            leading: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.angleLeft,
                size: 24,
                color: whiteColor,
              ),
              splashRadius: 24.0,
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Post",
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
                onPressed: () => cubit.createNewPost(),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if(state is CreateNewPostLoadingState)
                  const LinearProgressIndicator(color: accentColor, backgroundColor: primaryColor,),
                if(state is CreateNewPostLoadingState)
                  const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10.w,
                      backgroundImage: NetworkImage(cubit.userModel!.image!),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        StringCasing(cubit.userModel!.name!).toTitleCase(),
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              height: 1,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "What is on your mind...",
                        border: InputBorder.none),
                    controller: cubit.postText,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                if (cubit.postImage != null)
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.file(
                            cubit.postImage!,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: accentColor, size: 24,),
                            splashRadius: 24,
                            color: primaryColor,
                            hoverColor: primaryColor,
                            tooltip: "Remove",
                            onPressed: () => cubit.removePostImage(),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.images,
                              size: 24,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "add photo",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 24),
                            )
                          ],
                        ),
                        onPressed: () => cubit.pickedPostImage(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        child: const Text(
                          "# tag",
                          style: TextStyle(color: Colors.blue, fontSize: 24),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
