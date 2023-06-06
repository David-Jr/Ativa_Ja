import 'dart:ui';

import 'package:get/get.dart';

import '../models/isp.dart';
import '../models/shortcut.dart';

const int MOVITEL = 0;
const int VODACOM = 1;
const int TMCEL = 2;
final List<Isp> dummyIspList = [
  Isp(
    id: 0,
    name: "Movitel",
    hexColor: Color(int.parse("0xFFF57C00")),
    svgPath: "lib/assets/movitel-logo.svg",
  ),
  Isp(
    id: 1,
    name: "Vodacom",
    hexColor: Color(int.parse("0xFFF44336")),
    svgPath: "lib/assets/vodacom-logo.svg",
  ),
  Isp(
    id: 2,
    name: "Tmcel",
    hexColor: Color(int.parse("0xFFFFEB3B")),
    svgPath: "lib/assets/movitel-logo.svg",
  ),
];

final List<Shortcut> dummyShortcutList = [
  Shortcut(
    id: 1,
    tittle: "Minhas Informações",
    steps: "12;1",
    ussdCode: "*155#",
    description: "Mostrar as minhas informações movitel",
    isFavorite: RxBool(false),
    isp: dummyIspList[MOVITEL],
  ),
  Shortcut(
    id: 2,
    tittle: "Meu PUK",
    steps: "10;8;844333161",
    ussdCode: "*111#",
    description: "Mostrar o meu puk vodacom",
    isFavorite: RxBool(false),
    isp: dummyIspList[VODACOM],
  ),
];
