import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lilac_flutter_machine_test/services/extensions.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserLoginModel {
  final String userId;
  final String userName;
  final String name;
  final String email;
  final String image;
  final DateTime dob;
  final String phoneNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserLoginModel({
    required this.userId,
    required this.userName,
    required this.name,
    required this.email,
    required this.image,
    required this.dob,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserLoginModel.fromFirestore(DocumentSnapshot map) {
    return UserLoginModel(
      userId: map['user_id'] as String,
      userName: map['user_name'] as String,
      name: map['name'] as String,
      email: map['email_id'] as String,
      image: map['image'] as String,
      phoneNumber: map['phone_number'] as String,
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      // updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      dob: (map['dob'] as Timestamp).toDate(),
      createdAt: convertToDateTime(map['created_at']),
      updatedAt: convertToDateTime(map['updated_at']),
    );
  }
}
