import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const HisbaApp());
}

class HisbaApp extends StatelessWidget {
  const HisbaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حسبة',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050B10),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE9A52E),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Player {
  String name;
  int score;

  Player({this.name = '', this.score = 0});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF071018),
        indicatorColor: const Color(0xFF3A2B13),
        selectedIndex: page,
        onDestinationSelected: (value) {
          setState(() => page = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'الألعاب السابقة',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
        children: [
          const SizedBox(height: 15),

          Center(
            child: Column(
              children: [
                const Text(
                  '♛',
                  style: TextStyle(
                    fontSize: 38,
                    color: Color(0xFFF1B63D),
                  ),
                ),
                Text(
                  'حسبة',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF1B63D),
                    shadows: [
                      Shadow(
                        color: Colors.orange.withOpacity(.35),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'سجّل نقاطك .. وخلي اللعبة أحلى',
                  style: TextStyle(
                    color: Color(0xFF9BA8B2),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 35),

          GameCard(
            icon: '🂡',
            title: 'لعبة الورق',
            subtitle: 'ابدأ لعبة جديدة',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NewGameScreen(gameType: 'ورق'),
                ),
              );
            },
          ),

          GameCard(
            icon: '🎲',
            title: 'الدومينو',
            subtitle: 'ابدأ لعبة جديدة',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NewGameScreen(gameType: 'دومينو'),
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          const Text(
            'آخر الألعاب',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFFE8AE3A),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const PreviousGameTile(
            icon: '🂡',
            title: 'لعبة ورق',
            subtitle: 'لا توجد ألعاب محفوظة بعد',
          ),

          const PreviousGameTile(
            icon: '🎲',
            title: 'دومينو',
            subtitle: 'ابدأ أول لعبة لك',
          ),
        ],
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: const Color(0xFF0B1720),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF273B49),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14232D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    icon,
                    style: const TextStyle(fontSize: 34),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFF7F909C),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_left,
                  color: Color(0xFF9CA8B0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PreviousGameTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const PreviousGameTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFF09141D),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF1D303D),
        ),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 27)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF778691),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_left),
        ],
      ),
    );
  }
}

class NewGameScreen extends StatefulWidget {
  final String gameType;

  const NewGameScreen({
    super.key,
    required this.gameType,
  });

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  int rounds = 5;

