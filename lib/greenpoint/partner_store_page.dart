import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_app/components/app_drawer.dart';
import 'package:get_app/my_home_page.dart';
import 'package:get_app/list_and_gridview.dart';
import 'package:get_app/greenpoint/green_point_page.dart';
import 'package:get_app/profile.dart';
import 'models/store.dart';
import 'widgets/map_road_painter.dart';

class PartnerStorePage extends StatefulWidget {
  const PartnerStorePage({super.key});

  @override
  State<PartnerStorePage> createState() => _PartnerStorePageState();
}

class _PartnerStorePageState extends State<PartnerStorePage> {
  String _selectedCategory = 'ทั้งหมด';
  bool _isListView = true; // True for "รายชื่อร้าน", False for "แผนที่"
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _isRecommendedFavored = false;

  // Mock list of stores matching the layout screenshot
  final List<Store> _stores = const [
    Store(
      id: 'store_11',
      name: '11',
      rating: 4.8,
      reviewsCount: 124,
      category: 'คาเฟ่',
      distanceKm: 116.4,
      points: 0,
      totalItems: 8,
      imageUrl: 'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=400',
      tags: ['รักษ์โลก', 'Eco-Friendly', 'แก้วพกพา'],
      isVerified: true,
    ),
    Store(
      id: 'store_g1',
      name: 'G1',
      rating: 4.3,
      reviewsCount: 99,
      category: 'คาเฟ่',
      distanceKm: 116.5,
      points: 0,
      totalItems: 0,
      imageUrl: 'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=200',
      tags: ['รักษ์โลก', 'Eco-Friendly', 'แก้วพกพา'],
      isVerified: true,
    ),
    Store(
      id: 'store_light_up',
      name: 'Light up cafe x Nimman',
      rating: 4.2,
      reviewsCount: 22,
      category: 'คาเฟ่',
      distanceKm: 115.5,
      points: 0,
      totalItems: 0,
      imageUrl: 'lock', // Represent locked state as special tag
      tags: ['รักษ์โลก', 'Eco-Friendly', 'ไม้พกพาถุง'],
      isVerified: true,
      isLocked: true,
    ),
    Store(
      id: 'store_green_garden',
      name: 'Green Garden Salad',
      rating: 4.9,
      reviewsCount: 142,
      category: 'ร้านอาหาร',
      distanceKm: 114.2,
      points: 15,
      totalItems: 3,
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200',
      tags: ['รักษ์โลก', 'กล่องข้าวส่วนตัว'],
      isVerified: true,
    ),
    Store(
      id: 'store_eco_grocer',
      name: 'Eco Mart & Shopping',
      rating: 4.5,
      reviewsCount: 68,
      category: 'ช้อปปิ้ง',
      distanceKm: 117.1,
      points: 30,
      totalItems: 5,
      imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=200',
      tags: ['ไม่รับถุงพลาสติก', 'Eco-Friendly'],
      isVerified: true,
    ),
  ];

