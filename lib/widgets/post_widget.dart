import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/view_model/cubits/home_cubit.dart';

import '../uitl/constance.dart';
import '../uitl/extentions.dart';

class PostWidget extends StatelessWidget {
  PostModel post;
  int index;

  PostWidget({required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 10.w,
                  backgroundImage: NetworkImage(
                    post.image!,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          Expanded(
                            child: Text(
                              StringCasing(post.name!).toTitleCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    height: 1,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.sp,
                          )
                        ],
                      ),
                      Text(
                        post.dateTime!,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.ellipsis),
                  splashRadius: 24,
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                width: 90.w,
                height: 2,
                color: Colors.grey,
              ),
            ),
            Text(
              post.text!,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Text(
                        "#Software",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Text(
                        "#Software",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Text(
                        "#Software",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Text(
                        "#Software",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                      child: Text(
                        "#Software",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (post.postImage != "")
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(
                        post.postImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.thumbsUp,
                        size: 16.sp,
                        color: accentColor,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        HomeCubit.get(context).postLikesCount[index].toString(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: accentColor,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.comment,
                        size: 16.sp,
                        color: primaryColor,
                      ),
                      Text("123 Comments",
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                width: 90.w,
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 5.w,
                        backgroundImage: NetworkImage(
                          HomeCubit.get(context).userModel!.image!,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "write comment...",
                            suffix: HomeCubit.get(context).isComment?TextButton(
                              child: const Text("dd"),
                              onPressed: () {}
                            ):const SizedBox(
                              width: 0,
                              height:0,
                            ),
                          ),
                          controller: HomeCubit.get(context).commentController,
                          onChanged: (val) {
                            if(val.isNotEmpty) {
                              HomeCubit.get(context).isComment = true;
                            } else {
                              HomeCubit.get(context).isComment = false;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  icon: FaIcon(
                    FontAwesomeIcons.thumbsUp,
                    size: 16.sp,
                    color: HomeCubit.get(context).postISLiked[index]
                        ? accentColor
                        : primaryColor,
                  ),
                  label: Text(
                    'Like',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: HomeCubit.get(context).postISLiked[index]
                              ? accentColor
                              : primaryColor,
                        ),
                  ),
                  onPressed: () {
                    HomeCubit.get(context).changeLikeStatus(index: index);
                    if (HomeCubit.get(context).postISLiked[index]) {
                      HomeCubit.get(context)
                          .likePost(postID: post.postId, index: index);
                    } else {
                      HomeCubit.get(context)
                          .disLikePost(postID: post.postId, index: index);
                    }
                    // HomeCubit.get(context).getNewsFeedPosts();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
