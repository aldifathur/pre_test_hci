import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:pre_test_hci/models/error_model.dart';
import 'package:pre_test_hci/models/home_model.dart';
import 'package:pre_test_hci/services/interface/response.dart';

class HomeApi {
  Client client = Client();
  final _baseUrl = 'https://private-a8e48-hcidtest.apiary-mock.com/home';

  Future<Response> fetchHomeApi() async {
    final response = await client.get('$_baseUrl');

    if (response.statusCode == 200) {
      HomeModel.fromJson(json.decode(response.body));
      return Success(response.body);
    } else {
      ErrorModel errorModel =
          ErrorModel.getData({"status_messageatus": "Failed to load data"});
      return Error(errorModel.statusMessage);
    }
  }
}

HomeApi homeApi = HomeApi();
