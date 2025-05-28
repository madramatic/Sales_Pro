import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedIconTheme: const IconThemeData(size: 24),
        selectedLabelStyle: const TextStyle(height: 1.8),
        unselectedLabelStyle: const TextStyle(height: 1.8),
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSecondary,
        currentIndex: currentIndex,
        onTap: onTap,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.home_outlined),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.chat_bubble_outline),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.navigation),
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.groups_outlined),
            ),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.person_outline),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
