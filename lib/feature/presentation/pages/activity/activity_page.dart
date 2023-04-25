import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          "Activity",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
