import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/src/auth/data/models/user.model.dart';
import 'package:education_app/src/dashboard/providers/dashboard.provider.dart';
import 'package:education_app/src/dashboard/utils/dashboard-utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});
  static const routeName = '/dashboard';
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
        stream: DashboardUtils.userDataStream,
        builder: (_, snapshot) {
          if (snapshot.hasData || snapshot.data is LocalUserModel) {
            context.userProvider.user = snapshot.data;
          }
          return Consumer<DashBoardProvider>(
            builder: (_, controller, __) {
              return Scaffold(
                body: IndexedStack(
                  index: controller.currentIndex,
                  children: controller.screens,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: controller.currentIndex,
                  showSelectedLabels: false,
                  backgroundColor: Colors.white,
                  elevation: 8,
                  onTap: controller.changeIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 0
                            ? IconlyBold.home
                            : IconlyLight.home,
                        color: controller.currentIndex == 0
                            ? Colours.primaryColour
                            : Colors.grey,
                      ),
                      label: 'Home',
                      backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 1
                            ? IconlyBold.document
                            : IconlyLight.document,
                        color: controller.currentIndex == 1
                            ? Colours.primaryColour
                            : Colors.grey,
                      ),
                      label: 'Materials',
                      backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 2
                            ? IconlyBold.chat
                            : IconlyLight.chat,
                        color: controller.currentIndex == 2
                            ? Colours.primaryColour
                            : Colors.grey,
                      ),
                      label: 'Chat',
                      backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 3
                            ? IconlyBold.profile
                            : IconlyLight.profile,
                        color: controller.currentIndex == 3
                            ? Colours.primaryColour
                            : Colors.grey,
                      ),
                      label: 'User',
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
