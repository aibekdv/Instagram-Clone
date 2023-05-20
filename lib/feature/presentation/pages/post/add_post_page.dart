import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/presentation/cubit/post/post_cubit.dart';

import 'widgets/add_post_widget.dart';
import 'package:insta_clone/injection_container.dart' as di;

class AddPostPage extends StatelessWidget {
  final UserEntity currentUser;
  const AddPostPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<PostCubit>(),
      child: AddPostWidget(currentUser: currentUser),
    );
  }
}
