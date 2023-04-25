import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/feature/presentation/pages/pages.dart';
import 'package:insta_clone/feature/presentation/pages/post/comment/comment_page.dart';

import 'route_consts.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteConsts.editProfilePage:
        return routeBuilder(const EditProfilePage());

      case RouteConsts.updatePostPage:
        return routeBuilder(const UpdatePostPage());

      case RouteConsts.commentPage:
        return routeBuilder(const CommentPage());

      case RouteConsts.signIn:
        return routeBuilder(const SignInPage());

      case RouteConsts.signUp:
        return routeBuilder(const SignUpPage());

      default:
        return routeBuilder(const ErrorPage());
    }
  }
}

MaterialPageRoute routeBuilder(Widget widget) {
  return MaterialPageRoute(
    builder: (context) => widget,
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Text(
          'ErrorPage',
          style: TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
