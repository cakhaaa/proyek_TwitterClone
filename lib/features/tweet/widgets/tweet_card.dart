import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyek/features/auth/controller/auth_controller.dart';
import 'package:proyek/models/tweet_model.dart';
import 'package:proyek/theme/pallete.dart';

import '../../../common/common.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(tweet.uid)).when(
          data: (user) {
            return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
                radius: 28,
              ),
            ),
            Column(
              children: [
                //code for retweeted
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(
                        '@${user.name}',
                        style: const TextStyle(
                          color: Pallete.greyColor,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ],
    );
          }, 
          error: (error, StackTrace) => ErrorText(
          error: error.toString()
        ), 
        loading: () => const Loader(),); 
  }
}