import 'package:flutter/cupertino.dart';
import 'package:stand_up/Widgets/timer_painter.dart';
import 'package:flutter/material.dart';

// TODO: The pause button does not turn back into a play button when pressed
// TODO: Add functionality to reset the timer when a session is started
// TODO: Show timer progress as it gets closer to zero

class AnimatedClock extends StatefulWidget {
  const AnimatedClock({super.key});

  @override
  _AnimatedClockState createState() => _AnimatedClockState();
}

class _AnimatedClockState extends State<AnimatedClock>
    with TickerProviderStateMixin {
  // Animation
  late AnimationController animationController;

  String get timerString {
    Duration duration =
        animationController.duration! * animationController.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}\n${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1500));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 52, right: 52, bottom: 0, top: 70),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: AnimatedBuilder(
                                animation: animationController,
                                builder: (BuildContext context, Widget? child) {
                                  return CustomPaint(
                                      painter: TimerPainter(
                                          animation: animationController,
                                          backgroundColor: const Color.fromRGBO(
                                              92, 211, 62, 1),
                                          color: const Color.fromRGBO(
                                              92, 211, 62, 1)));
                                }),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedBuilder(
                                  animation: animationController,
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Text(
                                      timerString,
                                      style: const TextStyle(
                                          fontSize: 85.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Text(
                        "Task Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            shadows: [
                              Shadow(
                                  blurRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  offset: Offset(0, 3))
                            ],
                            fontSize: 40),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            "0/4",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 4,
                              shadows: [
                                Shadow(
                                    blurRadius: 5,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                    offset: Offset(0, 3))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return SizedBox(
                          width: 75.0,
                          height: 75.0,
                          child: RawMaterialButton(
                            fillColor: Colors.white,
                            shape: const CircleBorder(),
                            elevation: 1.0,
                            child: Icon(
                                (animationController.isAnimating)
                                    ? CupertinoIcons.pause_solid
                                    : CupertinoIcons.play_arrow_solid,
                                size: 48,
                                color: const Color.fromRGBO(92, 211, 62, 1)),
                            onPressed: () {
                              if (animationController.isAnimating) {
                                animationController.stop();
                              } else {
                                animationController.reverse(
                                    from: animationController.value == 0.0
                                        ? 1.0
                                        : animationController.value);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
