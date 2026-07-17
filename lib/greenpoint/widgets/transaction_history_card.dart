import 'package:flutter/material.dart';

class TransactionHistoryCard extends StatelessWidget {
  const TransactionHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        'title': 'สแกน QR code ที่ร้านกระเจี๊ยบ',
        'subtitle': '02/09/2568  •  14:32  •  Cha-ji Coffee',
        'points': '+10 XP',
        'isPositive': true,
        'icon': Icons.qr_code_scanner_rounded,
        'iconColor': const Color(0xFF2E7D32),
        'iconBgColor': const Color(0xFFE8F9EE),
      },
      {
        'title': 'สแกน QR code ที่ร้านลูกชิ้นอ้วน',
        'subtitle': '01/09/2568  •  10:18  •  ร้านลูกชิ้นอ้วน',
        'points': '+5 XP',
        'isPositive': true,
        'icon': Icons.qr_code_scanner_rounded,
        'iconColor': const Color(0xFF2E7D32),
        'iconBgColor': const Color(0xFFE8F9EE),
      },
      {
        'title': 'แลกกระบอกน้ำตราหมี',
        'subtitle': '03/08/2568  •  17:45  •  GreenPoint Shop',
        'points': '-50 XP',
        'isPositive': false,
        'icon': Icons.card_giftcard_rounded,
        'iconColor': Colors.red,
        'iconBgColor': const Color(0xFFFFEBEE),
      },
      {
        'title': 'โบนัสกิจกรรม แต้ม x2',
        'subtitle': '28/07/2568  •  09:20  •  งาน Green Life',
        'points': '+20 XP',
        'isPositive': true,
        'icon': Icons.star_border_rounded,
        'iconColor': const Color(0xFF2E7D32),
        'iconBgColor': const Color(0xFFE8F9EE),
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
                "ประวัติการทำรายการ",
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
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey.shade100, height: 20),
            itemBuilder: (context, index) {
              final tx = transactions[index];
              final isPositive = tx['isPositive'] as bool;
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: tx['iconBgColor'] as Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      tx['icon'] as IconData,
                      color: tx['iconColor'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tx['title'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tx['subtitle'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Text(
                        tx['points'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isPositive
                              ? const Color(0xFF2E7D32)
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
