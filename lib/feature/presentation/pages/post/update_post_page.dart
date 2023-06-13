import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:insta_clone/feature/presentation/widgets/profile_image_widget.dart';

class UpdatePostPage extends StatefulWidget {
  final PostEntity post;
  const UpdatePostPage({super.key, required this.post});

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  TextEditingController? _descrpitionController;

  @override
  void initState() {
    _descrpitionController =
        TextEditingController(text: widget.post.description);
    super.initState();
  }

  @override
  void dispose() {
    _descrpitionController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.primaryColor,
          ),
          splashRadius: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              color: AppColors.blueColor,
            ),
            splashRadius: 25,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              sizedVertical(10),
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: profileWidget(imageUrl: widget.post.userProfileUrl),
                ),
              ),
              sizedVertical(10),
              Text(
                "${widget.post.username}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedVertical(15),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: profileWidget(imageUrl: widget.post.postImageUrl),
              ),
              sizedVertical(15),
              ProfileFormWidget(
                title: "Description",
                controller: _descrpitionController,
              ),
              sizedVertical(15),
            ],
          ),
        ),
      ),
    );
  }
}
