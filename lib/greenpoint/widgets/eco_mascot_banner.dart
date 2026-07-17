import 'package:flutter/material.dart';

class EcoMascotBanner extends StatelessWidget {
  const EcoMascotBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Content Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 249, 238),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // Cute Mascot
              const MascotWidget(),
              const SizedBox(width: 12),
              // Speech Bubble
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(8, 0, 0, 0),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ยอดเยี่ยมมาก! คุณกำลังช่วยโลก\nไปพร้อมกับสร้างสิ่งดีๆ ให้ตัวเอง",
                          style: TextStyle(
                            color: Color.fromARGB(255, 12, 69, 14),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    // Speech bubble pointer (triangle)
                    Positioned(
                      left: -6,
                      top: 22,
                      child: Transform.rotate(
                        angle: 45 * 3.1415927 / 180,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Background Leaf Watermark
        Positioned(
          right: 5,
          bottom: 5,
          child: Transform.rotate(
            angle: -0.2,
            child: const Icon(
              Icons.eco,
              size: 90,
              color: Color.fromARGB(31, 76, 175, 80),
            ),
          ),
        ),
      ],
    );
  }
}

class MascotWidget extends StatelessWidget {
  const MascotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/mascot.png',
      width: 65,
      height: 75,
      fit: BoxFit.contain,
    );
  }
}
