import 'package:http/http.dart';
import 'package:gimme/constants.dart';

class GymController {
  getDetailGymId(int id) {
    var response = get(Uri.http(url, '$endpoint/gym/getDetailGymId/$id'));
    return response.then((value) => value.body);
  }
}