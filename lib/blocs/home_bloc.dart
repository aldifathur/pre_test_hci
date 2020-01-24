import 'bloc.dart';
import 'dart:convert';
import 'package:pre_test_hci/models/home_model.dart';
import 'package:pre_test_hci/services/interface/response.dart';
import 'package:pre_test_hci/services/interface/status.dart';
import 'package:pre_test_hci/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc implements Bloc {
  final _dataHomeController = BehaviorSubject<HomeModel>();
  final _statusController = BehaviorSubject<Status>();

  Stream<HomeModel> get dataHome => _dataHomeController.stream;
  Observable<Status> get statusStream => _statusController.stream;

  loadData() async {
    Response response = await repository.fetchHomeRepository();
    if (response is Success) {
      HomeModel homeModel = HomeModel.fromJson(json.decode(response.data));
      _dataHomeController.add(homeModel);
      _statusController.add(StatusSuccess());
    } else if (response is Error) {
      _statusController.add(StatusError('Failed to load data'));
    }
  }

  @override
  void dispose() {
    _dataHomeController.close();
    _statusController.close();
  }
}

HomeBloc homeBloc = HomeBloc();
