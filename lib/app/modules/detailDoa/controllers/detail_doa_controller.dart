import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/Doa.dart';

class DetailDoaController extends GetxController {
  //TODO: Implement DetailDoaController

  Future<List<Doa>> getAllDoa() async {
    Uri url = Uri.parse("https://doa-doa-api-ahmadramadhan.fly.dev/api");
    var res = await http.get(url);

    List<dynamic> responseData = json.decode(res.body);
    if (responseData == null || responseData.isEmpty) {
      return [];
    } else {
      return responseData.map((e) => Doa.fromJson(e)).toList();
    }
  }
}
