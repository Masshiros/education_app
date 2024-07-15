import 'package:education_app/core/common/providers/notifications.provider.dart';
import 'package:education_app/core/common/widgets/popup-item.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/src/notifications/presentation/cubit/notifications-cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationOptions extends StatelessWidget {
  const NotificationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationNotifier>(
      builder: (_,notifier,__){
return PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<void>(
              onTap: notifier.toggleMuteNotifications,
              child: PopupItem(
                title: notifier.muteNotifications
                    ? 'Un-mute Notifications'
                    : 'Mute Notifications',
                icon: Icon(
                  notifier.muteNotifications
                      ? Icons.notifications_off_outlined
                      : Icons.notifications_outlined,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: context.read<NotificationsCubit>().clearAll,
              child: const PopupItem(
                title: 'Clear All',
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}