import 'package:flutter/material.dart';

void main() {
  runApp(const PokerTableApp());
}

const Color bg = Color(0xFF170D25);
const Color panel = Color(0xFF2B173B);
const Color gold = Color(0xFFFFC542);
const Color purple = Color(0xFF54266F);

class PokerTableApp extends StatelessWidget {
  const PokerTableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طرابيزة بوكر',
      // اتجاه RTL لكل التطبيق مرة واحدة (بدون الحاجة لحزم إضافية)
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> games = const [
    {'name': 'الدومينو', 'emoji': '🁣', 'players': '987 لاعب'},
    {'name': 'البوكر', 'emoji': '🂡', 'players': '1,256 لاعب'},
    {'name': 'تين باتي', 'emoji': '🃏', 'players': '742 لاعب'},
    {'name': 'أقل أو أعلى من 7', 'emoji': '🎲', 'players': '621 لاعب'},
    {'name': 'الطاولة', 'emoji': '🎯', 'players': '531 لاعب'},
    {'name': 'ألعاب ورق متنوعة', 'emoji': '🂱', 'players': '438 لاعب'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: panel,
        title: const Text(
          'طرابيزة بوكر',
          style: TextStyle(color: gold, fontWeight: FontWeight.bold),
        ),
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: gold.withValues(alpha: .7)),
              ),
              child: const Text(
                '🪙  1,740,756',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'اختر لعبتك',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: games.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.12,
                ),
                itemBuilder: (context, index) {
                  if (index == games.length) {
                    return _TournamentTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TournamentsPage(),
                          ),
                        );
                      },
                    );
                  }
                  final game = games[index];
                  return _GameTile(
                    name: game['name']!,
                    emoji: game['emoji']!,
                    players: game['players']!,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('لعبة ${game['name']} قريبًا')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  const _GameTile({
    required this.name,
    required this.emoji,
    required this.players,
    required this.onTap,
  });

  final String name;
  final String emoji;
  final String players;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF17634E), Color(0xFF102D35)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gold, width: 1.5),
            boxShadow: [
              BoxShadow(color: gold.withValues(alpha: .12), blurRadius: 12),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 43)),
              const SizedBox(height: 8),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: gold,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('👤 $players',
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TournamentTile extends StatelessWidget {
  const _TournamentTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6C287E), Color(0xFF29133D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gold, width: 2),
            boxShadow: [
              BoxShadow(color: gold.withValues(alpha: .18), blurRadius: 15),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🏆', style: TextStyle(fontSize: 48)),
              SizedBox(height: 8),
              Text(
                'البطولات',
                style: TextStyle(
                  color: gold,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'اضغط لعرض البطولات',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  int selectedTab = 0;

  final List<String> tabs = const [
    'جميع البطولات',
    'بطولات اليوم',
    'بطولات الأسبوع',
    'البطولات الخاصة',
  ];

  // مفاتيح التصنيف بنفس ترتيب التبويبات
  static const List<String> categoryKeys = ['all', 'today', 'week', 'special'];

  final List<Map<String, String>> tournaments = const [
    {
      'title': 'تكساس هولدم',
      'prize': '10M',
      'players': '16 / 1000',
      'entry': '200K',
      'time': 'يبدأ بعد 02:26:54',
      'category': 'today',
    },
    {
      'title': 'تكساس هولدم',
      'prize': '10M',
      'players': '12 / 1000',
      'entry': '200K',
      'time': 'يبدأ بعد 03:26:54',
      'category': 'today',
    },
    {
      'title': 'تكساس هولدم',
      'prize': '25.9M',
      'players': '16 / 1000',
      'entry': '20K',
      'time': 'يبدأ بعد 00:26:54',
      'category': 'today',
    },
    {
      'title': 'تكساس هولدم',
      'prize': '25.9M',
      'players': '3 / 1000',
      'entry': '20K',
      'time': 'يبدأ بعد 01:26:54',
      'category': 'week',
    },
    {
      'title': 'بطولة الدومينو',
      'prize': '5M',
      'players': '24 / 500',
      'entry': '10K',
      'time': 'تبدأ بعد 04:00:00',
      'category': 'special',
    },
  ];

  List<Map<String, String>> get filtered {
    final key = categoryKeys[selectedTab];
    if (key == 'all') return tournaments;
    return tournaments.where((t) => t['category'] == key).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = filtered;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: panel,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: gold),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '🏆 البطولات',
          style: TextStyle(color: gold, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Center(child: Text('🪙 1,740,756')),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 58,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final active = selectedTab == index;
                  return ChoiceChip(
                    label: Text(tabs[index]),
                    selected: active,
                    onSelected: (_) => setState(() => selectedTab = index),
                    selectedColor: gold,
                    backgroundColor: panel,
                    labelStyle: TextStyle(
                      color: active ? bg : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    side: BorderSide(color: gold.withValues(alpha: .6)),
                  );
                },
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const Center(
                      child: Text(
                        'لا توجد بطولات في هذا القسم حاليًا',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return _TournamentCard(
                          title: item['title']!,
                          prize: item['prize']!,
                          players: item['players']!,
                          entry: item['entry']!,
                          time: item['time']!,
                        );
                      },
                    ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              color: panel,
              child: const Text(
                'نسخة تجريبية: الجوائز والعملات افتراضية ولا يمكن شراؤها أو سحبها نقدًا.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TournamentCard extends StatelessWidget {
  const _TournamentCard({
    required this.title,
    required this.prize,
    required this.players,
    required this.entry,
    required this.time,
  });

  final String title;
  final String prize;
  final String players;
  final String entry;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE6A1), Color(0xFFB96A24)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: gold, width: 2),
        boxShadow: [
          BoxShadow(color: gold.withValues(alpha: .13), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFD84A19),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('🎁', style: TextStyle(fontSize: 42)),
          Text(
            'الجائزة: $prize عملة افتراضية',
            style: const TextStyle(
              color: Color(0xFF321B12),
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text('👤 $players لاعب',
              style: const TextStyle(color: Color(0xFF49301D))),
          Text(
            '⏱ $time',
            style: const TextStyle(
              color: Color(0xFF49301D),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF168C55),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('سيتم تفعيل التسجيل عند ربط نظام البطولات.'),
                  ),
                );
              },
              child: Text('دخول تجريبي  •  $entry'),
            ),
          ),
        ],
      ),
    );
  }
}
