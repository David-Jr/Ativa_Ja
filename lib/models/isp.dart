import 'dart:convert';

import 'package:flutter/material.dart';

class Isp {
  int id;
  String name;
  Color hexColor;
  String svgPath;
  Isp({
    required this.id,
    required this.name,
    required this.hexColor,
    required this.svgPath,
  });

  Isp copyWith({
    int? id,
    String? name,
    Color? hexColor,
    String? svgPath,
  }) {
    return Isp(
      id: id ?? this.id,
      name: name ?? this.name,
      hexColor: hexColor ?? this.hexColor,
      svgPath: svgPath ?? this.svgPath,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'hexColor': hexColor.value});
    result.addAll({'svgPath': svgPath});
  
    return result;
  }

  factory Isp.fromMap(Map<String, dynamic> map) {
    return Isp(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      hexColor: Color(map['hexColor']),
      svgPath: map['svgPath'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Isp.fromJson(String source) => Isp.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Isp(id: $id, name: $name, hexColor: $hexColor, svgPath: $svgPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Isp &&
      other.id == id &&
      other.name == name &&
      other.hexColor == hexColor &&
      other.svgPath == svgPath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      hexColor.hashCode ^
      svgPath.hashCode;
  }
}
