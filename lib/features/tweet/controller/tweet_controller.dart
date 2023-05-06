import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyek/apis/storage_api.dart';
import 'package:proyek/apis/tweet_api.dart';
import 'package:proyek/core/enums/tweet_type_enum.dart';
import 'dart:io';
import 'package:proyek/core/utils.dart';
import 'package:proyek/features/auth/controller/auth_controller.dart';
import 'package:proyek/models/tweet_model.dart';

final tweetControllerProvider = 
    StateNotifierProvider<TweetController, bool>((ref) {
      return TweetController(
        ref: ref, 
        tweetAPI: ref.watch(tweetAPIProvider),
        storageAPI: ref.watch(storageAPIProvider),
        );
    },
  );

  final getTweetProvider = FutureProvider((ref) {
    final tweetController = ref.watch(tweetControllerProvider.notifier);
    return tweetController.getTweets();
  });

class TweetController extends StateNotifier<bool> {
  final TweetAPI _tweetAPI;
  final StorageAPI _storageAPI;
  final Ref _ref;
  TweetController({
    required Ref ref,
    required TweetAPI tweetAPI,
    required StorageAPI storageAPI,
  }) : _ref = ref,
       _tweetAPI = tweetAPI,
       _storageAPI = storageAPI,
       super(false);

       Future<List<Tweet>> getTweets() async {
        final tweetList = await _tweetAPI.getTweets();
        return tweetList.map((tweet) => Tweet.fromMap(tweet.data)).toList();
       }

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }

    if(images.isNotEmpty) {
      _shareImageTweet(
        images: images, 
        text: text, 
        context: context,
        );
    } else {

      _shareTextTweet(
        images: images, 
        text: text, 
        context: context,
        );
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    final imageLinks = await _storageAPI.uploadImage(images);
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: imageLinks,
      uid: user.uid,
      tweetType: TweetType.image,
      tweetedAt: DateTime.now(),
      likes: const[],
      commentIds: const[],
      id: '',
      reshareCount: 0, 
      repliedTo: '', 
      retweetedBy: '',
    );
   final res = await _tweetAPI.shareTweet(tweet);
   state = false;
   res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  Future<void> _shareTextTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: const[],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: const[],
      commentIds: const[],
      id: '',
      reshareCount: 0, 
      repliedTo: '', 
      retweetedBy: '',
    );
   final res = await _tweetAPI.shareTweet(tweet);
   state = false;
   res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordInSentence = text.split('');
    for (String word in wordInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordInSentence = text.split('');
    for (String word in wordInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}