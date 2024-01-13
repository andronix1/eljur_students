import 'package:auto_route/auto_route.dart';
import 'package:eljur_students/router/app_router.dart';
import 'package:flutter/material.dart';

class _NavigationDestinationInfo {
  final IconData icon;
  final String label;
  final PageRouteInfo<dynamic> route;

  _NavigationDestinationInfo(
      {required this.icon, required this.label, required this.route});
}

@RoutePage()
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  final List<_NavigationDestinationInfo> _info = [
    _NavigationDestinationInfo(
        icon: Icons.schedule,
        label: "Расписание",
        route: const DiaryViewRoute()),
    _NavigationDestinationInfo(
        icon: Icons.settings, label: "Настройки", route: const SettingsRoute()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(child: AutoRouter()),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
            context.navigateTo(_info[index].route);
          },
          destinations: _info
              .map((info) => NavigationDestination(
                  icon: Icon(info.icon), label: info.label))
              .toList()),
    );
  }
}
