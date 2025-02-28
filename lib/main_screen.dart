import 'package:flutter/material.dart';
import 'package:tailorprofile/screens/manage_orders.dart';
import 'package:tailorprofile/screens/notification.dart';
import 'package:tailorprofile/screens/post_new_work.dart';
import 'package:tailorprofile/screens/settings.dart';
import 'package:tailorprofile/tailor_profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Stores the selected tab index

  // List of pages to display in the bottom navigation
  final List<Widget> _pages = [
    const TailorProfilePage(),
    const ManageOrders(),
    const NewPostScreen(),
    const SettingsPage(),
    const NotificationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor:   const Color.fromARGB(255, 163, 119, 178), // Active item color
        unselectedItemColor:const Color.fromARGB(255, 106, 106, 105), // Inactive item color
        iconSize: 30, // Icon size
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''), 
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: ''), 
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: ''), 
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: ''),
        ],
      ),
    );
  }
}
