import 'dart:convert';

import 'package:get/get.dart';

import 'isp.dart';

class Shortcut {
  int id;
  String tittle;
  String steps;
  String ussdCode;
  String description;
  Isp isp;
  RxBool isFavorite;

  Shortcut({
    required this.id,
    required this.tittle,
    required this.steps,
    required this.ussdCode,
    required this.description,
    required this.isp,
    required this.isFavorite,
  });

  

  Shortcut copyWith({
    int? id,
    String? tittle,
    String? steps,
    String? ussdCode,
    String? description,
    Isp? isp,
    RxBool? isFavorite,
  }) {
    return Shortcut(
      id: id ?? this.id,
      tittle: tittle ?? this.tittle,
      steps: steps ?? this.steps,
      ussdCode: ussdCode ?? this.ussdCode,
      description: description ?? this.description,
      isp: isp ?? this.isp,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'tittle': tittle});
    result.addAll({'steps': steps});
    result.addAll({'ussdCode': ussdCode});
    result.addAll({'description': description});
    result.addAll({'isp': isp.toMap()});
    result.addAll({'isFavorite': isFavorite});
  
    return result;
  }

  factory Shortcut.fromMap(Map<String, dynamic> map) {
    return Shortcut(
      id: map['id']?.toInt() ?? 0,
      tittle: map['tittle'] ?? '',
      steps: map['steps'] ?? '',
      ussdCode: map['ussdCode'] ?? '',
      description: map['description'] ?? '',
      isp: Isp.fromMap(map['isp']),
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Shortcut.fromJson(String source) => Shortcut.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shortcut(id: $id, tittle: $tittle, steps: $steps, ussdCode: $ussdCode, description: $description, isp: $isp, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Shortcut &&
      other.id == id &&
      other.tittle == tittle &&
      other.steps == steps &&
      other.ussdCode == ussdCode &&
      other.description == description &&
      other.isp == isp &&
      other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tittle.hashCode ^
      steps.hashCode ^
      ussdCode.hashCode ^
      description.hashCode ^
      isp.hashCode ^
      isFavorite.hashCode;
  }
}
