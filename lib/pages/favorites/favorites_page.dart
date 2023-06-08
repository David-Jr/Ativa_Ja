import 'package:ativa_ja/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/shortcut_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final shortcuts = Get.find<ListsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => ListView.builder(
          itemCount: shortcuts.favoriteShortcuts.length,
          itemBuilder: (context, index) {
            return ShortcutWidget(shortcut: shortcuts.favoriteShortcuts[index]);
          },
        ),
      );
  }
}
