import 'package:ativa_ja/controllers/data_controller.dart';
import 'package:ativa_ja/controllers/voice_controller.dart';
import 'package:ativa_ja/models/shortcut.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/method_channel_controller.dart';

class BlindeFriendlyMode extends StatefulWidget {
  const BlindeFriendlyMode({super.key});

  @override
  State<BlindeFriendlyMode> createState() => _BlindeFriendlyModeState();
}

class _BlindeFriendlyModeState extends State<BlindeFriendlyMode> {
  final shortcuts = Get.find<ListsController>();
  int currentShortcut = -1;

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
    return shortcuts.shortcutList.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modo de Acessibilidade"),
        ),
        body: Column(
          children: [
            GestureDetector(
              onLongPress: () => {Get.back()},
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  // Swiping in down direction.
                  if (details.delta.dy > 0) {
                    getShortcut(currentShortcut).isFavorite = RxBool(false);
                    VoiceController().speak(
                        "${getShortcut(currentShortcut).tittle} Removido dos Favoritos");
                    //todo
                  }

                  // Swiping in up direction.
                  if (details.delta.dy < 0) {
                    Shortcut shortcut = getShortcut(currentShortcut);
                    shortcut.isFavorite = RxBool(false);
                    VoiceController().speak(
                        "${getShortcut(currentShortcut).tittle} Adicionado aos Favoritos");
                    //todo
                  }
                },
                onDoubleTap: () => {
                  VoiceController().speak("Shortcut Selecionado, Ativando..."),
                  //todo: Warn if service is not active
                  MethodChannelController().executeUSSD(
                      getShortcut(currentShortcut).ussdCode,
                      getShortcut(currentShortcut).steps,
                      getShortcut(currentShortcut).isp.name),
                  //todo
                },
                onHorizontalDragUpdate: (details) {
                  int sensitivity = 8;
                  if (details.delta.dx > sensitivity) {
                    //Right Swipe - Previous shortcut
                    if (currentShortcut != 0) {
                      currentShortcut--;
                      VoiceController()
                          .speak(getShortcut(currentShortcut).description);
                    } else {
                      VoiceController()
                          .speak(getShortcut(currentShortcut).description);
                    }
                    //todo
                  } else if (details.delta.dx < -sensitivity) {
                    //Left Swipe - Next shortcut
                    if (currentShortcut != shortcuts.shortcutList.length - 1) {
                      currentShortcut++;
                      VoiceController()
                          .speak(getShortcut(currentShortcut).description);
                    } else {
                      VoiceController()
                          .speak(getShortcut(currentShortcut).description);
                    }
                  }
                },
                child: Container(
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ));
  }
}
