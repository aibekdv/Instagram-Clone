import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/presentation/pages/profile/widgets/profile_form_widget.dart';

class UpdatePostPage extends StatelessWidget {
  const UpdatePostPage({super.key});

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
              const CircleAvatar(
                backgroundImage: AssetImage("assets/profile_default.jpg"),
                radius: 40,
              ),
              sizedVertical(10),
              const Text(
                "aibek7_official",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedVertical(15),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey,
                child: const Positioned(
                  top: 0,
                  child: Icon(Icons.edit),
                ),
              ),
              sizedVertical(15),
              const ProfileFormWidget(title: "Description"),
              sizedVertical(15),
            ],
          ),
        ),
      ),
    );
  }
}
