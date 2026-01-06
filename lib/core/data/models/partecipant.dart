import 'package:json_annotation/json_annotation.dart';

part 'partecipant.g.dart';

@JsonSerializable()
class Partecipant {
  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'SurName')
  final String surName;

  @JsonKey(name: 'WillJoin')
  final bool willJoin;

  @JsonKey(name: 'HowManyTotals')
  final int howManyTotals;

  @JsonKey(name: 'HowManyKids')
  final int howManyKids;

  @JsonKey(name: 'Allergies')
  final String allergies;

  @JsonKey(name: 'AllergiesNotes')
  final String allergiesNotes;

  @JsonKey(name: 'Notes')
  final String notes;

  Partecipant({
    required this.name,
    required this.surName,
    required this.willJoin,
    required this.howManyTotals,
    required this.howManyKids,
    required this.allergies,
    required this.allergiesNotes,
    required this.notes,
  });

  factory Partecipant.fromJson(Map<String, dynamic> json) => _$PartecipantFromJson(json);

  Map<String, dynamic> toJson() => _$PartecipantToJson(this);
}
