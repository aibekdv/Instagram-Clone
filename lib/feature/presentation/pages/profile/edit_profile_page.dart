import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/firebase_consts.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/domain/entities/user/user_entity.dart';
import 'package:insta_clone/feature/domain/usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/widgets/profile_image_widget.dart';
import 'package:insta_clone/injection_container.dart' as di;

import 'widgets/profile_form_widget.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;
  const EditProfilePage({super.key, required this.currentUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  File? imageFile;
  bool isUpdating = false;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          imageFile = File(pickedFile.path);
        } else {
          debugPrint("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  void initState() {
    _nameController.text = widget.currentUser.name ?? "";
    _userNameController.text = widget.currentUser.username ?? "";
    _bioController.text = widget.currentUser.bio ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

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
            onPressed: () {
              updateUserProfileData();
            },
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
              Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: imageFile == null
                        ? profileWidget(imageUrl: widget.currentUser.profileUrl)
                        : profileWidget(image: imageFile),
                  ),
                ),
              ),
              sizedVertical(10),
              GestureDetector(
                onTap: () {
                  selectImage();
                },
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
              ProfileFormWidget(
                title: "Name",
                controller: _nameController,
              ),
              sizedVertical(15),
              ProfileFormWidget(
                title: "Username",
                controller: _userNameController,
              ),
              sizedVertical(15),
              ProfileFormWidget(
                title: "Bio",
                controller: _bioController,
              ),
              sizedVertical(15),
              isUpdating == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.white),
                        ),
                        sizedHorizontal(10),
                        const CircularProgressIndicator()
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  updateUserProfileData() {
    setState(() => isUpdating = true);
    if (imageFile == null) {
      updateUserProfile("");
    } else {
      di
          .sl<UploadImageToStorageUsecase>()
          .call(imageFile!, false, "profileImages")
          .then((profileUrl) {
        updateUserProfile(profileUrl);
      });
    }
  }

  updateUserProfile(String profileUrl) {
    BlocProvider.of<UserCubit>(context)
        .updateUser(
          user: UserEntity(
            uid: widget.currentUser.uid,
            username: _userNameController.text,
            bio: _bioController.text,
            name: _nameController.text,
            profileUrl: profileUrl,
          ),
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      isUpdating = false;
      _userNameController.clear();
      _bioController.clear();
      _nameController.clear();
    });
    Navigator.pop(context);
  }
}
