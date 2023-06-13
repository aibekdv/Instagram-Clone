import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/firebase_consts.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/usecases/storage/storage.dart';
import 'package:insta_clone/feature/presentation/cubit/post/post_cubit.dart';
import 'package:insta_clone/feature/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:insta_clone/injection_container.dart' as di;
import 'package:insta_clone/feature/presentation/widgets/profile_image_widget.dart';
import 'package:uuid/uuid.dart';

class AddPostPage extends StatefulWidget {
  final UserEntity currentUser;
  const AddPostPage({super.key, required this.currentUser});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  File? imageFile;
  bool isUploading = false;
  final descriptionController = TextEditingController();

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
  Widget build(BuildContext context) {
    return imageFile == null
        ? uploadPostPage()
        : Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  size: 25,
                ),
              ),
              title: const Text("Create a post"),
              actions: [
                IconButton(
                  onPressed: submitPost,
                  icon: const Icon(
                    Icons.done,
                    color: AppColors.blueColor,
                    size: 25,
                  ),
                  splashRadius: 25,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedVertical(15),
                    Center(
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: profileWidget(
                              imageUrl: widget.currentUser.profileUrl),
                        ),
                      ),
                    ),
                    sizedVertical(5),
                    Center(child: Text(widget.currentUser.username ?? "")),
                    sizedVertical(15),
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    sizedVertical(15),
                    ProfileFormWidget(
                      title: "Description",
                      controller: descriptionController,
                    ),
                    sizedVertical(15),
                    isUploading == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Uploading...",
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

  Widget uploadPostPage() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: selectImage,
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                child: Icon(
                  Icons.upload,
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  submitPost() {
    setState(() {
      isUploading = true;
    });
    di
        .sl<UploadImageToStorageUsecase>()
        .call(imageFile!, true, "posts")
        .then((imageUrl) {
      createSubmitPost(image: imageUrl);
      Navigator.pushNamed(context, '/');
    });
  }

  createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
          post: PostEntity(
            description: descriptionController.text,
            createAt: Timestamp.now(),
            creatorUid: widget.currentUser.uid,
            likes: [],
            postId: const Uuid().v1(),
            postImageUrl: image,
            totalComments: 0,
            totalLikes: 0,
            username: widget.currentUser.username,
            userProfileUrl: widget.currentUser.profileUrl,
          ),
        )
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      isUploading = false;
      descriptionController.clear();
      imageFile = null;
    });
  }
}
