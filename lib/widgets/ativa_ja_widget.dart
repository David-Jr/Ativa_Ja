import 'package:flutter/material.dart';

class AtivaJaWidget extends StatefulWidget {
  const AtivaJaWidget({super.key});

  @override
  State<AtivaJaWidget> createState() => _AtivaJaWidgetState();
}

class _AtivaJaWidgetState extends State<AtivaJaWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onLongPress: () =>
      //     VoiceController().speak("Ativar modo de acessibilidade."),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Text(
            "Ativa Já",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}