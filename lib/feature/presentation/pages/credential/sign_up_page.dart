import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/presentation/pages/credential/sign_in_page.dart';
import 'package:insta_clone/feature/presentation/widgets/button_container_widget.dart';
import 'package:insta_clone/feature/presentation/widgets/form_container_widget.dart';
import 'package:insta_clone/routers/route_consts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgFormColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/logo.svg",
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                  sizedVertical(30),
                  _formSignUp(),
                  sizedVertical(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteConsts.signIn,
                              (route) => false,
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _formSignUp() {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage:
                      const AssetImage("assets/profile_default.jpg"),
                  backgroundColor: Colors.grey.withOpacity(.8),
                  radius: 35,
                ),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 20,
                    color: AppColors.blueColor,
                  ),
                ),
              ],
            ),
          ),
          sizedVertical(15),
          const FormContainerWidget(
            hinText: "Enter your username",
          ),
          sizedVertical(15),
          const FormContainerWidget(
            hinText: "Email",
          ),
          sizedVertical(15),
          const FormContainerWidget(
            hinText: "Password",
            isPasswordField: true,
          ),
          sizedVertical(15),
          ButtonContainerWidget(
            onTap: () {},
            color: AppColors.blueColor,
            text: "Register",
          ),
        ],
      ),
    );
  }
}
