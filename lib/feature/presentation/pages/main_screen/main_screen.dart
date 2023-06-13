import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/feature/presentation/cubit/user/user.dart';
import 'package:insta_clone/feature/presentation/pages/pages.dart';

class MainScreen extends StatefulWidget {
  final String uid;

  const MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
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
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, state) {
        if (state is GetSingleUserLoaded) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: PageView(
              controller: pageController,
              onPageChanged: onChangedPage,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomePage(currentUser: state.user),
                const SearchPage(),
                AddPostPage(currentUser: state.user),
                const ActivityPage(),
                ProfilePage(user: state.user),
              ],
            ),
            bottomNavigationBar: CupertinoTabBar(
                onTap: (value) => pageController.jumpToPage(value),
                backgroundColor: AppColors.backgroundColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_rounded,
                      color: _currentIndex == 0
                          ? AppColors.blueColor
                          : AppColors.primaryColor,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: _currentIndex == 1
                          ? AppColors.blueColor
                          : AppColors.primaryColor,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.add_circled_solid,
                      color: _currentIndex == 2
                          ? AppColors.blueColor
                          : AppColors.primaryColor,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                      color: _currentIndex == 3
                          ? AppColors.blueColor
                          : AppColors.primaryColor,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle,
                      color: _currentIndex == 4
                          ? AppColors.blueColor
                          : AppColors.primaryColor,
                    ),
                  ),
                ]),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
