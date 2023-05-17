import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/firebase_consts.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/pages/credential/sign_in_page.dart';
import 'package:insta_clone/feature/presentation/pages/pages.dart';
import 'package:insta_clone/feature/presentation/widgets/button_container_widget.dart';
import 'package:insta_clone/feature/presentation/widgets/form_container_widget.dart';
import 'package:insta_clone/feature/presentation/widgets/profile_image_widget.dart';
import 'package:insta_clone/routers/route_consts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isSignIn = false;
  File? _imageFile;

  Future selectImage() async {
    try {
      final pickedImage = await ImagePicker.platform.getImage(
        source: ImageSource.gallery,
      );

      setState(() {
        if (pickedImage != null) {
          _imageFile = File(pickedImage.path);
        } else {
          print("Image file is not selected");
        }
      });
    } catch (e) {
      toast("Some error ocurred $e");
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgFormColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (state is CredentialFailure) {
            toast("Invalid email or password");
          }
        },
        builder: (context, state) {
          if (state is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  debugPrint("New uid: ${state.uid}");
                  return MainScreen(uid: state.uid);
                } else {
                  return _bodyWidget();
                }
              },
            );
          }
          return _bodyWidget();
        },
      ),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
    );
  }

  _formSignUp() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Stack(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: profileWidget(image: _imageFile),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: selectImage,
                    child: const Icon(
                      Icons.add_a_photo,
                      size: 20,
                      color: AppColors.blueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizedVertical(15),
          FormContainerWidget(
            hinText: "Enter your username",
            controller: _userNameController,
          ),
          sizedVertical(15),
          FormContainerWidget(
            hinText: "Email",
            controller: _emailController,
          ),
          sizedVertical(15),
          FormContainerWidget(
            hinText: "Password",
            isPasswordField: true,
            controller: _passwordController,
          ),
          sizedVertical(15),
          ButtonContainerWidget(
            onTap: () {
              _signUpUser();
            },
            color: AppColors.blueColor,
            text: "Register",
          ),
          sizedVertical(15),
          // Loading for credential sign-up
          if (_isSignIn == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Please wait...",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                  ),
                ),
                sizedHorizontal(10),
                const CircularProgressIndicator(),
              ],
            )
        ],
      ),
    );
  }

  void _signUpUser() {
    setState(() {
      _isSignIn = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
          user: UserEntity(
            email: _emailController.text,
            username: _userNameController.text,
            password: _passwordController.text,
            totalFollowers: 0,
            totalFollowing: 0,
            totalPosts: 0,
            followers: const [],
            following: const [],
            website: '',
            profileUrl: '',
            bio: '',
            name: '',
            imageFile: _imageFile,
          ),
        )
        .then((value) => _clear());
  }

  _clear() {
    _emailController.clear();
    _passwordController.clear();
    _userNameController.clear();
    _isSignIn = false;
  }
}
