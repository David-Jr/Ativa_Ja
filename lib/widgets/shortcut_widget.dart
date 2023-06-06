import 'package:ativa_ja/models/shortcut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ShortcutWidget extends StatefulWidget {
  const ShortcutWidget({
    super.key,
    required this.shortcut,
  });

  final Shortcut shortcut;
  @override
  State<ShortcutWidget> createState() => _ShortcutWidgetState();
}

class _ShortcutWidgetState extends State<ShortcutWidget> {
  final FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
    );
  }
}
