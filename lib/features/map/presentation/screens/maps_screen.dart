import 'package:flutter/material.dart';
import 'package:sales_pro/shared/presentation/widgets/bottom_navbar.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  int _currentIndex = 2;

  void _onNavTap(int index) {
    if (index != 2) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: const Center(
          child: Text('Maps Screen', style: TextStyle(fontSize: 24))),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
