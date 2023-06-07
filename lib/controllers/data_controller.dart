// ignore_for_file: prefer_final_fields

import 'package:ativa_ja/models/isp.dart';
import 'package:ativa_ja/models/shortcut.dart';
import 'package:get/get.dart';

class ListsController extends GetxController {
  static RxList<Shortcut> _shortcutList = <Shortcut>[].obs;
  static RxList<Isp> _ispList = <Isp>[].obs;
  static RxList<Shortcut> _recentsList = <Shortcut>[].obs;

  void setDummyData(List<Shortcut> shortcuts, List<Isp> isps) {
    _shortcutList = shortcuts.obs;
    _ispList = isps.obs;
  }

  List<Shortcut> get shortcutList {
    return [..._shortcutList];
  }

  List<Shortcut> get favoriteShortcuts {
    return shortcutList
        .where((shortcut) => shortcut.isFavorite.value == true)
        .toList();
  }

  List<Isp> get ispList {
    return [..._ispList];
  }

  void addFavorite(int id) {
    //
  }

  void addToRecentsList(int id) {
    //
  }

  void removeFavorite(int id) {
    
    //
  }
}
