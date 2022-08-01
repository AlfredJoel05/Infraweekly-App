class ErrorModel {
  final String message;
  final int statusCode;

  ErrorModel({this.message = 'Unknown Error', this.statusCode = 400});
}
