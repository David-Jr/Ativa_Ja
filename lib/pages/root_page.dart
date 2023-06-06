import 'package:ativa_ja/pages/blind/blind_friendly_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/ativa_ja_widget.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int activePointers = 0;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        setState(() {
          activePointers++;
        });
      },
      onPointerUp: (event) {
        setState(() {
          activePointers--;
        });
      },
      onPointerMove: (event) {
        if (activePointers == 2 && event.delta.dy > 0) {
          activePointers = 0;
          Get.to(() => const BlindeFriendlyMode());
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const AtivaJaWidget(),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(icon: Icon(Icons.home), iconMargin: EdgeInsets.zero),
                Tab(icon: Icon(Icons.favorite), iconMargin: EdgeInsets.zero),
                Tab(icon: Icon(Icons.history), iconMargin: EdgeInsets.zero),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
