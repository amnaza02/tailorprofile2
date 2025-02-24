import 'package:flutter/material.dart';
import 'package:tailorprofile/screens/edit_profile.dart';
import 'privacy_page.dart';
import 'language_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[50], // لون متناسق
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          _buildListItem(
            icon: Icons.person,
            title: "Account",
            context: context,
            page: const EditProfile(),
          ),
          _buildListItem(
            icon: Icons.lock,
            title: "Privacy",
            context: context,
            page: const PrivacyPage(),
          ),
          _buildListItem(
            icon: Icons.language,
            title: "Language",
            context: context,
            page: const LanguagePage(),
          ),
          _buildListItem(
            icon: Icons.logout,
            title: "Logout",
            context: context,
            page: null, // يمكن إضافة معالجة تسجيل الخروج هنا
          ),
          _buildListItem(
            icon: Icons.delete,
            title: "Delete Account",
            context: context,
            page: null, // يمكن إضافة نافذة تأكيد لحذف الحساب
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    Widget? page,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        } else {
          // تنفيذ الإجراء المطلوب (تسجيل الخروج أو حذف الحساب)
        }
      },
    );
  }
}

