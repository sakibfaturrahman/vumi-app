import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
// Import widget global yang sudah kita buat sebelumnya
import '../widgets/global/custom_header.dart';
import '../widgets/global/custom_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List halaman utama aplikasi VUMI
  final List<Widget> _pages = [
    const Center(child: Text("Home Page")), // Ganti dengan HomePage() kamu
    const Center(
      child: Text("History Page"),
    ), // Ganti dengan HistoryPage() kamu
    const Center(
      child: Text("Favorite Page"),
    ), // Ganti dengan FavoritePage() kamu
    const Center(
      child: Text("Explore Page"),
    ), // Ganti dengan ExplorePage() kamu
  ];

  // Helper untuk mendapatkan judul menu berdasarkan halaman aktif
  String _getMenuTitle() {
    switch (_currentIndex) {
      case 0:
        return "Beranda";
      case 1:
        return "Riwayat Baca";
      case 2:
        return "Komik Disukai";
      case 3:
        return "Jelajahi";
      default:
        return "Menu";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Header dengan Search Bar & Tombol Titik Tiga
      appBar: const CustomHeader(),

      // Menggunakan IndexedStack agar state halaman tidak ter-reset saat berpindah tab
      body: IndexedStack(index: _currentIndex, children: _pages),

      // Navigasi bawah melayang (Floating style) yang sudah kita buat
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      // Drawer samping (muncul saat icon titik tiga di header diklik)
      endDrawer: Drawer(
        child: VStack([
          // Header Drawer
          VxBox(
            child: _getMenuTitle().text.white.xl2.bold.make().p20(),
          ).blue600.make().wFull(context).safeArea(),

          20.heightBox,

          // List Menu Dinamis
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Pengaturan"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Tentang VUMI"),
            onTap: () => Navigator.pop(context),
          ),

          const Spacer(),

          // Versi Aplikasi
          "v1.0.0".text.gray400.make().centered().p20(),
        ]),
      ),
    );
  }
}
