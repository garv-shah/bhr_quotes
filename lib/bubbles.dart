import 'dart:math';
import 'package:flutter/material.dart';

class Bubbles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BubblesState();
  }
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  List<Bubble>? bubbles;
  final int numberOfBubbles = 200;
  final Color color = Color.fromRGBO(99, 139, 127, 0.7);
  final double maxBubbleSize = 10.0;
  final bool applyElevationOverlayColor = true;

  @override
  void initState() {
    super.initState();

    // Initialize bubbles
    bubbles = [];
    int i = numberOfBubbles;
    while (i > 0) {
      bubbles!.add(Bubble(color, maxBubbleSize));
      i--;
    }

    // Init animation controller
    _controller = new AnimationController(
        duration: const Duration(seconds: 1000), vsync: this);
    _controller!.addListener(() {
      updateBubblePosition();
    });
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            foregroundPainter:
                BubblePainter(bubbles: bubbles, controller: _controller),
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(99, 139, 127, 0.7),
    );
  }

  void updateBubblePosition() {
    bubbles!.forEach((it) => it.updatePosition());
    setState(() {});
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble>? bubbles;
  AnimationController? controller;

  BubblePainter({this.bubbles, this.controller});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    bubbles!.forEach((it) => it.draw(canvas, canvasSize));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  late Color colour;
  late double direction;
  late double speed;
  late double radius;
  double? x;
  double? y;

  Bubble(Color colour, double maxBubbleSize) {
    this.colour = colour.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = 1;
    this.radius = Random().nextDouble() * maxBubbleSize;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawCircle(Offset(x!, y!), radius, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }

  updatePosition() {
    if (x != null && y != null) {
      var a = 180 - (direction + 90);

      direction > 0 && direction < 180
          ? x = x! + speed * sin(direction) / sin(speed)
          : x = x! - speed * sin(direction) / sin(speed);

      direction > 90 && direction < 270
          ? y = y! + speed * sin(a) / sin(speed)
          : y = y! - speed * sin(a) / sin(speed);
    }
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x! > canvasSize.width || x! < 0 || y! > canvasSize.height || y! < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
