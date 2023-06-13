import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/firebase_consts.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/pages/pages.dart';
import 'package:insta_clone/feature/presentation/widgets/button_container_widget.dart';
import 'package:insta_clone/feature/presentation/widgets/form_container_widget.dart';
import 'package:insta_clone/routers/route_consts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLogged = false;

  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
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

  SafeArea _bodyWidget() {
    return SafeArea(
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
                  FormContainerWidget(
                    controller: _emailController,
                    hinText: "Email",
                  ),
                  sizedVertical(15),
                  FormContainerWidget(
                    controller: _passwordController,
                    hinText: "Password",
                    isPasswordField: true,
                  ),
                  sizedVertical(15),
                  ButtonContainerWidget(
                    onTap: () {
                      _signInUser();
                    },
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
                  if (_isLogged)
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
            ),
          ),
        ),
      ),
    );
  }

  void _signInUser() {
    setState(() {
      _isLogged = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signInUser(
          email: _emailController.text,
          password: _passwordController.text,
        )
        .then((value) => _clear());
  }

  _clear() {
    _emailController.clear();
    _passwordController.clear();
    _isLogged = false;
  }
}
