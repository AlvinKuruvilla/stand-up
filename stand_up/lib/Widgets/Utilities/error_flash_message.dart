import 'package:flutter/material.dart';

class ErrorFlashMessage extends StatelessWidget {
  const ErrorFlashMessage({
    Key? key,
    required this.errorText,
    required this.title,
  }) : super(key: key);
  final String errorText;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    errorText,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
