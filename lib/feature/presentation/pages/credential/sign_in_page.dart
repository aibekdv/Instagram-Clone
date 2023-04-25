import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/presentation/pages/credential/sign_up_page.dart';
import 'package:insta_clone/feature/presentation/widgets/button_container_widget.dart';
import 'package:insta_clone/feature/presentation/widgets/form_container_widget.dart';
import 'package:insta_clone/routers/route_consts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgFormColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Center(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/logo.svg",
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ),
                    sizedVertical(30),
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
                      text: "Login",
                    ),
                    sizedVertical(15),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteConsts.signUp,
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Sign Up",
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
      ),
    );
  }
}
