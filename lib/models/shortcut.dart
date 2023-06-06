import 'dart:convert';

class Shortcut {
  int id;
  String tittle;
  String steps;
  String ussdCode;
  String description;
  int ispCode;
  bool isFavorite;

  Shortcut({
    required this.id,
    required this.tittle,
    required this.steps,
    required this.ussdCode,
    required this.description,
    required this.ispCode,
    required this.isFavorite,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Shortcut &&
        other.id == id &&
        other.tittle == tittle &&
        other.steps == steps &&
        other.ussdCode == ussdCode &&
        other.description == description &&
        other.ispCode == ispCode &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tittle.hashCode ^
        steps.hashCode ^
        ussdCode.hashCode ^
        description.hashCode ^
        ispCode.hashCode ^
        isFavorite.hashCode;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'tittle': tittle});
    result.addAll({'steps': steps});
    result.addAll({'ussdCode': ussdCode});
    result.addAll({'description': description});
    result.addAll({'ispCode': ispCode});
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
      ispCode: map['ispCode']?.toInt() ?? 0,
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shortcut.fromJson(String source) =>
      Shortcut.fromMap(json.decode(source));

  Shortcut copyWith({
    int? id,
    String? tittle,
    String? steps,
    String? ussdCode,
    String? description,
    int? ispCode,
    bool? isFavorite,
  }) {
    return Shortcut(
      id: id ?? this.id,
      tittle: tittle ?? this.tittle,
      steps: steps ?? this.steps,
      ussdCode: ussdCode ?? this.ussdCode,
      description: description ?? this.description,
      ispCode: ispCode ?? this.ispCode,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() {
    return 'Shortcut(id: $id, tittle: $tittle, steps: $steps, ussdCode: $ussdCode, description: $description, ispCode: $ispCode, isFavorite: $isFavorite)';
  }
}
