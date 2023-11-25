class Transaction {
  int? id_transaction;
  final int uid, id_gym, payment_amount;
  final String payment_method, payment_status, bundle, type_membership;

  Transaction({
    this.id_transaction,
    required this.uid,
    required this.id_gym,
    required this.payment_method,
    required this.payment_status,
    required this.payment_amount,
    required this.bundle,
    required this.type_membership
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
      type_membership: json['type_membership']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transaction': id_transaction,
      'uid': uid,
      'id_gym': id_gym,
      'payment_method': payment_method,
      'payment_status': payment_status,
      'payment_amount': payment_amount,
      'bundle': bundle,
      'type_membership': type_membership
    };
  }

  
}