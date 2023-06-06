import 'package:carrier_info/carrier_info.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: FlexThemeData.light(
        scheme: FlexScheme.mandyRed,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.mandyRed,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      title: 'Ativa Já',
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const TestHomePage(),
    );
  }
}

// ======================================================================
class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  final events = [];
  int activePointers = 0;
  AndroidCarrierData? _androidInfo;
  AndroidCarrierData? get androidInfo => _androidInfo;
  set androidInfo(AndroidCarrierData? androidCarrierData) {
    setState(() => _androidInfo = androidCarrierData);
  }

  @override
  void initState() {
    super.initState();
    initCarrierInfo();
  }

  Future<void> initCarrierInfo() async {
    await [
      Permission.locationWhenInUse,
      Permission.phone,
      Permission.sms,
    ].request();

    try {
      androidInfo = await CarrierInfo.getAndroidInfo();
      print(androidInfo as String);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.deepPurple,
        child: Column(
          children: [
            Center(child: Text('${androidInfo?.isMultiSimSupported}')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => initCarrierInfo(),
        child: const Icon(Icons.settings),
      ),
    );
  }
}
