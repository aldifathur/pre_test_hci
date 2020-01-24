abstract class Status{}

class StatusSuccess extends Status {
  StatusSuccess();
}

class StatusError extends Status {
  String error;
  StatusError(this.error);
}

class StatusLoading extends Status {
  StatusLoading();
}