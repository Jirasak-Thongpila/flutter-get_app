import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_app/my_home_page.dart';
import 'package:get_app/profile.dart';
import 'package:get_app/list_and_gridview.dart';
import 'package:get_app/greenpoint/green_point_page.dart';
import 'package:get_app/greenpoint/partner_store_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF8A84FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/me.jpg',
                  fit: BoxFit.cover,
                  width: 68,
                  height: 68,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    color: Color(0xFF6C63FF),
                    size: 32,
                  ),
                ),
              ),
            ),
            accountName: Text(
              'เติ้ล (Tle)',
              style: GoogleFonts.prompt(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            accountEmail: Text(
              'นักศึกษา CSI ปี 3',
              style: GoogleFonts.prompt(
                textStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home_rounded,
            title: 'หน้าแรก (Home)',
            color: const Color(0xFF6C63FF),
            onTap: () => Get.offAll(() => const MyHomePage()),
          ),
          _buildDrawerItem(
            icon: Icons.person_rounded,
            title: 'ข้อมูลส่วนตัว (Profile)',
            color: const Color(0xFF6C63FF),
            onTap: () {
              Get.back();
              Get.to(() => const ProfilePage());
            },
          ),
          _buildDrawerItem(
            icon: Icons.grid_view_rounded,
            title: 'รายการข้อมูล (List & Grid)',
            color: const Color(0xFF00B4D8),
            onTap: () {
              Get.back();
              Get.to(() => const ListAndGridViewPage());
            },
          ),
          const Divider(height: 16, thickness: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              'งานเสริมที่ส่งคู่กัน (GreenPoint)',
              style: GoogleFonts.prompt(
                textStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.eco_rounded,
            title: 'สะสมคะแนน (GreenPoint)',
            color: const Color(0xFF2E7D32),
            onTap: () {
              Get.back();
              Get.to(() => const GreenPointPage());
            },
          ),
          _buildDrawerItem(
            icon: Icons.storefront_rounded,
            title: 'ร้านค้าพันธมิตร (Store)',
            color: const Color(0xFFF39C12),
            onTap: () {
              Get.back();
              Get.to(() => const PartnerStorePage());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 24),
      title: Text(
        title,
        style: GoogleFonts.prompt(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2C3E50),
          ),
        ),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
