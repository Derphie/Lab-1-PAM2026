import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const LearningApp());

// ───────────────────────── Colors ─────────────────────────
const kBlue = Color(0xFF3F5EFB);
const kOrange = Color(0xFFFF7A00);
const kInk = Color(0xFF1C1B2E);
const kGrey = Color(0xFF9A9BB0);
const kCardShadow = BoxShadow(
  color: Color(0x14000000),
  blurRadius: 18,
  offset: Offset(0, 6),
);

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAFAFD),
        colorScheme: ColorScheme.fromSeed(seedColor: kBlue),
      ),
      home: const HomePage(),
    );
  }
}

// ───────────────────────── Simple illustration ─────────────────────────
class Person extends StatelessWidget {
  final double size;
  final Color hair;
  final Color skin;
  final Color shirt;

  const Person({
    super.key,
    required this.size,
    this.hair = const Color(0xFFF2A33A),
    this.skin = const Color(0xFFFFD2B3),
    this.shirt = kBlue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: size * 0.82,
            height: size * 0.46,
            decoration: BoxDecoration(
              color: shirt,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(size * 0.4)),
            ),
          ),
          Positioned(
            top: size * 0.06,
            child: Container(
              width: size * 0.54,
              height: size * 0.54,
              decoration: BoxDecoration(color: hair, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            top: size * 0.2,
            child: Container(
              width: size * 0.4,
              height: size * 0.42,
              decoration: BoxDecoration(color: skin, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Page 1: Home ─────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final blueHeight = topPad + 130;
    const cardHeight = 82.0;
    const overlap = 40.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header + overlapping "Learned today" card
              SizedBox(
                height: blueHeight - overlap + cardHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: blueHeight,
                      width: double.infinity,
                      color: kBlue,
                      padding: EdgeInsets.fromLTRB(16, topPad + 24, 16, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, Kristin',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Let's start learning",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _HeaderAvatar(),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      top: blueHeight - overlap,
                      height: cardHeight,
                      child: const _LearnedTodayCard(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Horizontal banner cards
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _GetStartedCard(
                      onGetStarted: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CourseOverviewPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    const _SecondBannerCard(),
                  ],
                ),
              ),

              // Learning plan
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 28, 16, 12),
                child: Text(
                  'Learning Plan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kInk,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [kCardShadow],
                  ),
                  child: const Column(
                    children: [
                      _PlanRow(
                        title: 'Packaging Design',
                        done: 40,
                        total: 48,
                        ringColor: Color(0xFF6B6B7B),
                      ),
                      SizedBox(height: 18),
                      _PlanRow(
                        title: 'Product Design',
                        done: 6,
                        total: 24,
                        ringColor: Color(0xFFB9B9C6),
                      ),
                    ],
                  ),
                ),
              ),

              // Meetup
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 22, 16, 32),
                child: Container(
                  width: double.infinity,
                  height: 104,
                  padding: const EdgeInsets.only(left: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBDDFC),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [kCardShadow],
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meetup',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4A1A8C),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Off-line exchange of learning experiences',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF4A1A8C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 92,
                        height: 92,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF6EEFF),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: const [
                            Positioned(
                              top: 14,
                              child: Person(
                                size: 38,
                                hair: Color(0xFFF2A33A),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Person(
                                size: 36,
                                hair: Color(0xFF2B2B3C),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Person(
                                size: 36,
                                hair: Color(0xFFE0E0E8),
                                skin: Color(0xFFFFE0CC),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: Color(0xFFFFE9DA),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Person(
            size: 40,
            hair: const Color(0xFF2B2B3C),
            skin: const Color(0xFF8A4B2D),
          ),
        ),
      ),
    );
  }
}

class _LearnedTodayCard extends StatelessWidget {
  const _LearnedTodayCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [kCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Learned today',
                  style: TextStyle(fontSize: 12, color: kGrey)),
              Text('My courses',
                  style: TextStyle(fontSize: 12, color: kBlue)),
            ],
          ),
          const SizedBox(height: 4),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: '46min',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kInk,
                  ),
                ),
                TextSpan(
                  text: ' / 60min',
                  style: TextStyle(fontSize: 11, color: kGrey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEEF7),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 46 / 60,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB27A), Color(0xFFFF5A1F)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GetStartedCard extends StatelessWidget {
  final VoidCallback onGetStarted;
  const _GetStartedCard({required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.66;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFD0E8FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 4,
            bottom: 0,
            child: Person(
              size: 100,
              hair: const Color(0xFFF2A33A),
              shirt: kBlue,
            ),
          ),
          Positioned(
            left: 14,
            top: 14,
            width: width * 0.5,
            child: const Text(
              'What do you want to learn today?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: kInk,
                height: 1.25,
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 14,
            child: Material(
              color: kOrange,
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: onGetStarted,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondBannerCard extends StatelessWidget {
  const _SecondBannerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFD0E8FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 14,
            top: 18,
            child: Container(
              width: 46,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.check_circle,
                  color: Color(0xFF5BB38A), size: 22),
            ),
          ),
          Positioned(
            left: 70,
            bottom: 0,
            child: Person(
              size: 90,
              hair: const Color(0xFFF4B6C2),
              shirt: const Color(0xFFF4B6C2),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanRow extends StatelessWidget {
  final String title;
  final int done;
  final int total;
  final Color ringColor;

  const _PlanRow({
    required this.title,
    required this.done,
    required this.total,
    required this.ringColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            value: done / total,
            strokeWidth: 3,
            color: ringColor,
            backgroundColor: const Color(0xFFEDEEF4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, color: kInk),
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$done',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kInk,
                ),
              ),
              TextSpan(
                text: '/$total',
                style: const TextStyle(fontSize: 15, color: kGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Page 2: Course Overview ─────────────────────────
class CourseOverviewPage extends StatelessWidget {
  const CourseOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFF),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar with back arrow -> returns to first page
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          iconSize: 20,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Course Overview',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: kInk,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Video thumbnail
                    const _VideoThumbnail(),
                    const SizedBox(height: 20),

                    // Title + meta + rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'React Front To back',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kInk,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      size: 14, color: kGrey),
                                  SizedBox(width: 4),
                                  Text(
                                    '6h 30min  ·  7 lessons',
                                    style: TextStyle(
                                        fontSize: 12, color: kGrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F3FC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.star_rounded,
                                  size: 16, color: Color(0xFFFFB800)),
                              SizedBox(width: 3),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: kOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Tabs
                    Row(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Lessons',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: kOrange,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                                width: 86, height: 2, color: kOrange),
                          ],
                        ),
                        const SizedBox(width: 16),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFD5D6E0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Lessons
                    const _LessonTile(
                      title: 'Introduction to React',
                      duration: '04:28 min',
                      active: true,
                    ),
                    const _LessonTile(
                      title: 'Understanding React',
                      duration: '06:12 min',
                    ),
                    const _LessonTile(
                      title: 'Create first React project',
                      duration: '43:58 min',
                    ),
                    const Opacity(
                      opacity: 0.35,
                      child: _LessonTile(
                        title: 'Build React',
                        duration: '25:18 min',
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom bar: Free + Enroll Now
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x00FAFAFF), Color(0xFFFAFAFF)],
                      stops: [0, 0.4],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFEDEEF5)),
                          boxShadow: const [kCardShadow],
                        ),
                        child: const Text(
                          'Free',
                          style: TextStyle(
                            color: kOrange,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kOrange,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Enroll Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _VideoThumbnail extends StatelessWidget {
  const _VideoThumbnail();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF7B4DFF), Color(0xFFE88F72)],
        ),
        boxShadow: const [kCardShadow],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative translucent shapes
          Positioned(
            left: 70,
            top: 50,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 90,
                height: 60,
                color: const Color(0x22FFFFFF),
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: 40,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 90,
                height: 60,
                color: const Color(0x22FFFFFF),
              ),
            ),
          ),
          const Positioned(
            top: 12,
            child: Text(
              'SPOKEN ENGLISH',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const Positioned(
            top: 34,
            child: Person(
              size: 120,
              hair: Color(0xFFB5703A),
              skin: Color(0xFFFFD7BC),
              shirt: Color(0xFFC25B3F),
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow_rounded,
                color: kOrange, size: 38),
          ),
          Positioned(
            bottom: 8,
            child: Row(
              children: const [
                _Badge(icon: Icons.ondemand_video_rounded, text: '75 Videos'),
                SizedBox(width: 6),
                _Badge(icon: Icons.school_rounded, text: '35 Class'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Badge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: const Color(0xFF3FA7C9)),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: kInk,
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final String title;
  final String duration;
  final bool active;

  const _LessonTile({
    required this.title,
    required this.duration,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: active ? 38 : 38,
            height: 38,
            decoration: BoxDecoration(
              color: active ? kOrange : Colors.white,
              shape: BoxShape.circle,
              boxShadow: active ? null : const [kCardShadow],
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              size: 22,
              color: active ? Colors.white : kOrange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kInk,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  duration,
                  style: const TextStyle(fontSize: 12, color: kGrey),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: kOrange, size: 28),
        ],
      ),
    );
  }
}
