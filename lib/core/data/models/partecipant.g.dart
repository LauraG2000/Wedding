// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partecipant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partecipant _$PartecipantFromJson(Map<String, dynamic> json) => Partecipant(
  name: json['Name'] as String,
  surName: json['SurName'] as String,
  willJoin: json['WillJoin'] as bool,
  howManyTotals: (json['HowManyTotals'] as num).toInt(),
  howManyKids: (json['HowManyKids'] as num).toInt(),
  allergies: json['Allergies'] as String,
  allergiesNotes: json['AllergiesNotes'] as String,
  notes: json['Notes'] as String,
);

Map<String, dynamic> _$PartecipantToJson(Partecipant instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'SurName': instance.surName,
      'WillJoin': instance.willJoin,
      'HowManyTotals': instance.howManyTotals,
      'HowManyKids': instance.howManyKids,
      'Allergies': instance.allergies,
      'AllergiesNotes': instance.allergiesNotes,
      'Notes': instance.notes,
    };
