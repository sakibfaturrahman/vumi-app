import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

// Import Data Layer
import 'data/datasources/remote_datasource.dart';
import 'data/repositories/comic_repository_impl.dart';

// Import Domain Layer
import 'domain/usecases/get_terbaru.dart';
import 'domain/usecases/get_populer.dart';

// Import Presentation Layer
import 'presentation/pages/main_screen.dart';

void main() {
  // 1. Inisialisasi Data Source
  final remoteDataSource = RemoteDataSourceImpl(client: http.Client());

  // 2. Inisialisasi Repository Implementation
  final comicRepository = ComicRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );

  runApp(
    // 3. Setup Provider untuk Dependency Injection ke seluruh aplikasi
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GetTerbaru>(
          create: (context) => GetTerbaru(comicRepository),
        ),
        RepositoryProvider<GetPopuler>(
          create: (context) => GetPopuler(comicRepository),
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
    // 4. Menggunakan MaterialApp secara langsung atau VxApp jika menggunakan VxState
    // Karena belum menggunakan VxStore, kita bisa menggunakan MaterialApp biasa
    return MaterialApp(
      title: 'VUMI',
      debugShowCheckedModeBanner: false,

      // Konfigurasi Tema
      themeMode: ThemeMode.system, // Mengikuti settingan HP
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(
          0xFF0F172A,
        ), // Slate 900 ala Tailwind
      ),

      // Halaman Utama
      home: const MainScreen(),
    );
  }
}
