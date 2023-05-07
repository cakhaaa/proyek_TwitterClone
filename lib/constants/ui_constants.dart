import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyek/constants/constants.dart';
import 'package:proyek/features/explore/view/explore_view.dart';
import 'package:proyek/features/notifications/view/notification_view.dart';
import 'package:proyek/features/tweet/widgets/tweet_list.dart';
import 'package:proyek/theme/theme.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreView(),
    NotificationView(),
  ];
}