// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:gimme/constants.dart';
import 'package:http/http.dart';

class GeneratorController {
  showAllMembership(uid) {
    var response = get(Uri.http(url, "$endpoint/transaction/getAllMembership/$uid"));
    return response.then((value) => jsonDecode(value.body)['data']);
  }

  generateQrCode(int id_membership) {
    var response = post(Uri.http(url, "$endpoint/transaction/generateQrCode"),
      body: {
        'id_membership': id_membership.toString(),
      }
    );
    return response.then((value) => jsonDecode(value.body)['data']);
  }

  checkoutMembership(int id_qr) {
    var response = delete(Uri.http(url, "$endpoint/transaction/checkoutMembership"),
      body: {
        'id_qr': id_qr.toString()
      }
    );
    return response.then((value) => jsonDecode(value.body)['status']);
  }

  cancelMembership(int id_membership){
    var response = delete(Uri.http(url, "$endpoint/transaction/cancelMembership"),
      body: {
        'id_membership': id_membership.toString()
      }
    );
    return response.then((value) => jsonDecode(value.body)['status']);
  }
}