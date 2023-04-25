import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/feature/presentation/pages/pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onChangedPage(int index) {
    _currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: PageView(
        controller: pageController,
        onPageChanged: onChangedPage,
        children: const [
          HomePage(),
          SearchPage(),
          AddPostPage(),
          ActivityPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
          onTap: (value) => pageController.jumpToPage(value),
          backgroundColor: AppColors.backgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                MaterialCommunityIcons.home_variant,
                color: _currentIndex == 0
                    ? AppColors.blueColor
                    : AppColors.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.md_search,
                color: _currentIndex == 1
                    ? AppColors.blueColor
                    : AppColors.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.md_add_circle_outline,
                color: _currentIndex == 2
                    ? AppColors.blueColor
                    : AppColors.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                color: _currentIndex == 3
                    ? AppColors.blueColor
                    : AppColors.primaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                color: _currentIndex == 4
                    ? AppColors.blueColor
                    : AppColors.primaryColor,
              ),
            ),
          ]),
    );
  }
}