import 'package:ativa_ja/controllers/voice_controller.dart';
import 'package:ativa_ja/models/shortcut.dart';
import 'package:flutter/material.dart';

class BlindeFriendlyMode extends StatefulWidget {
  const BlindeFriendlyMode({super.key});

  @override
  State<BlindeFriendlyMode> createState() => _BlindeFriendlyModeState();
}

class _BlindeFriendlyModeState extends State<BlindeFriendlyMode> {
  final shortcuts = <Shortcut>[];
  int currentSHortcut = 0;

  @override
  void initState() {
    VoiceController().speak("Modo de acessibilidade activado");
    super.initState();
  }

  @override
  void dispose() {
    VoiceController().speak("Modo de Acessibilidade Desactivado");
    super.dispose();
  }

  Shortcut getShortcut(int index) {
    return shortcuts.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
        //todo
        );
  }
}
