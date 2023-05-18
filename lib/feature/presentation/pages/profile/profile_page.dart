import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/widgets/profile_image_widget.dart';
import 'package:insta_clone/routers/route_consts.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user.username!,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _openBottomSheetModal(context, user);
                      },
                      child: const Icon(Icons.menu),
                    ),
                  ],
                ),
                sizedVertical(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: profileWidget(imageUrl: user.profileUrl),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "${user.totalPosts!.toInt()}",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sizedVertical(6),
                            const Text(
                              "Posts",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        sizedHorizontal(15),
                        Column(
                          children: [
                            Text(
                              "${user.totalFollowers!.toInt()}",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sizedVertical(6),
                            const Text(
                              "Followers",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        sizedHorizontal(15),
                        Column(
                          children: [
                            Text(
                              "${user.totalFollowing!.toInt()}",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sizedVertical(6),
                            const Text(
                              "Following",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                sizedVertical(10),
                Text(
                  user.name ?? "",
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                sizedVertical(10),
                Text(
                  user.bio ?? "",
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
                sizedVertical(15),
                const Divider(),
                sizedVertical(15),
                if (user.totalPosts! > 0)
                  Row(
                    children: const [
                      Icon(
                        Icons.apps_outlined,
                        size: 20,
                      ),
                      Text(
                        "Posts",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                sizedVertical(15),
                if (user.totalPosts == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          sizedVertical(15),
                          const Text(
                            "No Posts yet",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: user.totalPosts!.toInt(),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_openBottomSheetModal(BuildContext context, UserEntity user) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 165,
        color: AppColors.backgroundColor.withOpacity(.4),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                sizedVertical(8),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "More options",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                sizedVertical(8),
                const Divider(
                  thickness: 1,
                  color: AppColors.secondaryColor,
                ),
                sizedVertical(8),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteConsts.editProfilePage,
                          arguments: user);
                    },
                    child: const Text(
                      "Edit profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                sizedVertical(8),
                const Divider(
                  thickness: 1,
                  color: AppColors.secondaryColor,
                ),
                sizedVertical(8),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).loggedOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteConsts.signIn,
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
