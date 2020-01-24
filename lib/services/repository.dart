import 'package:pre_test_hci/services/home_api.dart';
import 'package:pre_test_hci/services/interface/response.dart';

class Repository {
  Future<Response> fetchHomeRepository() => homeApi.fetchHomeApi();
}

Repository repository = Repository();
