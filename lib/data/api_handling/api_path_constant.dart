// ignore_for_file: constant_identifier_names

class APIPathConstant {
  APIPathConstant._internalConstructor();

  static final APIPathConstant _instance =
      APIPathConstant._internalConstructor();

  factory APIPathConstant() {
    return _instance;
  }

  // static const API_SERVER_PATH = '0707-34-87-2-184.ngrok.io';
  static const API_SERVER_PATH = '10.0.2.2:5000';
}
