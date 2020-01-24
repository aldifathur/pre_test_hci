class ErrorModel {
  String statusMessage;

  ErrorModel.getData(Map<String, dynamic> data) {
    statusMessage = data['status_message'];
  }
}
