import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:pre_test_hci/models/home_model.dart';

class HomeApi {
  Client client = Client();
  final _baseUrl = 'https://private-a8e48-hcidtest.apiary-mock.com/home';

  Future<HomeModel> fetchHomeApi() async {
    final response = await client.get('$_baseUrl');

    if (response.statusCode == 200) {
      return HomeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}

HomeApi homeApi = HomeApi();
