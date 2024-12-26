import 'package:flutter/material.dart';

class InteractiveText extends StatelessWidget {
  final List<TextSpan> textSpans;

  const InteractiveText({super.key, required this.textSpans});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: textSpans));
  }
}
