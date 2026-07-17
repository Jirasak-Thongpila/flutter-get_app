import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_app/components/app_drawer.dart';
import 'package:get_app/my_home_page.dart';
import 'package:get_app/list_and_gridview.dart';
import 'package:get_app/greenpoint/partner_store_page.dart';
import 'package:get_app/profile.dart';
import 'widgets/profile_card.dart';
import 'widgets/eco_mascot_banner.dart';
import 'widgets/streak_card.dart';
import 'widgets/achievements_card.dart';
import 'widgets/transaction_history_card.dart';

class GreenPointPage extends StatefulWidget {
  const GreenPointPage({super.key});

  @override
  State<GreenPointPage> createState() => _GreenPointPageState();
}

class _GreenPointPageState extends State<GreenPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco, color: Color(0xFF2E7D32), size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              "GreenPoint",
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black87,
                  size: 26,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade100, height: 1),
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // 1. Profile Card
              ProfileCard(),
              SizedBox(height: 16),

              // 2. Mascot Speech Bubble Banner
              EcoMascotBanner(),
              SizedBox(height: 16),

              // 3. Streak Card
              StreakCard(),
              SizedBox(height: 16),

              // 4. Achievements Section
              AchievementsCard(),
              SizedBox(height: 16),

              // 5. Transaction History Section
              TransactionHistoryCard(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Profile GP selected
        onTap: (index) {
          if (index == 0) {
            Get.offAll(() => const MyHomePage());
          } else if (index == 1) {
            Get.to(() => const PartnerStorePage());
          } else if (index == 2) {
            Get.to(() => const ListAndGridViewPage());
          } else if (index == 3) {
            Get.to(() => const ProfilePage());
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: GoogleFonts.prompt(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        unselectedLabelStyle: GoogleFonts.prompt(
          textStyle: const TextStyle(
            fontSize: 10,
          ),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront),
            label: 'Partner Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view_rounded),
            label: 'List & Grid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco_outlined),
            activeIcon: Icon(Icons.eco),
            label: 'Profile GP',
          ),
        ],
      ),
    );
  }
}
