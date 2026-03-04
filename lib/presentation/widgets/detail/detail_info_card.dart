import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailInfoCard extends StatelessWidget {
  final Map<String, String> info;
  const DetailInfoCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return HStack([
          _buildInfoItem("Status", info['Status'] ?? "-"),
          _buildInfoItem("Type", info['Jenis Komik'] ?? "-"),
          _buildInfoItem("Author", info['Pengarang'] ?? "-"),
        ], alignment: MainAxisAlignment.spaceAround).box.roundedLg
        .color(context.theme.cardColor) // Mengikuti tema sistem
        .p16
        .make()
        .pSymmetric(v: 16);
  }

  Widget _buildInfoItem(String label, String value) {
    return VStack([
      label.text.sm.gray500.make(),
      4.heightBox,
      value.text.semiBold.make(),
    ], crossAlignment: CrossAxisAlignment.center);
  }
}
