import 'package:education_app/core/common/providers/user.provider.dart';
import 'package:education_app/core/global/media.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("My Classes"),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        const Icon(IconlyLight.notification),
        Consumer<UserProvider>(builder: (_, provider, __) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: provider.user!.profilePic != null
                  ? NetworkImage(provider.user!.profilePic!)
                  : const AssetImage(MediaRes.user) as ImageProvider,
            ),
          );
        })
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
