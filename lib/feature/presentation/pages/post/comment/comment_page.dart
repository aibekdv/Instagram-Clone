import 'package:flutter/material.dart';
import 'package:insta_clone/common/app_colors.dart';
import 'package:insta_clone/common/sized_func.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool _isReply = false;
  bool _isViewReply = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text("Comments"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/profile_default.jpg"),
                        radius: 20,
                      ),
                      title: Text("aibek7_official"),
                    ),
                    const Text(
                      "In the builder param remove scrollController and use ModalScrollController.of(context) instead to access the modal's scrollController. Check the CHANGELOG for more information",
                    ),
                    sizedVertical(10),
                    const Divider(
                      thickness: 1,
                      color: AppColors.secondaryColor,
                    ),
                    sizedVertical(10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/profile_default.jpg"),
                          radius: 20,
                        ),
                        sizedHorizontal(10),
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              sizedVertical(4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "aibek7_official",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.favorite_outline,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              sizedVertical(6),
                              const Text(
                                "В параметре построителя удалите scrollController и вместо этого используйте ModalScrollController.of(context) для доступа к модальному scrollController. Проверьте CHANGELOG для получения дополнительной информации",
                              ),
                              sizedVertical(10),
                              Row(
                                children: [
                                  const Text(
                                    "31.02.2022",
                                    style: TextStyle(
                                      color: AppColors.darkGreyColor,
                                    ),
                                  ),
                                  sizedHorizontal(10),
                                  GestureDetector(
                                    onTap: () {
                                      _isReply = !_isReply;
                                      setState(() {});
                                    },
                                    child: Text(
                                      _isReply ? "Cancel reply" : "Reply",
                                      style: const TextStyle(
                                        color: AppColors.darkGreyColor,
                                      ),
                                    ),
                                  ),
                                  sizedHorizontal(10),
                                  GestureDetector(
                                    onTap: () {
                                      _isViewReply = !_isViewReply;
                                      setState(() {});
                                    },
                                    child: Text(
                                      _isViewReply
                                          ? "Hide replies"
                                          : "View replies",
                                      style: const TextStyle(
                                        color: AppColors.darkGreyColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sizedVertical(10),
                              if (_isReply)
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.darkGreyColor.withOpacity(.8),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              prefixIcon: GestureDetector(
                                                onTap: () {
                                                  _isReply = false;
                                                  setState(() {});
                                                },
                                                child: const Icon(Icons.close),
                                              ),
                                              hintText:
                                                  "Enter your comment here...",
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  debugPrint("Posted post");
                                                },
                                                child: const Icon(
                                                  Icons.check,
                                                  color: AppColors.blueColor,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (_isViewReply)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/profile_default.jpg"),
                                      radius: 20,
                                    ),
                                    sizedHorizontal(10),
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          sizedVertical(4),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "aibek7_official",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.favorite_outline,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          sizedVertical(6),
                                          const Text(
                                            "В параметре построителя удалите scrollController и вместо этого используйте ModalScrollController.of(context) для доступа к модальному scrollController. Проверьте CHANGELOG для получения дополнительной информации",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          if (!_isReply)
            Container(
              color: AppColors.darkGreyColor.withOpacity(.8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/profile_default.jpg"),
                    radius: 18,
                  ),
                  sizedHorizontal(10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your comment here...",
                      ),
                    ),
                  ),
                  const Text(
                    "Post",
                    style: TextStyle(
                      color: AppColors.blueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
