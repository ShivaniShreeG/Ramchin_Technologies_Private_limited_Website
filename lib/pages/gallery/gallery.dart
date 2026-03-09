import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryItem {
  final String imageUrl;
  final String caption;

  GalleryItem(this.imageUrl, this.caption);
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() =>
      _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<GalleryItem> photos = [];

  final List<GalleryItem> _networkPhotos = [
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1773051488836-539401502.jpeg",
        'MoU signing with Govindammal Aditanar College for Women.'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1773051493071-41068040.jpeg",
        'MoU signing with Govindammal Aditanar College for Women.'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1773051498471-604377430.jpeg",
        'MoU signing with Govindammal Aditanar College for Women.'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1773051503152-864538764.jpeg",
        'IMoU signing with Govindammal Aditanar College for Women.'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1773051509287-748949754.jpeg",
        'MoU signing with Govindammal Aditanar College for Women.'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518126818-810057111.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518120903-636792864.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518116813-726226242.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518113013-11129652.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518109027-377393017.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518102869-665074320.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518098884-746405697.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518094408-218587385.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518089237-820830305.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518081013-449278035.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518076092-166858587.jpeg",
        'Internship Training'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772518071379-691638352.jpeg",
        'Internship Training'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517052153-715550535.jpeg",
      'Chief Guest being welcomed at the opening ceremony'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517048054-14530304.jpeg",
      'Reception of Guests at the Opening Ceremony'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517040794-345508224.jpeg",
      'The Chief Guest Opening the Ramchin Technologies (P) Ltd.'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517037121-225041983.jpeg",
      'Honouring Mr.V.Vairavaraj, Director, Farmer\'s Insurance, USA'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772517033624-727020189.jpeg",
        'Honouring the Guest'),
    GalleryItem(
        "https://www.ramchintech.com/companyweb/Gallery/1772517021635-325763786.jpeg",
        'Honouring the Guest'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517017583-801637198.jpeg",
      'Briefing the objectives of the Company'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517011914-879692453.png",
      'Internship batch from B.Sc (Computer Science)'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517007307-710182824.png",
      'Internship batch from B.E (Computer Science & Engineering)'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772517001500-207167263.jpeg",
      'Students actively engaged in their Internship Program'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772516997539-465332409.jpeg",
      'Students actively engaged in their Internship Program'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772516994078-177940857.jpeg",
      'Students actively engaged in their Internship Program'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772516656214-804792678.jpeg",
      'The Principal of GAC addressing Students during Campus Interview'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772516661218-309601420.jpeg",
      'Screening the Students by conducting a written test'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772516664723-803445675.jpeg",
      'The Students are being screened through Personal Interview'),
    GalleryItem(
      "https://www.ramchintech.com/companyweb/Gallery/1772516668026-165700842.jpeg",
      'The Director of Ramchin Tech addressing candidates during Interview'),
  ];

  Future<void> _openImageUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    photos = List.from(_networkPhotos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome to Ramchin Tech Photo Gallery",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "A collection of beautiful moments captured in photos.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 1100
                      ? 4
                      : MediaQuery.of(context).size.width > 700
                      ? 3
                      : 2,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return _HoverCard(
                    key: ValueKey('${photos[index].imageUrl}-$index'),                    photo: photos[index],
                    onTap: () => _openImageUrl(photos[index].imageUrl),                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _HoverCard extends StatefulWidget {
  final GalleryItem photo;
  final VoidCallback onTap;

  const _HoverCard({
    super.key,
    required this.photo,
    required this.onTap,
  });

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard>
    with AutomaticKeepAliveClientMixin {
  bool _isHovered = false;

  @override
  bool get wantKeepAlive => true;

  void _triggerMobileHover() {
    if (mounted &&
        (Theme.of(context).platform == TargetPlatform.android ||
            Theme.of(context).platform == TargetPlatform.iOS)) {
      debugPrint("📱 Mobile hover triggered for: ${widget.photo.caption}");
      setState(() => _isHovered = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isHovered = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _triggerMobileHover();
      },
      onLongPress: _triggerMobileHover,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _isHovered = true);
        },
        onExit: (_) {
          setState(() => _isHovered = false);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  widget.photo.imageUrl,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  cacheWidth: 400,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: Colors.black.withValues(alpha:0.5),
                  alignment: Alignment.center,
                  child: Text(
                    widget.photo.caption,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > 700
                          ? 22
                          : 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
