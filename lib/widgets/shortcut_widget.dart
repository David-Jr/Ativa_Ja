import 'package:ativa_ja/controllers/voice_controller.dart';
import 'package:ativa_ja/models/shortcut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/data_controller.dart';
import '../controllers/method_channel_controller.dart';

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
      child: ListTile(
          onTap: () async => {
                if (!await MethodChannelController().isServiceEnabled())
                  {
                    _promptServiceActivation(),
                  }
                else
                  {
                    if (await _checkCallPhonePermission())
                      {
                        MethodChannelController().executeUSSD(
                            widget.shortcut.ussdCode,
                            widget.shortcut.steps,
                            widget.shortcut.isp.name),
                        ListsController().addToRecentsList(widget.shortcut.id),
                        // HiveData().addRecentes(widget.id),
                      }
                    else
                      {_requestCallPhonePermission()}
                  },
              },
          onLongPress: () =>
              VoiceController().speak(widget.shortcut.description),
          leading: SvgPicture.asset(
            widget.shortcut.isp.svgPath,
            // ignore: deprecated_member_use
            color: widget.shortcut.isp.hexColor,
            height: 30,
            width: 30,
          ),
          title: Text(widget.shortcut.tittle),
          trailing: IconButton(
            onPressed: () {
              //todo
              if (widget.shortcut.isFavorite.isTrue) {
                // HiveData().removeFavorite(widget.id);
                ListsController().removeFavorite(widget.shortcut.id);
                _showConfirmationSnackBar();
                setState(() {});
              } else {
                // HiveData().addFavorito(widget.id);
                ListsController().addFavorite(widget.shortcut.id);
                setState(() {});
              }
            },
            icon: Icon(
              Icons.favorite,
              color:
                  widget.shortcut.isFavorite.isTrue ? Colors.pink : Colors.grey,
            ),
          ),
          subtitle: Text(widget.shortcut.isp.name),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  void _showConfirmationSnackBar() {
    Get.snackbar(
      'Cancelar Acção',
      'Clique no botão para cancelar acção',
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
      showProgressIndicator: true,
      padding: const EdgeInsets.all(18),
      mainButton: TextButton.icon(
        onPressed: () {
          ListsController().addFavorite(widget.shortcut.id);
          //todo
          Get.back();
        },
        icon: const Icon(Icons.undo),
        label: const Text("Cancelar"),
      ),
    );
  }

  void _promptServiceActivation() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8.0,
                ),
                child: Text(
                  "Clique no botão abaixo para permitir que o aplicativo funcione correctamente",
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                child: const Text("Permitir Ativa Já"),
                onPressed: () {
                  MethodChannelController().enableService();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkCallPhonePermission() async {
    final PermissionStatus permissionStatus = await Permission.phone.status;
    return permissionStatus == PermissionStatus.granted;
  }

  Future<void> _requestCallPhonePermission() async {
    final PermissionStatus permissionStatus = await Permission.phone.request();
    if (permissionStatus == PermissionStatus.granted) {
      // Permission granted.
    } else {
      // Permission not granted.
    }
  }
}
