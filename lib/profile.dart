import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_app/components/app_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_app/my_home_page.dart';
import 'package:get_app/list_and_gridview.dart';
import 'package:get_app/greenpoint/partner_store_page.dart';
import 'package:get_app/greenpoint/green_point_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: const Color.fromARGB(255, 244, 253, 0),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 244, 253, 0)),
      ),
      backgroundColor: const Color.fromARGB(
        255,
        0,
        0,
        0,
      ), // Dark premium background
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Header with Gradient Overlay
            Stack(
              children: [
                Image.asset('assets/images/me.jpg', fit: BoxFit.cover),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 244, 253, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "เติ้ล (Tle)",
                          style: GoogleFonts.prompt(
                            textStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Profile Info Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name
                  Text(
                    "จิรศักดิ์ ทองพิละ",
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Text(
                    "Jirasak Thongpila",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle / Education
                  Row(
                    children: [
                      const Icon(
                        Icons.school_outlined,
                        color: Color.fromARGB(255, 255, 246, 0),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "นักศึกษาวิทยาการคอมพิวเตอร์และนวัตกรรม (CSI - ชั้นปีที่ 3)",
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_city_outlined,
                        color: Color.fromARGB(255, 255, 246, 0),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "มหาวิทยาลัยราชภัฏศรีสะเกษ",
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(
                    color: Color.fromARGB(255, 247, 246, 246),
                    thickness: 1,
                  ),
                  const SizedBox(height: 16),

                  // About Me / Bio
                  Text(
                    "เกี่ยวกับฉัน",
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 246, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "นักศึกษา CSI ที่มีความมุ่งมั่นที่จะก้าวสู่การเป็น Software Engineer มืออาชีพ ที่มีความเชี่ยวชาญการพัฒนาเว็บ/โมบายแอปพลิเคชันยุคใหม่ และสามารถใช้งานควบคุมสั่งการ AI ได้อย่างมีประสิทธิภาพ",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Skills & Tools Tags
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Profile selected
        onTap: (index) {
          if (index == 0) {
            Get.offAll(() => const MyHomePage());
          } else if (index == 1) {
            Get.to(() => const PartnerStorePage());
          } else if (index == 2) {
            Get.to(() => const ListAndGridViewPage());
          } else if (index == 4) {
            Get.to(() => const GreenPointPage());
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF111111), // Match dark profile page background
        selectedItemColor: const Color(0xFFF4FD00), // Match profile yellow
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: GoogleFonts.prompt(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: Color.fromARGB(255, 244, 253, 0),
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
