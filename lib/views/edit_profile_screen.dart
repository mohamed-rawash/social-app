import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:social_app/uitl/extentions.dart';
import 'package:social_app/view_model/cubits/home_cubit.dart';
import 'package:social_app/view_model/states/home_states.dart';
import 'package:social_app/widgets/input_field.dart';

import '../uitl/constance.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var _userData = HomeCubit.get(context).userModel;
        HomeCubit _cubit = HomeCubit.get(context);
        _cubit.nameController.text = _userData!.name!;
        _cubit.bioController.text = _userData.bio!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit profile",
              style: Theme.of(context).textTheme.bodyText1,
            ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  child: Text(
                    "Update",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.blue, fontSize: 20),
                  ),
                  onPressed: () async {
                    await _cubit.updateUserData();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if(state is UpdateUserDataLoadingState)
                  const LinearProgressIndicator(color: primaryColor, backgroundColor: accentColor,),
                SizedBox(
                  height: 200.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
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
                                image: _cubit.profileCover != null
                                    ? DecorationImage(
                                    image: FileImage(_cubit.profileCover!))
                                    : _userData.coverImage == null ||
                                    _userData.coverImage == ""
                                    ? const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/user.png"),
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
                            IconButton(
                              icon: const CircleAvatar(
                                child: FaIcon(
                                  FontAwesomeIcons.camera,
                                  size: 16,
                                  color: whiteColor,
                                ),
                                radius: 20,
                                backgroundColor: accentColor,
                              ),
                              splashRadius: 24.0,
                              onPressed: () async {
                                await _cubit.pickProfileCover();
                              },
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 17.w,
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            child: _cubit.profileImage != null
                                ? CircleAvatar(
                              radius: 16.w,
                              backgroundImage: FileImage(_cubit.profileImage!),
                            )
                                : _userData.image == null ||
                                _userData.image! == ""
                                ? CircleAvatar(
                              radius: 16.w,
                              backgroundImage: const AssetImage(
                                  "assets/images/user.png"),
                            )
                                : CircleAvatar(
                              radius: 16.w,
                              backgroundImage: NetworkImage(
                                _userData.image!,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const CircleAvatar(
                              child: FaIcon(
                                FontAwesomeIcons.camera,
                                size: 16,
                                color: whiteColor,
                              ),
                              radius: 20,
                              backgroundColor: accentColor,
                            ),
                            splashRadius: 24.0,
                            onPressed: () async => await _cubit.pickProfileImage(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 8, left: 8),
                  child: Row(
                    children: [
                      if(_cubit.profileImage != null && _cubit.profilePicUrl.isEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  minimumSize: const Size(double.infinity, 40)
                                ),
                                onPressed: () => _cubit.uploadProfileImageToFireStorage(),
                                child: _cubit.profilePicUrl.isNotEmpty? const Text("Uploaded"): const Text("upload profile photo"),
                              ),
                              if(state is UploadProfilePicLoadingState)
                                const LinearProgressIndicator(color: accentColor, backgroundColor: primaryColor,),
                            ],
                          ),
                        ),
                      ),
                      if(_cubit.profileCover != null && _cubit.profileCoverUrl.isEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  minimumSize: const Size(double.infinity, 40)
                                ),
                                onPressed: () => _cubit.uploadProfileCoverToFireStorage(),
                                child: _cubit.profileCoverUrl.isNotEmpty? const Text("Uploaded"): const Text("upload cover photo"),
                              ),
                              if(state is UploadProfileCoverLoadingState)
                                const LinearProgressIndicator(color: accentColor, backgroundColor: primaryColor,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text("User Name"),
                        prefixIcon: const Icon(Icons.person_outlined)),
                    controller: _cubit.nameController,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text("Bio"),
                        prefixIcon: const Icon(Icons.info_outline)),
                    controller: _cubit.bioController,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
