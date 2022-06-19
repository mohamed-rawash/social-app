import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/uitl/constance.dart';
import 'package:social_app/view_model/cubits/home_cubit.dart';
import 'package:social_app/view_model/states/home_states.dart';
import 'package:social_app/widgets/route_navigation.dart';

import '../uitl/extentions.dart';
import 'edit_profile_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var _userData = HomeCubit.get(context).userModel;
        return Conditional.single(
          context: context,
          conditionBuilder: (_) => _userData != null,
          widgetBuilder: (context) => Column(
            children: [
              SizedBox(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          // borderRadius: const BorderRadius.only(
                          //   topLeft: Radius.circular(8),
                          //   topRight: Radius.circular(8),
                          // ),
                          image: _userData?.coverImage == null ||
                                  _userData!.coverImage == ""
                              ? const DecorationImage(
                                  image: AssetImage("assets/images/user.png"),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(
                                    _userData.coverImage!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 17.w,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: _userData?.image == null ||
                              _userData!.image! == ""
                          ? CircleAvatar(
                              radius: 16.w,
                              backgroundImage:
                                  const AssetImage("assets/images/user.png"),
                            )
                          : CircleAvatar(
                              radius: 16.w,
                              backgroundImage: NetworkImage(
                                _userData.image!,
                              ),
                            ),
                    )
                  ],
                ),
              ),
              Text(
                StringCasing(_userData!.name!).toTitleCase(),
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                _userData.bio!,
                style: Theme.of(context).textTheme.headline5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "Posts",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "Follower",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "100",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "Following",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "add photos".toTitleCase(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).push(Navigation.animationRoute(child: const EditProfileScreen())),
                      child: const FaIcon(FontAwesomeIcons.pen),
                    ),
                  ],
                ),
              ),
            ],
          ),
          fallbackBuilder: (context) => const Center(
              child: CircularProgressIndicator(
            color: accentColor,
            backgroundColor: primaryColor,
          )),
        );
      },
    );
  }
}
