import 'package:http/http.dart';
import 'package:gimme/constants.dart';

class MapsController {
  getGymDetail(double lat, double lng) {
    var response = get(Uri.http(url, '$endpoint/gym/getMapsDetailGym/$lat/$lng'));
    return response.then((value) => value.body);
  }

  getGymDetailId(int id) {
    var response = get(Uri.http(url, '$endpoint/gym/getDetailGymId/$id'));
    return response.then((value) => value.body);
  }
}