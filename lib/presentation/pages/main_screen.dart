import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

// Import Bloc
import '../bloc/home_cubit.dart';

// Import UseCases
import '../../domain/usecases/get_terbaru.dart';
import '../../domain/usecases/get_populer.dart'; // Tambahkan import ini
import '../../domain/usecases/get_populer_manga.dart';
import '../../domain/usecases/get_populer_manhwa.dart';
import '../../domain/usecases/get_populer_manhua.dart';

// Import Pages & Widgets
import 'home_page.dart';
import '../widgets/global/custom_header.dart';
import '../widgets/global/custom_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Gunakan BuildContext dari build method agar context.read selalu valid
  List<Widget> _getPages(BuildContext context) {
    return [
      BlocProvider(
        create: (blocContext) => HomeCubit(
          // Pastikan SEMUA 5 parameter ini terisi sesuai urutan di constructor HomeCubit
          getTerbaru: context.read<GetTerbaru>(),
          getPopuler: context
              .read<GetPopuler>(), // Tambahkan ini agar tidak NULL
          getPopulerManga: context.read<GetPopulerManga>(),
          getPopulerManhwa: context.read<GetPopulerManhwa>(),
          getPopulerManhua: context.read<GetPopulerManhua>(),
        )..fetchHomeData(),
        child: const HomePage(),
      ),
      const Center(child: Text("Halaman Riwayat")),
      const Center(child: Text("Halaman Disukai")),
      const Center(child: Text("Halaman Jelajahi")),
    ];
  }

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
    final pages = _getPages(context);

    return Scaffold(
      appBar: const CustomHeader(),

      // IndexedStack menjaga state halaman agar tidak reload saat pindah tab
      body: IndexedStack(index: _currentIndex, children: pages),

      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      endDrawer: Drawer(
        child: VStack([
          VxBox(
            child: _getMenuTitle().text.white.xl2.bold.make().p20(),
          ).blue600.make().wFull(context).safeArea(),

          20.heightBox,

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
          "v1.0.0".text.gray400.make().centered().p20(),
        ]),
      ),
    );
  }
}
