import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';

import 'widgets/profile_form_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 25,
          icon: const Icon(Icons.close),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          "Edit profile",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 25,
            icon: const Icon(Icons.done),
            color: AppColors.blueColor,
            iconSize: 25,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sizedVertical(15),
              const Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/profile_default.jpg"),
                ),
              ),
              sizedVertical(10),
              GestureDetector(
                child: const Text(
                  "Change photo",
                  style: TextStyle(
                    color: AppColors.blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              sizedVertical(15),
              const ProfileFormWidget(title: "Name"),
              sizedVertical(15),
              const ProfileFormWidget(title: "Username"),
              sizedVertical(15),
              const ProfileFormWidget(title: "Bio"),
            ],
          ),
        ),
      ),
    );
  }
}
