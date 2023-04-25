import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/presentation/pages/post/comment/comment_page.dart';
import 'package:insta_clone/feature/presentation/pages/post/update_post_page.dart';
import 'package:insta_clone/routers/route_consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: SvgPicture.asset(
          "assets/logo.svg",
          color: AppColors.primaryColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              onPressed: () {},
              splashRadius: 25,
              icon: const Icon(MaterialCommunityIcons.facebook_messenger),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/profile_default.jpg'),
            ),
            title: const Text(
              "aibek7_official",
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: GestureDetector(
              onTap: () {
                _openBottomSheetModal(context);
              },
              child: const Icon(Icons.more_vert),
            ),
          ),
          sizedVertical(6),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            color: AppColors.secondaryColor,
          ),
          sizedVertical(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          size: 25,
                        ),
                        sizedHorizontal(10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteConsts.commentPage);
                          },
                          child: const Icon(
                            Feather.message_circle,
                            size: 25,
                          ),
                        ),
                        sizedHorizontal(10),
                        const Icon(
                          Feather.send,
                          size: 25,
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.bookmark_border,
                      size: 25,
                    ),
                  ],
                ),
                sizedVertical(10),
                const Text(
                  "3 likes",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sizedVertical(10),
                Row(
                  children: [
                    const Text(
                      "aibek7_official",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    sizedHorizontal(10),
                    const Text("some description"),
                  ],
                ),
                sizedVertical(10),
                const Text(
                  "View all 10 comments",
                  style: TextStyle(
                    color: AppColors.darkGreyColor,
                    fontSize: 14,
                  ),
                ),
                sizedVertical(10),
                const Text(
                  "24/04/2023",
                  style: TextStyle(
                    color: AppColors.darkGreyColor,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

_openBottomSheetModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 160,
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
                      fontSize: 20,
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
                      Navigator.pushNamed(context, RouteConsts.updatePostPage);
                    },
                    child: const Text(
                      "Edit post",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
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
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Delete post",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.primaryColor,
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
