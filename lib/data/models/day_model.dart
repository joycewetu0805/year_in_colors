import 'package:hive/hive.dart';
import '../../domain/entities/day_entity.dart';

part 'day_model.g.dart';

@HiveType(typeId: 1)
class DayModel {
  @HiveField(0)
  final DateTime date;
  
  @HiveField(1)
  final int value; // -1 = bad, 0 = neutral, 1 = good
  
  DayModel({
    required this.date,
    required this.value,
  });
  
  // Convertir depuis l'entité métier
  factory DayModel.fromEntity(DayEntity entity) {
    return DayModel(
      date: entity.date,
      value: entity.value.toInt(),
    );
  }
  
  // Convertir vers l'entité métier
  DayEntity toEntity() {
    return DayEntity(
      date: date,
      value: DayStatusValue.fromInt(value),
    );
  }
  
  // Créer un modèle vide
  factory DayModel.empty(DateTime date) {
    return DayModel(
      date: DateTime(date.year, date.month, date.day),
      value: 0,
    );
  }
  
  // Copier avec modifications
  DayModel copyWith({
    DateTime? date,
    int? value,
  }) {
    return DayModel(
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }
  
  // Générateur de clé Hive
  String get hiveKey {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  
  static String generateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is DayModel &&
        other.date.year == date.year &&
        other.date.month == date.month &&
        other.date.day == date.day &&
        other.value == value;
  }
  
  @override
  int get hashCode {
    return Object.hash(date, value);
  }
  
  @override
  String toString() {
    return 'DayModel(date: $date, value: $value)';
  }
}