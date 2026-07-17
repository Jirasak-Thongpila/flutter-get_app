import 'package:flutter/material.dart';

class AchievementsCard extends StatelessWidget {
  const AchievementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final badges = [
      {
        'label': 'Eco Starter',
        'icon': Icons.eco_outlined,
        'color': const Color(0xFFD84315),
        'bgColor': const Color(0xFFFBE9E7),
        'borderColor': const Color(0xFFFFCCBC),
        'locked': false,
      },
      {
        'label': 'Green Shopper',
        'icon': Icons.local_mall_outlined,
        'color': const Color(0xFF2E7D32),
        'bgColor': const Color(0xFFE8F5E9),
        'borderColor': const Color(0xFFC8E6C9),
        'locked': false,
      },
      {
        'label': 'Eco Explorer',
        'icon': Icons.pin_drop_outlined,
        'color': const Color(0xFF37474F),
        'bgColor': const Color(0xFFECEFF1),
        'borderColor': const Color(0xFFCFD8DC),
        'locked': false,
      },
      {
        'label': 'No Plastic',
        'icon': Icons.card_giftcard_outlined,
        'color': const Color(0xFFF57F17),
        'bgColor': const Color(0xFFFFF9C4),
        'borderColor': const Color(0xFFFFF59D),
        'locked': false,
      },
      {
        'label': 'Eco Hero',
        'icon': Icons.lock_outline,
        'color': const Color(0xFF90A4AE),
        'bgColor': const Color(0xFFF5F5F5),
        'borderColor': const Color(0xFFE0E0E0),
        'locked': true,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Achievements",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: const [
                    Text(
                      "ดูทั้งหมด",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: badges.map((badge) {
              final isLocked = badge['locked'] as bool;
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: badge['bgColor'] as Color,
                        border: Border.all(
                          color: badge['borderColor'] as Color,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        badge['icon'] as IconData,
                        color: badge['color'] as Color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      badge['label'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: isLocked ? Colors.grey : Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
