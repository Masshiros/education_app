import 'package:badges/badges.dart';
import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/common/widgets/nested-back-button.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/notifications/presentation/cubit/notifications-cubit.dart';
import 'package:education_app/src/notifications/presentation/widgets/no-notifications.widgets.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification-tile.widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
        leading: const NestedBackButton(),
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationError) {
            CoreUtils.showSnackBar(context, state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is GettingNotifications) {
            return const LoadingView();
          } else if (state is NotificationsLoaded &&
              state.notifications.isEmpty) {
            return const NoNotifications();
          } else if (state is NotificationsLoaded) {
            return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (_, index) {
                  final notification = state.notifications[index];
                  return Badge(
                    showBadge: !notification.seen,
                    position: BadgePosition.topEnd(top: 30, end: 20),
                    child: BlocProvider.value(
                      value: getIt<NotificationsCubit>(),
                      child: NotificationTile(notification),
                    ),
                  );
                });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
