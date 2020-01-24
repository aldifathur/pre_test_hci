import 'package:pre_test_hci/models/home_model.dart';
import 'package:pre_test_hci/services/home_api.dart';

class Repository {
  Future<HomeModel> fetchHomeRepository() => homeApi.fetchHomeApi();
}

Repository repository = Repository();
