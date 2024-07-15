import 'package:audioplayers/audioplayers.dart';
import 'package:badges/badges.dart';
import 'package:education_app/core/common/providers/notifications.provider.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/src/notifications/presentation/cubit/notifications-cubit.dart';
import 'package:education_app/src/notifications/presentation/views/notification.views.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  final newNotificationListenable = ValueNotifier<bool>(false);
  int? notificationCount;
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().getNotifications();
    newNotificationListenable.addListener(() {
      if (newNotificationListenable.value) {
        if (!context.read<NotificationNotifier>().muteNotifications) {
          player.play(AssetSource('sounds/notification.mp3'));
        }
        newNotificationListenable.value = false;
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (_, state) {
        if (state is NotificationsLoaded) {
          if (notificationCount != null) {
            if (notificationCount! < state.notifications.length) {
              newNotificationListenable.value = true;
            }
          }
          notificationCount = state.notifications.length;
        }
      },
      builder: (context, state) {
        if (state is NotificationsLoaded) {
          final unseenNotificationsLength =
              state.notifications.where((el) => !el.seen).length;
          final showBadge = unseenNotificationsLength > 0;
          return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  context.push(
                    BlocProvider(
                      create: (_) => getIt<NotificationsCubit>(),
                      child: const NotificationsView(),
                    ),
                  );
                },
                child: Badge(
                  showBadge: showBadge,
                  position: BadgePosition.topEnd(end: -1),
                  badgeContent: Text(
                    unseenNotificationsLength.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
              ));
        }
        return const Icon(IconlyLight.notification);
      },
    );
  }
}
