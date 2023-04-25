import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.controller});
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.darkGreyColor.withOpacity(.35),
          contentPadding: const EdgeInsets.only(top: 16),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search),
          hintText: "Enter your text here...",
        ),
      ),
    );
  }
}
