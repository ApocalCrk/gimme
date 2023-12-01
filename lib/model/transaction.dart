import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Transaction {
  String? gymName;
  String? id;
  String? date;
  String? price;
  String? type;
  String? package;
  String? duration;

  Transaction(
      {this.duration,
      this.date,
      this.gymName,
      this.package,
      this.price,
      this.type,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'gymName': gymName,
      'date': date,
      'price': price,
      'type': type,
      'package': package,
      'duration': duration,
      'id': id,
    };
  }

  Transaction.fromMap(Map<String, dynamic> TransactionMap)
      : gymName = TransactionMap["gymName"],
        date = TransactionMap["date"],
        price = TransactionMap["price"],
        type = TransactionMap["type"],
        package = TransactionMap["package"],
        duration = TransactionMap["duration"],
        id = TransactionMap["id"];
}

var now = DateTime.now();
var date_format = DateFormat('dd/MM/yy kk:mm');
String actualDate = date_format.format(now);

List<Transaction> dataDummy = [
  Transaction(
      duration: '1 Year Membership',
      gymName: 'Gimme1',
      package: 'Gold Membership',
      price: '1200000',
      type: 'Membership',
      date: actualDate),
  Transaction(
      duration: '1 day visiting',
      gymName: 'Gimme2',
      package: 'Silver Membership',
      price: '200000',
      type: 'Visiting',
      date: '15-11-2023'),
  Transaction(
      duration: '1 Year Membership',
      gymName: 'Gimme3',
      package: 'Membership',
      price: '1500000',
      type: 'Membership',
      date: '15-11-2023')
];

Future createTransaction(Transaction transaction) async {
  final docTransaction =
      FirebaseFirestore.instance.collection('transaction').doc();
  transaction.id = docTransaction.id;
  final json = transaction.toMap();
  await docTransaction.set(json).then((value) => print('kontolBesar'));
}

Future<List<Transaction>> listData() async {
  final snapshot =
      await FirebaseFirestore.instance.collection('transaction').get();
  final dataTransaction =
      snapshot.docs.map((e) => Transaction.fromMap(e.data())).toList();
  return dataTransaction;
}
