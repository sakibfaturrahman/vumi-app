import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VumiStyles {
  // Custom Card Style ala desain referensi kamu
  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
    color: context.theme.cardColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );

  // Gradient untuk Featured Card (Card paling atas)
  static LinearGradient overlayGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
  );
}