  final List<TextEditingController> names = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in names) {
      controller.dispose();
    }
    super.dispose();
  }

  void addPlayer() {
    if (names.length >= 6) return;

    setState(() {
      names.add(TextEditingController());
    });
  }

  void removePlayer(int index) {
    if (names.length <= 2) return;

    setState(() {
      names[index].dispose();
      names.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إنشاء لعبة جديدة'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'ورق',
                label: Text('ورق'),
              ),
              ButtonSegment(
                value: 'دومينو',
                label: Text('دومينو'),
              ),
            ],
            selected: {widget.gameType},
            onSelectionChanged: (_) {},
          ),

          const SizedBox(height: 28),

          const Text(
            'إضافة اللاعبين',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...List.generate(
            names.length,
            (index) => PlayerInput(
              number: index + 1,
              controller: names[index],
              onRemove: () => removePlayer(index),
            ),
          ),

          const SizedBox(height: 8),

          OutlinedButton.icon(
            onPressed: addPlayer,
            icon: const Icon(Icons.add),
            label: const Text('إضافة لاعب'),
          ),

          const SizedBox(height: 25),

          const Text(
            'عدد الجولات',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 17),
          ),

          const SizedBox(height: 10),

          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 3, label: Text('3')),
              ButtonSegment(value: 5, label: Text('5')),
              ButtonSegment(value: 7, label: Text('7')),
            ],
            selected: {rounds},
            onSelectionChanged: (value) {
              setState(() {
                rounds = value.first;
              });
            },
          ),

          const SizedBox(height: 28),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(55),
              backgroundColor: const Color(0xFFE9A52E),
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              final players = names.map((controller) {
                return Player(name: controller.text.trim());
              }).toList();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GameScreen(
                    players: players,
                    rounds: rounds,
                    gameType: widget.gameType,
                  ),
                ),
              );
            },
            child: const Text(
              '▶  بدء اللعبة',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerInput extends StatelessWidget {
  final int number;
  final TextEditingController controller;
  final VoidCallback onRemove;

  const PlayerInput({
    super.key,
    required this.number,
    required this.controller,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE9A52E),
            foregroundColor: Colors.black,
            child: Text('$number'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'اسم اللاعب',
                filled: true,
                fillColor: const Color(0xFF101D27),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final List<Player> players;
  final int rounds;
  final String gameType;

  const GameScreen({
    super.key,
    required this.players,
    required this.rounds,
    required this.gameType,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentRound = 1;

  void saveRound() {
    setState(() {
      currentRound++;
    });

    if (currentRound > widget.rounds) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => WinnerScreen(players: widget.players),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الجولة $currentRound'),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Center(
            child: Text(
              '$currentRound / ${widget.rounds}',
              style: const TextStyle(
                color: Color(0xFFE9A52E),
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 20),

          ...List.generate(
            widget.players.length,
            (index) => ScoreInput(
              player: widget.players[index],
              onChanged: () => setState(() {}),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF0C1821),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF263C4B),
              ),
            ),
            child: const Text(
              'كل لاعب يحصل على نقاط الجولة حسب نتيجة اللعب.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF9AA8B1)),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    for (final player in widget.players) {
                      player.score = 0;
                    }
                    setState(() {});
                  },
                  child: const Text('إعادة'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9A52E),
                    foregroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: saveRound,
                  child: const Text('✓ حفظ الجولة'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScoreInput extends StatefulWidget {
  final Player player;
  final VoidCallback onChanged;

  const ScoreInput({
    super.key,
    required this.player,
    required this.onChanged,
  });

  @override
  State<ScoreInput> createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0A151E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF253B4A),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.player.name.isEmpty
                  ? 'بدون اسم'
                  : widget.player.name,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '${widget.player.score}',
            style: const TextStyle(
              color: Color(0xFF20C878),
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 70,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF101F2A),
              ),
              onChanged: (value) {
                widget.player.score += int.tryParse(value) ?? 0;
                controller.text = '0';
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length),
                );
                widget.onChanged();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WinnerScreen extends StatelessWidget {
  final List<Player> players;

  const WinnerScreen({
    super.key,
    required this.players,
  });

  Player get winner {
    return players.reduce(
      (a, b) => a.score >= b.score ? a : b,
    );
  }

  @override
  Widget build(BuildContext context) {
    final win = winner;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 45,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFF9B671F),
                ),
                gradient: const RadialGradient(
                  colors: [
                    Color(0xFF251A0B),
                    Color(0xFF071018),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    '♛',
                    style: TextStyle(
                      fontSize: 70,
                      color: Color(0xFFF4B73D),
                    ),
                  ),
                  const Text(
                    'الفائز',
                    style: TextStyle(
                      color: Color(0xFFF0B43C),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    win.name.isEmpty ? 'بدون اسم' : win.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${win.score} نقطة',
                    style: const TextStyle(
                      color: Color(0xFFF0B43C),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            ...players.map(
              (player) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF09141D),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        player.name.isEmpty
                            ? 'بدون اسم'
                            : player.name,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Text(
                      '${player.score}',
                      style: const TextStyle(
                        color: Color(0xFFE9A52E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE9A52E),
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'الألعاب السابقة\n\nسيتم ربط الحفظ الدائم بالخطوة التالية',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF9BA8B2),
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: const [
          SizedBox(height: 20),
          Text(
            'الإعدادات',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          SettingTile(
            icon: Icons.dark_mode,
            title: 'المظهر',
            subtitle: 'الوضع الداكن',
          ),
          SettingTile(
            icon: Icons.sports_esports,
            title: 'إعدادات اللعبة',
            subtitle: 'عدد الجولات ونوع اللعبة',
          ),
          SettingTile(
            icon: Icons.language,
            title: 'اللغة',
            subtitle: 'العربية',
          ),
          SettingTile(
            icon: Icons.info_outline,
            title: 'حول التطبيق',
            subtitle: 'حسبة - الإصدار 1.0.0',
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF09151E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF243A49),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFE9A52E),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF788894),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_left),
        ],
      ),
    );
  }
}
