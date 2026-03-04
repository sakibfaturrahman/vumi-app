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
    // 3. Daftarkan SEMUA UseCase di sini agar tidak NULL saat dipanggil context.read
    MultiRepositoryProvider(
      providers: [
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
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const MainScreen(),
    );
  }
}
