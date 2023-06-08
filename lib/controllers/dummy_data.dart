// ignore_for_file: constant_identifier_names

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
  Shortcut(
    id: 3,
    tittle: "5mt = 100mb, 6h, via Emola",
    steps: "6;2;1;1;1",
    ussdCode: "*155#",
    description: "Activar megas de 5 meticais de duração de uma hora",
    isFavorite: RxBool(false),
    isp: dummyIspList[MOVITEL],
  ),
  Shortcut(
    id: 4,
    tittle: "6mt = 500mb, 1h, via Emola",
    steps: "6;2;2;1;1",
    ussdCode: "*155#",
    description: "Activar megas de 6 meticais de duração de 6 horas",
    isFavorite: RxBool(false),
    isp: dummyIspList[MOVITEL],
  ),
  // Shortcut(
  //   id: 5,
  //   tittle: "Meu PUK",
  //   steps: "10;8;844333161",
  //   ussdCode: "*111#",
  //   description: "Mostrar o meu puk vodacom",
  //   isFavorite: RxBool(false),
  //   isp: dummyIspList[VODACOM],
  // ),
  // Shortcut(
  //   id: 6,
  //   tittle: "Meu PUK",
  //   steps: "10;8;844333161",
  //   ussdCode: "*111#",
  //   description: "Mostrar o meu puk vodacom",
  //   isFavorite: RxBool(false),
  //   isp: dummyIspList[VODACOM],
  // ),
  // Shortcut(
  //   id: 7,
  //   tittle: "Meu PUK",
  //   steps: "10;8;844333161",
  //   ussdCode: "*111#",
  //   description: "Mostrar o meu puk vodacom",
  //   isFavorite: RxBool(false),
  //   isp: dummyIspList[VODACOM],
  // ),
  // Shortcut(
  //   id: 8,
  //   tittle: "Meu PUK",
  //   steps: "10;8;844333161",
  //   ussdCode: "*111#",
  //   description: "Mostrar o meu puk vodacom",
  //   isFavorite: RxBool(false),
  //   isp: dummyIspList[VODACOM],
  // ),
  // Shortcut(
  //   id: 9,
  //   tittle: "Meu PUK",
  //   steps: "10;8;844333161",
  //   ussdCode: "*111#",
  //   description: "Mostrar o meu puk vodacom",
  //   isFavorite: RxBool(false),
  //   isp: dummyIspList[VODACOM],
  // ),
  // Shortcut(
  //   id: 10,
  //   tittle: "Meu PUK",
  //   steps: "10;8;844333161",
  //   ussdCode: "*111#",
  //   description: "Mostrar o meu puk vodacom",
  //   isFavorite: RxBool(false),
  //   isp: dummyIspList[VODACOM],
  // ),
];
