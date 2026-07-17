import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_app/components/app_drawer.dart';
import 'package:get_app/profile.dart';
import 'package:get_app/list_and_gridview.dart';
import 'package:get_app/greenpoint/green_point_page.dart';
import 'package:get_app/greenpoint/partner_store_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentCampaignPage = 0;
  late final PageController _campaignController;

  final List<Map<String, dynamic>> _campaigns = [
    {
      "thaiTitle": "อัปเดตแอปพลิเคชัน v2.0",
      "description": "ปรับปรุงหน้าต่างผู้ใช้งานใหม่ให้ตอบสนองเร็วขึ้น ปรับแต่ง UI ให้มีความเป็นโมเดิร์น และเพิ่มความเสถียรของระบบ",
      "tag": "Update",
      "gradient": [const Color(0xFF6C63FF), const Color(0xFF8E2DE2)],
      "icon": Icons.security_update_good_rounded,
      "actionText": "รายละเอียด",
    },
    {
      "thaiTitle": "แนะนำฟีเจอร์ List & Grid View",
      "description": "เรียนรู้วิธีการจัดเรียงรูปแบบข้อมูลและการเลือกแสดงผลแบบตาราง/รายการ เพื่อการทำงานที่สะดวกยิ่งขึ้น",
      "tag": "Feature Guide",
      "gradient": [const Color(0xFF007799), const Color(0xFF00B4D8)],
      "icon": Icons.grid_view_rounded,
      "actionText": "เริ่มสำรวจ",
    },
    {
      "thaiTitle": "เรียนรู้ GetX State Management",
      "description": "ศึกษาเทคนิคการจัดการ State, Reactive programming และการใช้งาน Dependency Injection อย่างง่าย",
      "tag": "Dev Tips",
      "gradient": [const Color(0xFFE65100), const Color(0xFFFF9800)],
      "icon": Icons.code_rounded,
      "actionText": "ดูข้อมูล",
    },
  ];

  @override
  void initState() {
    super.initState();
    _campaignController = PageController(viewportFraction: 0.92, initialPage: 0);
  }

  @override
  void dispose() {
    _campaignController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2C3E50)),
        title: Text(
          "Get App",
          style: GoogleFonts.prompt(
            textStyle: const TextStyle(
              color: Color(0xFF2C3E50),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const ProfilePage()),
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 8),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF6C63FF),
                backgroundImage: const AssetImage('assets/images/me.jpg'),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/me.jpg',
                    fit: BoxFit.cover,
                    width: 36,
                    height: 36,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade100, height: 1),
        ),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // 1. Eco Campaign Carousel
            _buildCampaignCarousel(),
            
            const SizedBox(height: 24),
            
            // 2. Features Grid Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "เมนูการใช้งาน",
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grid View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildMenuCard(
                    icon: Icons.person_rounded,
                    title: "โปรไฟล์ของฉัน",
                    subtitle: "ดูข้อมูลและทักษะผู้พัฒนา",
                    color: const Color(0xFF6C63FF),
                    onTap: () => Get.to(() => const ProfilePage()),
                  ),
                  _buildMenuCard(
                    icon: Icons.grid_view_rounded,
                    title: "รายการข้อมูล",
                    subtitle: "List & Grid View",
                    color: const Color(0xFF00B4D8),
                    onTap: () => Get.to(() => const ListAndGridViewPage()),
                  ),
                  _buildMenuCard(
                    icon: Icons.eco_rounded,
                    title: "GreenPoint",
                    subtitle: "ระบบสะสมแต้มรักษ์โลก",
                    color: const Color(0xFF2E7D32),
                    onTap: () => Get.to(() => const GreenPointPage()),
                  ),
                  _buildMenuCard(
                    icon: Icons.storefront_rounded,
                    title: "ร้านค้าพันธมิตร",
                    subtitle: "ดูร้านค้าพาร์ทเนอร์",
                    color: const Color(0xFFF39C12),
                    onTap: () => Get.to(() => const PartnerStorePage()),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => const PartnerStorePage());
          } else if (index == 2) {
            Get.to(() => const ListAndGridViewPage());
          } else if (index == 3) {
            Get.to(() => const ProfilePage());
          } else if (index == 4) {
            Get.to(() => const GreenPointPage());
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: GoogleFonts.prompt(
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        unselectedLabelStyle: GoogleFonts.prompt(
          textStyle: const TextStyle(fontSize: 10),
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

  Widget _buildCampaignCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ข่าวสารและอัปเดตล่าสุด",
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "ดูทั้งหมด",
                  style: GoogleFonts.prompt(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _campaignController,
            onPageChanged: (int index) {
              setState(() {
                _currentCampaignPage = index;
              });
            },
            itemCount: _campaigns.length,
            itemBuilder: (context, index) {
              final campaign = _campaigns[index];
              return AnimatedBuilder(
                animation: _campaignController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_campaignController.position.haveDimensions) {
                    value = (_campaignController.page ?? 0) - index;
                    value = (1 - (value.abs() * 0.05)).clamp(0.0, 1.0);
                  }
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: _buildCampaignCard(campaign),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _campaigns.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: _currentCampaignPage == index ? 18 : 6,
              decoration: BoxDecoration(
                color: _currentCampaignPage == index
                    ? const Color(0xFF6C63FF)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    final List<Color> gradientColors = campaign["gradient"] as List<Color>;
    return GestureDetector(
      onTap: () {
        if (campaign["thaiTitle"] == "แนะนำฟีเจอร์ List & Grid View") {
          Get.to(() => const ListAndGridViewPage());
        } else if (campaign["thaiTitle"] == "เรียนรู้ GetX State Management") {
          Get.to(() => const ProfilePage());
        } else {
          Get.defaultDialog(
            title: "อัปเดตเวอร์ชัน 2.0",
            titleStyle: GoogleFonts.prompt(
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  const Icon(Icons.verified_rounded, color: Color(0xFF6C63FF), size: 48),
                  const SizedBox(height: 12),
                  Text(
                    "เวอร์ชันล่าสุดรองรับการใช้งานที่ดีขึ้น การจัดการ State ที่ลื่นไหล และหน้าตาผู้ใช้งานสุดทันสมัยเพื่อคุณโดยเฉพาะ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.prompt(textStyle: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            textConfirm: "ตกลง",
            confirmTextColor: Colors.white,
            buttonColor: const Color(0xFF6C63FF),
            onConfirm: () => Get.back(),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Decorative shapes
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 40,
                bottom: -50,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tag and Title
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  campaign["tag"],
                                  style: GoogleFonts.prompt(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                campaign["thaiTitle"],
                                style: GoogleFonts.prompt(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Subtitle / Description
                          Text(
                            campaign["description"],
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 11,
                                height: 1.3,
                              ),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Icon and Action Button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            campaign["icon"],
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        
                        // Action Button
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            campaign["actionText"],
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                color: gradientColors[0],
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.prompt(
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
