import 'package:flutter/material.dart';
import 'package:proyek/theme/pallete.dart';
import '../../../models/user_model.dart';

class SearchTile extends StatelessWidget {
  final UserModel userModel;
  const SearchTile({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userModel.profilePic),
        radius: 30,
        ),
        title: Text(
          userModel.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '@${userModel.name}',
            style: const TextStyle(
              fontSize: 15,
          ),
        ),
        Text(
            userModel.bio,
            style: const TextStyle(
              color: Pallete.whiteColor,
          ),
        ),
      ],
    ),
   );
  }
}