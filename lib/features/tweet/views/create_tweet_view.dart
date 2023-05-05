import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyek/common/common.dart';
import 'package:proyek/constants/assets_constants.dart';
import 'package:proyek/core/utils.dart';
import 'package:proyek/features/auth/controller/auth_controller.dart';
import 'package:proyek/features/tweet/controller/tweet_controller.dart';
import 'package:proyek/theme/pallete.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CreateTweetScreen(),
       );
  const CreateTweetScreen({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier).shareTweet(
          images: images, 
          text: tweetTextController.text, 
          context: context
        );
  }

void onPickImages() async {
  images = await  pickImages();
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;   
    final isLoading = ref.watch(tweetControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          RoundedSmallButton(
            onTap: shareTweet, 
            label: 'Tweet',
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
            ),
        ],
      ),
      body:isLoading || currentUser == null 
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(currentUser.profilePic),
                          radius: 40,
                        ),
                        const SizedBox(width: 35),
                        Expanded(
                          child: TextField(
                            controller: tweetTextController,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                            decoration: const InputDecoration(
                              hintText: "How is your day?",
                              hintStyle: TextStyle(
                                color: Pallete.greyColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                    if(images.isNotEmpty)
                      CarouselSlider(
                      items: images
                      .map(
                        (file) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Image.file(file),
                          );
                        },
                        ).toList(),
                        options: CarouselOptions(
                          height: 400,
                          enableInfiniteScroll: false,
                          ),
                        ),
                  ],
                ),
              ) 
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Pallete.greyColor,
                    width: 0.1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(
                      left: 15,
                      right: 15,
                    ),
                    child: GestureDetector(
                      onTap: onPickImages,
                      child: SvgPicture.asset(AssetsConstants.galleryIcon)
                      ),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(
                      left: 15,
                      right: 15,
                    ),
                    child: SvgPicture.asset(AssetsConstants.gifIcon),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(
                      left: 15,
                      right: 15,
                    ),
                    child: SvgPicture.asset(AssetsConstants.emojiIcon),
                  ),
                ],
              ),
            ),
   );
  }
}