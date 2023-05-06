import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyek/common/common.dart';
import 'package:proyek/features/tweet/controller/tweet_controller.dart';
import 'package:proyek/features/tweet/widgets/tweet_card.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetProvider).when(
        data: (tweets) {
          return ListView.builder(
            itemCount: tweets.length,
            itemBuilder: (BuildContext context, int index) {
              final tweet = tweets[index];
              return TweetCard(tweet: tweet);
            },
          );
        }, 
        error: (error, StackTrace) => ErrorText(
          error: error.toString()
        ), 
        loading: () => const Loader(),
      );
  }
}