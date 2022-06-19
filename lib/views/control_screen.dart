import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/uitl/constance.dart';
import 'package:social_app/view_model/cubits/home_cubit.dart';
import 'package:social_app/view_model/states/home_states.dart';
import 'package:social_app/widgets/route_navigation.dart';

import 'new_post_screen.dart';


class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state){
        if(state is NewPostNavigationState) {
          Navigator.push(context, Navigation.animationRoute(child:  NewPostScreen()));
        }
      },
      builder: (context, state) {
        HomeCubit _cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _cubit.titles[_cubit.currentScreen],
            ),
            actions: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.bell, size: 20.sp, color: accentColor,),
                splashRadius: 24,
                onPressed: (){},
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 20.sp, color: accentColor,),
                splashRadius: 24,
                onPressed: (){},
              ),
            ],
          ),
          body: _cubit.screens[_cubit.currentScreen],
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: primaryColor,
            selectedIndex: _cubit.currentIndex,
            items: [
              BottomNavyBarItem(
                icon: const FaIcon(FontAwesomeIcons.houseCrack, size: 20, color: accentColor,),
                title: Text(
                  'Feeds',
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: whiteColor),
                ),
                activeColor: accentColor,
                inactiveColor: Colors.red
              ),
              BottomNavyBarItem(
                icon: const FaIcon(FontAwesomeIcons.commentDots, size: 20, color: accentColor,),
                title: Text(
                  'Chats',
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: whiteColor),
                )
              ),
              BottomNavyBarItem(
                icon: const FaIcon(FontAwesomeIcons.circlePlus, size: 32, color: accentColor,),
                title: Text(
                  'Post',
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: whiteColor),
                )
              ),
              BottomNavyBarItem(
                  icon: const FaIcon(FontAwesomeIcons.user, size: 20, color: accentColor,),
                  title: Text(
                    'User',
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: whiteColor),
                  )
              ),
              BottomNavyBarItem(
                  icon: const FaIcon(FontAwesomeIcons.gear, size: 20, color: accentColor,),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: whiteColor),
                  )
              ),
            ],
            onItemSelected: (index){
              _cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
