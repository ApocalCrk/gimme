// ignore_for_file: file_names, non_constant_identifier_names
import 'package:http/http.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/transactions/model/Transaction.dart';

final List<String> payment_method = [
  'Credit Card',
  'Debit Card',
  'Paypal',
  'Google Pay'
];

class TransactionController {
 Future<String?> sendTransaction(Map<String, dynamic> data) async {
    try {
      var response = await post(
        Uri.http(url, '$endpoint/transaction/sendTransaction'),
        body: data,
      );
      return response.body;
    } catch (e) {
      return null;
    }
  }
}