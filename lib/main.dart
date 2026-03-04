import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// Import Data Layer
import 'data/datasources/remote_datasource.dart';
import 'data/repositories/comic_repository_impl.dart';

// Import Domain Layer (UseCase)
import 'domain/usecases/get_terbaru.dart';
import 'domain/usecases/get_populer.dart';
import 'domain/usecases/get_populer_manga.dart';
import 'domain/usecases/get_populer_manhwa.dart';
import 'domain/usecases/get_populer_manhua.dart';
// WAJIB: Import Use Case Detail yang baru dibuat
import 'domain/usecases/get_detail_komik.dart';

// Import Presentation Layer
import 'presentation/pages/main_screen.dart';

void main() {
  // 1. Inisialisasi Data Source
  final remoteDataSource = RemoteDataSourceImpl(client: http.Client());

  // 2. Inisialisasi Repository
  final comicRepository = ComicRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );

  runApp(
    // 3. Daftarkan DataSource dan UseCase di sini
    MultiRepositoryProvider(
      providers: [
        // DAFTARKAN RemoteDataSource agar DetailPage tidak error
        RepositoryProvider<RemoteDataSource>(
          create: (context) => remoteDataSource,
        ),

        // UseCase untuk Beranda
        RepositoryProvider<GetTerbaru>(
          create: (context) => GetTerbaru(comicRepository),
        ),
        RepositoryProvider<GetPopuler>(
          create: (context) => GetPopuler(comicRepository),
        ),
        RepositoryProvider<GetPopulerManga>(
          create: (context) => GetPopulerManga(comicRepository),
        ),
        RepositoryProvider<GetPopulerManhwa>(
          create: (context) => GetPopulerManhwa(comicRepository),
        ),
        RepositoryProvider<GetPopulerManhua>(
          create: (context) => GetPopulerManhua(comicRepository),
        ),

        // WAJIB: Daftarkan GetDetailKomik untuk digunakan di DetailPage
        RepositoryProvider<GetDetailKomik>(
          create: (context) => GetDetailKomik(comicRepository),
        ),
      ],
      child: const VumiApp(),
    ),
  );
}

class VumiApp extends StatelessWidget {
  const VumiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VUMI',
      debugShowCheckedModeBanner: false,
      // Menggunakan tema sistem agar adaptif di HP Infinix kamu
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ), // Sesuaikan ke Amber
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(
          0xFF0F172A,
        ), // Warna Slate/Dark mode
      ),
      home: const MainScreen(),
    );
  }
}