  List<Store> get _filteredStores {
    return _stores.where((store) {
      // Category Filter
      final matchesCategory = _selectedCategory == 'ทั้งหมด' || store.category == _selectedCategory;
      // Search Query Filter
      final matchesSearch = store.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          store.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          store.tags.any((tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showStoreDetail(Store store) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            children: [
              // Pull indicator
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Header title
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              store.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E3A31),
                              ),
                            ),
                            if (store.isVerified) ...[
                              const SizedBox(width: 6),
                              const Icon(Icons.check_circle, color: Color(0xFF107C41), size: 20),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${store.rating} (${store.reviewsCount} รีวิว)',
                              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                            ),
                            const SizedBox(width: 8),
                            const Text('•', style: TextStyle(color: Colors.grey)),
                            const SizedBox(width: 8),
                            Text(
                              store.category,
                              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${store.distanceKm} km',
                      style: const TextStyle(
                        color: Color(0xFF107C41),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Point system card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F9F5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE1EFE5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars, color: Color(0xFF107C41), size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'คะแนนสะสมของคุณ',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            '${store.points} GP จาก ${store.totalItems} รายการ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF107C41),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF107C41),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text('แลกรางวัล', style: TextStyle(fontSize: 12)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Tags
              const Text(
                'นโยบายรักษ์โลกของร้าน',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: store.tags.map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFF107C41).withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Color(0xFF107C41),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Details Mock Info
              const Text(
                'ข้อมูลร้านค้า',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.location_on_outlined, color: Colors.grey),
                title: const Text('ที่ตั้งร้าน', style: TextStyle(fontSize: 14)),
                subtitle: Text('123 ถนนนิมมานเหมินท์ ซอย 9 ต.สุเทพ อ.เมือง เชียงใหม่', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.access_time, color: Colors.grey),
                title: const Text('เวลาเปิด-ปิด', style: TextStyle(fontSize: 14)),
                subtitle: Text('เปิดบริการทุกวัน 08:00 - 18:00 น.', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              ),
              const SizedBox(height: 24),
              // Green action button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF107C41),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('ตกลง', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. App Header
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20, top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // GreenPoint Brand logo + Drawer trigger
                    Row(
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu, color: Colors.black87),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF107C41),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'GreenPoint',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF107C41),
                          ),
                        ),
                      ],
                    ),
                    // Notification Bell with Badge
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('ไม่มีการแจ้งเตือนใหม่ในขณะนี้'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            size: 28,
                            color: Colors.black87,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
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

              // 2. Search & Filter Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3F2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 10),
                        child: Icon(Icons.search, color: Colors.grey, size: 22),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val;
                            });
                          },
                          style: const TextStyle(fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'ค้นหาร้านค้า, ประเภท, สถานที่...',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchQuery = '';
                              _searchController.clear();
                            });
                          },
                          child: const Icon(Icons.close, color: Colors.grey, size: 18),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 10),
                        child: Icon(
                          Icons.tune,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // 3. Category Horizontal Filters
              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCategoryChip('ทั้งหมด', Icons.grid_view_rounded),
                    _buildCategoryChip('คาเฟ่', Icons.local_cafe_outlined),
                    _buildCategoryChip('ร้านอาหาร', Icons.restaurant_outlined),
                    _buildCategoryChip('ช้อปปิ้ง', Icons.shopping_bag_outlined),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 4. Sub-Tab Selector ("รายชื่อร้าน" vs "แผนที่")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSubTabItem('รายชื่อร้าน', _isListView),
                    ),
                    Expanded(
                      child: _buildSubTabItem('แผนที่', !_isListView),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 5. Dynamic Content (List View vs Map View)
              _isListView ? _buildStoreListContent() : _buildMapViewContent(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Partner Store selected
        onTap: (index) {
          if (index == 0) {
            Get.offAll(() => const MyHomePage());
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

  // Helper widget for category filter chips
  Widget _buildCategoryChip(String categoryName, IconData iconData) {
    final isSelected = _selectedCategory == categoryName;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = categoryName;
          });
        },
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF107C41) : Colors.white,
            border: Border.all(
              color: isSelected ? const Color(0xFF107C41) : Colors.grey.shade200,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                categoryName,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for Sub-Tabs selector
  Widget _buildSubTabItem(String title, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          _isListView = title == 'รายชื่อร้าน';
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF107C41) : Colors.grey.shade600,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF107C41) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // Content for "รายชื่อร้าน" Tab
  Widget _buildStoreListContent() {
    final recommendedStore = _stores.firstWhere((element) => element.id == 'store_11');
    final otherStores = _filteredStores.where((element) => element.id != 'store_11').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Recommended Card
        if (_searchQuery.isEmpty && (_selectedCategory == 'ทั้งหมด' || _selectedCategory == 'คาเฟ่'))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1FAF4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD4EFE0), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Green Badge "ร้านที่คุณสนับสนุนมากที่สุด"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: const Color(0xFFD4EFE0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.eco, color: Color(0xFF107C41), size: 12),
                        const SizedBox(width: 4),
                        Text(
                          'ร้านที่คุณสนับสนุนมากที่สุด',
                          style: GoogleFonts.prompt(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF107C41),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Store Info Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Store Main Description (Left)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  recommendedStore.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF222B24),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF107C41),
                                  size: 18,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  '${recommendedStore.rating} | ${recommendedStore.category} | ${recommendedStore.distanceKm} km',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Accumulated Points Bar
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () => _showStoreDetail(recommendedStore),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'แต้มสะสมจากร้านนี้',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${recommendedStore.points} GP จาก ${recommendedStore.totalItems} รายการ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF107C41),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Store Image & Action Button (Right)
                      Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  recommendedStore.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.fastfood, color: Colors.white),
                                  ),
                                ),
                              ),
                              // Favorite Heart Icon
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isRecommendedFavored = !_isRecommendedFavored;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isRecommendedFavored ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Green "ดูรายละเอียด" Button
                          SizedBox(
                            width: 100,
                            height: 34,
                            child: ElevatedButton(
                              onPressed: () => _showStoreDetail(recommendedStore),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B6A42),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text(
                                'ดูรายละเอียด',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 24),

        // Section Title: "ร้านค้าที่ร่วมโครงการ GreenPoint" & Sort Option
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.people_outline, color: Color(0xFF107C41), size: 20),
                  const SizedBox(width: 6),
                  Text(
                    'ร้านค้าที่ร่วมโครงการ GreenPoint',
                    style: GoogleFonts.prompt(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF107C41),
                    ),
                  ),
                ],
              ),
              // Sort selection
              Row(
                children: [
                  Text(
                    'เรียงตาม: ใกล้สุด',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.grey.shade600),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // List of Store Items
        otherStores.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    children: [
                      Icon(Icons.search_off_rounded, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      Text(
                        'ไม่พบร้านค้าที่ตรงกับเงื่อนไข',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: otherStores.length,
                itemBuilder: (context, index) {
                  final store = otherStores[index];
                  return _buildStoreListItem(store);
                },
              ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Store List Item Widget
  Widget _buildStoreListItem(Store store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Store Logo
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: store.isLocked ? const Color(0xFFE0E0E0) : Colors.grey.shade200,
              ),
              child: store.isLocked
                  ? const Icon(Icons.lock, color: Colors.grey, size: 28)
                  : Image.network(
                      store.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.store, color: Colors.white),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Store Info Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              store.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF222B24),
                              ),
                            ),
                          ),
                          if (store.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF107C41),
                              size: 15,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 13),
                    const SizedBox(width: 2),
                    Text(
                      '${store.rating} (${store.reviewsCount} รีวิว)',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                    ),
                    const SizedBox(width: 4),
                    Text('|', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                    const SizedBox(width: 4),
                    Text(
                      store.category,
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                    ),
                    const SizedBox(width: 4),
                    Text('|', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                    const SizedBox(width: 4),
                    Text(
                      '${store.distanceKm} km',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Custom Tags List
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: store.tags.map((tag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Color(0xFF107C41),
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Action & Points Box (Right)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'แต้มจากร้านนี้',
                style: TextStyle(fontSize: 9, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 1),
              Text(
                '${store.points} GP',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF107C41),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 28,
                child: OutlinedButton(
                  onPressed: () => _showStoreDetail(store),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF107C41), width: 1),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'ดูรายละเอียด',
                    style: TextStyle(
                      color: Color(0xFF107C41),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Mock Map View Content for "แผนที่" Tab
  Widget _buildMapViewContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 380,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Simulated Grid/Map Background Design
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GridPaper(
                    color: const Color(0xFF107C41).withValues(alpha: 0.04),
                    divisions: 2,
                    subdivisions: 4,
                    interval: 100,
                    child: Container(
                      color: const Color(0xFFE8F5E9).withValues(alpha: 0.2),
                    ),
                  ),
                ),
                // Simulated Streets / Custom lines
                CustomPaint(
                  size: const Size(double.infinity, 380),
                  painter: MapRoadPainter(),
                ),
                // Store Pins on the Map
                ..._filteredStores.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final store = entry.value;

                  // Unique positions for mock pins
                  final double top = 60.0 + (idx * 55.0) % 250;
                  final double left = 50.0 + (idx * 75.0) % 280;

                  return Positioned(
                    top: top,
                    left: left,
                    child: Tooltip(
                      message: store.name,
                      child: GestureDetector(
                        onTap: () => _showStoreDetail(store),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                                ],
                                border: Border.all(color: const Color(0xFF107C41), width: 1),
                              ),
                              child: Text(
                                store.name,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E3A31)),
                              ),
                            ),
                            const Icon(
                              Icons.location_on,
                              color: Color(0xFF107C41),
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                // Overlay Instruction
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFF107C41), size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'กำลังแสดงร้านค้าใกล้คุณ ${_filteredStores.length} แห่ง แตะเพื่อดูรายละเอียด',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF2E3A31)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Horizontal mini list of shops under the map for easier access
          const Text(
            'ร้านค้าในบริเวณนี้',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2E3A31)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _filteredStores.length,
              itemBuilder: (context, index) {
                final store = _filteredStores[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => _showStoreDetail(store),
                    child: Container(
                      width: 220,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey.shade100,
                              child: store.isLocked
                                  ? const Icon(Icons.lock, color: Colors.grey)
                                  : Image.network(
                                      store.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.store, color: Colors.grey),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  store.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${store.category} • ${store.distanceKm} km',
                                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 10),
                                    const SizedBox(width: 2),
                                    Text('${store.rating}', style: const TextStyle(fontSize: 10)),
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
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
