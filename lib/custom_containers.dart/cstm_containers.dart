import 'package:flutter/material.dart';

class CstmContainer extends StatelessWidget {
  final double? cstmWidth;
  final double? cstmHeight;
  final Color colorinput;
  final double cstmRadius;
  final String textInput1;
  final String textInput2;
  final bool showTextInput3;

  const CstmContainer({
    super.key,
    required this.textInput1,
    required this.textInput2,
    required this.cstmRadius,
    required this.cstmHeight,
    required this.cstmWidth,
    required this.colorinput,
    required this.showTextInput3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: cstmHeight,
        width: cstmWidth,
        decoration: BoxDecoration(
          color: colorinput,
          borderRadius: BorderRadius.circular(cstmRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                textInput1,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                textInput2,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            if (showTextInput3)
              const Text(
                'Last updated: April 13, 2024, 01:00 GMT',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              ),
          ],
        ),
      ),
    );
  }
}
