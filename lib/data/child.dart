import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class Child {
  Child(
      {@required this.id,
      @required this.firstName,
      @required this.imageAssetPath,
      @required this.dateOfBirth,
      @required this.gender});

  final int id;

  final String firstName;

  final String imageAssetPath;

  final DateTime dateOfBirth;

  final GenderCategory gender;

  // Methods
  DateTime get getBirthday => dateOfBirth;

  String get genderName => genderCategoryNames[gender];
}

enum GenderCategory { girl, boy }

const Map<GenderCategory, String> genderCategoryNames = {
  GenderCategory.girl: 'Girl',
  GenderCategory.boy: 'Boy'
};
