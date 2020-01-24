import 'bloc.dart';
import 'package:pre_test_hci/models/home_model.dart';
import 'package:pre_test_hci/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements Bloc {
  final _dataHomeController = BehaviorSubject<HomeModel>();

  Stream<HomeModel> get dataHome => _dataHomeController.stream;

  loadData() async {
    HomeModel homeModel = await repository.fetchHomeRepository();
    _dataHomeController.add(homeModel);
  }

  @override
  void dispose() {
    _dataHomeController.close();
  }
}

HomeBloc homeBloc = HomeBloc();
