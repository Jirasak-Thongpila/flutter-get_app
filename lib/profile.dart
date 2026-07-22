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
      backgroundColor: const Color(0xFFF8FAFC), // Modern Slate 50 background
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'โปรไฟล์ของฉัน',
          style: GoogleFonts.prompt(
            textStyle: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profile Card
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A0F172A),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Avatar with Ring Shadow
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0F172A), Color(0xFF0D9488)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0D9488).withValues(alpha: 0.25),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/me.jpg',
                            fit: BoxFit.cover,
                            width: 94,
                            height: 94,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 50, color: Color(0xFF0F172A)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Display Name
                  Text(
                    "เติ้ล (Tle)",
                    style: GoogleFonts.prompt(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "นายจิรศักดิ์ ทองพิละ • Jirasak Thongpila",
                    style: GoogleFonts.prompt(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Student ID Badge
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.badge_outlined,
                          size: 16,
                          color: Color(0xFF0D9488),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "รหัสนักศึกษา: 6712732103",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Profile Details Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Education Card
                  _buildSectionCard(
                    title: "การศึกษา",
                    icon: Icons.school_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          icon: Icons.auto_awesome_rounded,
                          title: "สาขาวิชา",
                          subtitle: "วิทยาการคอมพิวเตอร์และนวัตกรรม (CSI - ชั้นปีที่ 3)",
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Color(0xFFF1F5F9), height: 1),
                        ),
                        _buildInfoRow(
                          icon: Icons.account_balance_outlined,
                          title: "สถาบันการศึกษา",
                          subtitle: "มหาวิทยาลัยราชภัฏศรีสะเกษ",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // About Me Card
                  _buildSectionCard(
                    title: "เกี่ยวกับฉัน",
                    icon: Icons.person_outline_rounded,
                    child: Text(
                      "นักศึกษา CSI ที่มีความมุ่งมั่นที่จะก้าวสู่การเป็น Software Engineer มืออาชีพ เชี่ยวชาญการพัฒนาเว็บ/โมบายแอปพลิเคชันยุคใหม่ (Next.js, Flutter) และมีความสามารถในการใช้งานควบคุมสั่งการ AI Agent ได้อย่างมีประสิทธิภาพ",
                      style: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF475569),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Skills & Expertise Card
                  _buildSectionCard(
                    title: "ทักษะและความเชี่ยวชาญ",
                    icon: Icons.code_rounded,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        _SkillChip(label: "Flutter", color: Color(0xFF02569B)),
                        _SkillChip(label: "Next.js", color: Color(0xFF000000)),
                        _SkillChip(label: "GetX State Management", color: Color(0xFF8E2DE2)),
                        _SkillChip(label: "AI Agent Orchestration", color: Color(0xFF0D9488)),
                        _SkillChip(label: "Modern UI/UX", color: Color(0xFF6C63FF)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),
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
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0F172A),
        unselectedItemColor: const Color(0xFF94A3B8),
        selectedLabelStyle: GoogleFonts.prompt(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: Color(0xFF0F172A),
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
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            activeIcon: Icon(Icons.storefront_rounded),
            label: 'Partner Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view_rounded),
            label: 'List & Grid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco_outlined),
            activeIcon: Icon(Icons.eco_rounded),
            label: 'Profile GP',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x050F172A),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: const Color(0xFF0F172A)),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF64748B)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.prompt(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final Color color;

  const _SkillChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.prompt(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

