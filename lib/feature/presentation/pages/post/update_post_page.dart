import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/pages/post/widgets/update_post_widget.dart';
import 'package:insta_clone/injection_container.dart' as di;

class UpdatePostPage extends StatelessWidget {
  final PostEntity post;
  const UpdatePostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
      create: (context) => di.sl<PostCubit>(),
      child: UpdatePostWidget(post: post),
    );
  }
}
