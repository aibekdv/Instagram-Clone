import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/firebase_consts.dart';
import 'package:insta_clone/common/sized_func.dart';
import 'package:insta_clone/feature/domain/entities/entities.dart';
import 'package:insta_clone/feature/domain/usecases/usecases.dart';
import 'package:insta_clone/feature/presentation/cubit/cubit.dart';
import 'package:insta_clone/feature/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:insta_clone/feature/presentation/widgets/profile_image_widget.dart';
import 'package:insta_clone/injection_container.dart' as di;

class UpdatePostWidget extends StatefulWidget {
  final PostEntity post;
  const UpdatePostWidget({super.key, required this.post});

  @override
  State<UpdatePostWidget> createState() => _UpdatePostWidgetState();
}

class _UpdatePostWidgetState extends State<UpdatePostWidget> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    descriptionController.text = widget.post.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  File? image;
  bool? uploading = false;
  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.primaryColor,
          ),
          splashRadius: 25,
        ),
        actions: [
          IconButton(
            onPressed: _updatePost,
            icon: const Icon(
              Icons.check,
              color: AppColors.blueColor,
            ),
            splashRadius: 25,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              sizedVertical(10),
              Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: profileWidget(imageUrl: widget.post.userProfileUrl),
                  ),
                ),
              ),
              sizedVertical(10),
              Text(
                widget.post.username ?? "Username",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedVertical(15),
              GestureDetector(
                onTap: selectImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: image == null
                        ? widget.post.postImageUrl!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(widget.post.postImageUrl!),
                                fit: BoxFit.cover,
                              )
                            : null
                        : DecorationImage(
                            image: FileImage(image!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: const Center(child: Icon(Icons.edit)),
                ),
              ),
              sizedVertical(15),
              ProfileFormWidget(
                  title: "Description", controller: descriptionController),
              sizedVertical(15),
              uploading == true
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

  _updatePost() {
    setState(() {
      uploading = true;
    });
    if (image == null) {
      _submitUpdatePost(image: widget.post.postImageUrl!);
    } else {
      di
          .sl<UploadImageToStorageUsecase>()
          .call(image!, true, "posts")
          .then((imageUrl) {
        _submitUpdatePost(image: imageUrl);
      });
    }
  }

  _submitUpdatePost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .updatePost(
            post: PostEntity(
                creatorUid: widget.post.creatorUid,
                postId: widget.post.postId,
                postImageUrl: image,
                description: descriptionController.text))
        .then((value) => _clear());
  }

  _clear() {
    setState(() {
      descriptionController.clear();
      Navigator.pop(context);
      uploading = false;
    });
  }
}
