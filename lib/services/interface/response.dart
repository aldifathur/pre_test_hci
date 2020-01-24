abstract class Response {}

class Success extends Response {
  String data;
  Success(this.data);
}

class Error extends Response {
  String error;
  Error(this.error);
}
