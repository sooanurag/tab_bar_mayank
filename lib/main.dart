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
      appBar: AppBar(),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: title,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: _CustomIndicator(),
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                Placeholder(),
                Placeholder(),
              ],
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

    double borderRadius = 22;
    Radius r = Radius.circular(borderRadius);

    final boxPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.fill;

    final path = Path()
    ..moveTo(0, borderRadius)
    ..arcToPoint(Offset(borderRadius, 0),radius: r)
    ..lineTo((boxSize.width - borderRadius), 0)
    ..cubicTo((boxSize.width + borderRadius), 0, (boxSize.width - borderRadius), boxSize.height, (boxSize.width + borderRadius), boxSize.height,)
    ..lineTo(0, boxSize.height)
    ..lineTo(0, 22);

    final rRect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        offset + Offset(0, imageConfig.size!.height - boxSize.height),
        Offset(
          boxSize.width + offset.dx,
          imageConfig.size!.height,
        ),
      ),
      const Radius.circular(12),
    );

    // canvas.drawRRect(rRect, boxPaint);
    canvas.drawPath(path, boxPaint);
  }
}