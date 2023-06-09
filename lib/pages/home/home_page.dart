import 'package:ativa_ja/controllers/data_controller.dart';
import 'package:ativa_ja/widgets/shortcut_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final shortcuts = Get.find<ListsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implemen...
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(milliseconds: 300));
          },
          child: ListView.builder(
            itemCount: shortcuts.shortcutList.length,
            itemBuilder: (context, index) {
              return ShortcutWidget(shortcut: shortcuts.shortcutList[index]);
            },
          ),
        ),
      ),
    );
  }
}
