import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailInfoCard extends StatelessWidget {
  final Map<String, String> info;
  const DetailInfoCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return HStack([
          // 1. Status Item
          _buildInfoItem("Status", info['Status'] ?? "-").expand(),

          // Garis pemisah agar tidak berdempetan
          _buildDivider(context),

          // 2. Type Item
          _buildInfoItem("Type", info['Jenis Komik'] ?? "-").expand(),

          _buildDivider(context),

          // 3. Author Item
          _buildInfoItem("Author", info['Pengarang'] ?? "-").expand(),
        ], alignment: MainAxisAlignment.spaceAround).box.roundedLg
        .color(context.theme.cardColor) // Adaptif Dark/Light Mode
        .border(color: Colors.amber.withOpacity(0.1)) // Aksen Vumi
        .p16
        .make()
        .pSymmetric(v: 16);
  }

  Widget _buildInfoItem(String label, String value) {
    return VStack([
      label.text.xs.gray500.uppercase.letterSpacing(1).make(),
      6.heightBox,
      // Gunakan amber600 dan ellipsis agar aman jika nama author panjang
      value.text.semiBold.amber600.sm.maxLines(1).ellipsis.make(),
    ], crossAlignment: CrossAxisAlignment.center);
  }

  Widget _buildDivider(BuildContext context) {
    return VxBox()
        .color(context.theme.dividerColor.withOpacity(0.1))
        .width(1)
        .height(30)
        .make();
  }
}
