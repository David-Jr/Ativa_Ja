import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/data_controller.dart';
import '../../widgets/shortcut_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final shortcuts = Get.find<ListsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => ListView.builder(
          itemCount: shortcuts.shortcutList.length,
          itemBuilder: (context, index) {
            return ShortcutWidget(shortcut: shortcuts.shortcutList[index]);
          },
        ),
      ),
    );
  }
}
