// ignore_for_file: non_constant_identifier_names, file_names

import 'package:gimme/screens/auth/model/User.dart';

class Membership {
  final int id, uid, id_gym, id_transaction;
  final DateTime start_date, end_date, created_at, updated_at;
  final User user;

  Membership({
    required this.id,
    required this.uid,
    required this.id_gym,
    required this.id_transaction,
    required this.start_date,
    required this.end_date,
    required this.created_at,
    required this.updated_at,
    required this.user
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      uid: json['uid'],
      id_gym: json['id_gym'],
      id_transaction: json['id_transaction'],
      start_date: DateTime.parse(json['start_date']),
      end_date: DateTime.parse(json['end_date']),
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'uid': uid.toString(),
      'id_gym': id_gym.toString(),
      'id_transaction': id_transaction.toString(),
      'start_date': start_date.toString(),
      'end_date': end_date.toString(),
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
      'user': user.toJson()
    };
  }
}