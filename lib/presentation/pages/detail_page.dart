import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../data/models/comic_detail_model.dart';
import '../../../data/datasources/remote_datasource.dart';
import '../widgets/detail/detail_info_card.dart';

class DetailPage extends StatefulWidget {
  final dynamic data;
  const DetailPage({super.key, required this.data});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ComicDetailModel? fullDetail;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Gunakan microtask agar context siap di laptop Redmibook kamu
    Future.microtask(() => _fetchFullDetail());
  }

  Future<void> _fetchFullDetail() async {
    if (!mounted) return;
    try {
      final remote = context.read<RemoteDataSource>();
      // Pastikan slug diambil dari model yang benar (mangaSlug/slug)
      final String slug = widget.data.slug;
      final response = await remote.fetchDetailManga(slug);

      if (mounted) {
        setState(() {
          fullDetail = ComicDetailModel.fromJson(response);
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString();
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: isLoading
          ? const CircularProgressIndicator(color: Vx.amber600).centered()
          : errorMessage != null
          ? _buildErrorUI()
          : _buildDetailContent(),
    );
  }

  Widget _buildDetailContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // 1. SliverAppBar dengan efek Blur/Parallax ala Avatar
        SliverAppBar(
          expandedHeight: 450,
          pinned: true,
          elevation: 0,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          leading: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ).p12().onTap(() => Navigator.pop(context)),
          flexibleSpace: FlexibleSpaceBar(
            background: ZStack([
              Image.network(
                fullDetail?.thumbnail ?? widget.data.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              // Gradient yang lebih pekat di bawah agar teks putih terbaca jelas
              VxBox()
                  .withGradient(
                    LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        context.theme.scaffoldBackgroundColor,
                      ],
                    ),
                  )
                  .make()
                  .whFull(context),
            ]),
          ),
        ),

        SliverToBoxAdapter(
          child: VStack([
            // 2. Info Utama (Title & Rating)
            HStack([
              VStack([
                "${fullDetail?.title ?? widget.data.title}".text.xl3.bold
                    .make()
                    .expand(),
                (fullDetail?.alternativeTitle ?? "Vumi Premium Reader")
                    .text
                    .amber600
                    .semiBold
                    .sm
                    .make(),
              ]).expand(),
              VStack([
                const Icon(Icons.star, color: Colors.amber, size: 24),
                "8.68".text.bold.sm.make(),
              ], crossAlignment: CrossAxisAlignment.center),
            ]).p16(),

            // 3. Action Buttons
            _buildPremiumActionButtons(),

            24.heightBox,

            // 4. Genre Chips (DIBUAT LEBIH RESPONSIF)
            _buildResponsiveGenres(),

            24.heightBox,

            // 5. Sinopsis & Info
            VStack([
              "Sinopsis".text.xl.bold.make().pOnly(bottom: 8),
              (fullDetail?.description ?? "Mengambil data sinopsis...")
                  .text
                  .gray500
                  .lineHeight(1.5)
                  .make(),

              if (fullDetail != null) DetailInfoCard(info: fullDetail!.info),
            ]).p16(),

            // 6. Chapter List Header
            HStack([
              "Daftar Chapter".text.xl.bold.make().expand(),
              "${fullDetail?.chapters.length ?? 0} Chapters".text.gray500
                  .make(),
            ]).p16(),

            // 7. Chapter List
            _buildChapterList(),

            120.heightBox,
          ]),
        ),
      ],
    );
  }

  // PERBAIKAN: Genre Chips yang lebih rapi menggunakan Wrap agar tidak overflow ke samping
  Widget _buildResponsiveGenres() {
    final genres = fullDetail?.genres ?? [];
    if (genres.isEmpty) return const SizedBox();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres
          .map(
            (g) => g
                .toString()
                .text
                .xs
                .white
                .semiBold
                .make()
                .pSymmetric(h: 12, v: 6)
                .box
                .amber600
                .roundedFull
                .make(),
          )
          .toList(),
    ).pSymmetric(h: 16);
  }

  Widget _buildPremiumActionButtons() {
    return HStack([
      HStack([
        const Icon(Icons.play_circle_fill, color: Colors.white, size: 24),
        8.widthBox,
        "Baca Sekarang".text.white.bold.lg.make(),
      ]).centered().box.amber600.roundedLg.make().h(55).expand().onTap(() {
        /* Logic Baca */
      }),
      16.widthBox,
      const Icon(
        Icons.bookmark_border,
        size: 28,
        color: Colors.amber,
      ).box.border(color: Colors.amber.withOpacity(0.5)).roundedLg.p12.make(),
    ]).pSymmetric(h: 16);
  }

  Widget _buildChapterList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: fullDetail?.chapters.length ?? 0,
      itemBuilder: (context, index) {
        final chap = fullDetail!.chapters[index];
        return HStack([
              "#${fullDetail!.chapters.length - index}".text.gray400.bold
                  .make()
                  .w(35),
              VStack([
                chap['title'].toString().text.semiBold.make(),
                chap['date'].toString().text.xs.gray500.make(),
              ]).expand(),
              const Icon(
                Icons.download_for_offline_outlined,
                color: Colors.amber,
                size: 22,
              ),
            ])
            .p16()
            .box
            .color(context.theme.cardColor)
            .roundedLg
            .margin(const EdgeInsets.only(bottom: 8))
            .make();
      },
    );
  }

  Widget _buildErrorUI() {
    return VStack([
      const Icon(Icons.cloud_off, size: 60, color: Colors.amber),
      16.heightBox,
      "Gagal memuat detail".text.bold.lg.make(),
      errorMessage!.text.center.gray500.make().p16(),
      "Coba Lagi".text.white.bold
          .make()
          .centered()
          .box
          .amber600
          .roundedLg
          .px24
          .py12
          .make()
          .onTap(() => _fetchFullDetail()),
    ]).centered();
  }
}
