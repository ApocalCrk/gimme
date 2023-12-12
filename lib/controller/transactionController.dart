// ignore_for_file: file_names, non_constant_identifier_names
import 'package:http/http.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/data/Transaction.dart';

final List<String> payment_method = [
  'Credit Card',
  'Debit Card',
  'Paypal',
  'Google Pay'
];

class TransactionController {
 Future<String?> sendTransaction(Transaction tr) async {
    try {
      var response = await post(
        Uri.http(url, '$endpoint/transaction/sendTransaction'),
        body: {
          'id_transaction': tr.id_transaction.toString(),
          'uid': tr.uid.toString(),
          'id_gym': tr.id_gym.toString(),
          'payment_method': tr.payment_method,
          'payment_status': tr.payment_status,
          'payment_amount': tr.payment_amount.toString(),
          'bundle': tr.bundle,
          'type_membership': tr.type_membership
        }
      );
      return response.body;
    } catch (e) {
      return null;
    }
  }
}