import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VumiStyles {
  // =============================
  // CARD DECORATION (FIX PUTIH)
  // =============================
  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
    color: Colors.white, // 🔥 Paksa putih
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );

  // =============================
  // FEATURED OVERLAY GRADIENT
  // =============================
  static LinearGradient overlayGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
  );

  // =============================
  // OPTIONAL: APP BACKGROUND STYLE
  // =============================
  static Color scaffoldBackground = Colors.white;
}
