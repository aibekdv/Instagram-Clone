import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/presentation/cubit/post/post_cubit.dart';
// import 'package:insta_clone/routers/route_consts.dart';
import 'package:insta_clone/injection_container.dart' as di;

import 'widgets/single_post_card.dart';

class HomePage extends StatelessWidget {
  final UserEntity currentUser;
  const HomePage({super.key, required this.currentUser});

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
              icon: const Icon(Icons.facebook),
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            di.sl<PostCubit>()..getPosts(post: const PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, postState) {
            if (postState is PostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (postState is PostFailure) {
              return const Center(
                child: Text("Some error occurred"),
              );
            }
            if (postState is PostLoaded) {
              return ListView.builder(
                itemCount: postState.posts.length,
                itemBuilder: (context, index) {
                  return SinglePostCardWidget(
                    post: postState.posts[index],
                    currentUser: currentUser,
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
