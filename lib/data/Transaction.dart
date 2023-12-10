// ignore_for_file: file_names, non_constant_identifier_names

class Transaction {
  final int id_transaction, uid, id_gym, payment_amount;
  final String payment_method, payment_status, bundle, type_membership;
  DateTime? created_at, updated_at;
  Map<String, dynamic>? gym;
  Map<String, dynamic>? membership;

  Transaction({
    required this.id_transaction,
    required this.uid,
    required this.id_gym,
    required this.payment_method,
    required this.payment_status,
    required this.payment_amount,
    required this.bundle,
    required this.type_membership,
    this.created_at,
    this.updated_at,
    this.gym,
    this.membership
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id_transaction: json['id_transaction'],
      uid: json['uid'],
      id_gym: json['id_gym'],
      payment_method: json['payment_method'],
      payment_status: json['payment_status'],
      payment_amount: json['payment_amount'],
      bundle: json['bundle'],
      type_membership: json['type_membership'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      gym: json['gym'],
      membership: json['membership']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transaction': id_transaction.toString(),
      'uid': uid.toString(),
      'id_gym': id_gym.toString(),
      'payment_method': payment_method.toString(),
      'payment_status': payment_status.toString(),
      'payment_amount': payment_amount.toString(),
      'bundle': bundle.toString(),
      'type_membership': type_membership.toString(),
      'created_at': created_at.toString(),
      'updated_at': updated_at.toString(),
      'gym': gym,
      'membership': membership
    };
  }

  
}