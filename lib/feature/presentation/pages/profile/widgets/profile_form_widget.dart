import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';

class ProfileFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;

  const ProfileFormWidget({super.key, this.controller, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
          ),
        ),
        TextFormField(
          controller: controller,
          style: const TextStyle(
            color: AppColors.primaryColor,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            labelStyle: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.secondaryColor,
        )
      ],
    );
  }
}
