import 'package:flutter/material.dart';

class TOFDashboard extends StatelessWidget {
  const TOFDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 224, width: double.infinity,
          //  color: Color(0xFF0070BA)
          color: Colors.purple,
        ),
        SizedBox(
          height: 224,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  left: -156,
                  top: -96,
                  child: Opacity(
                    opacity: 0.16,
                    child: Image.asset(
                      "images/blob.png",
                      color: Colors.white,
                      height: 480,
                    ),
                  )),
            ],
          ),
        ),
        Positioned(
            // top: 128,
            bottom: -60,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 64,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/tof.png",
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ))
      ],
    );
  }
}
