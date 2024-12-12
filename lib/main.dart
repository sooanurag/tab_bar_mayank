import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomTabBar(),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;

  final title = [const Text('Data Plan'), const Text('eSIMs')];

  @override
  void initState() {
    tabController = TabController(
      length: title.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF391D44),
      ),
      backgroundColor: Color(0xFF391D44),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: title,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: _CustomIndicator(),
            unselectedLabelColor: Colors.white,
            labelColor: Color(0xFF391D44),
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: tabController,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(24)),
                  child: ColoredBox(
                    color: Colors.white,
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        Column(),
                        Column(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Tab Bar indicator -------------------
class _CustomIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _IndicatorPainter();
  }
}

class _IndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration imageConfig) {
    final boxSize = imageConfig.size!;

    double borderRadius = 24;
    Radius r = Radius.circular(borderRadius);
    Offset i = offset + Offset(0, imageConfig.size!.height - boxSize.height);

    final boxPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo((i.dx - borderRadius), (i.dy + boxSize.height))
      ..cubicTo(
        (i.dx + borderRadius), //x1
        (i.dy + boxSize.height - 6), //y1
        (i.dx - borderRadius), //x2
        (i.dy + 6), //y2
        (i.dx + borderRadius), //x3
        i.dy, //y3
      )
      ..lineTo((i.dx + boxSize.width - borderRadius), i.dy)
      ..cubicTo(
        (i.dx + boxSize.width + borderRadius), // x1
        (i.dy + 6), // y1
        (i.dx + boxSize.width - borderRadius), // x2
        (i.dy + boxSize.height - 6), // y2
        (i.dx + boxSize.width + borderRadius), // x3
        (i.dy + boxSize.height), // y3
      )
      ..lineTo(
        i.dx,
        (i.dy + boxSize.height),
      );

    // canvas.drawRRect(rRect, boxPaint);
    canvas.drawPath(path, boxPaint);
  }
}
