import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/api_handling/api_path_constant.dart';

class IdentifyService {
  IdentifyService._internalConstructor();

  static final IdentifyService _instance =
      IdentifyService._internalConstructor();

  factory IdentifyService() {
    return _instance;
  }

  Future<Uint8List?> identifyObject({required String evidencePath}) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(evidencePath),
    });

    Response response = await Dio().post(
      'http://${APIPathConstant.API_SERVER_PATH}/api/v1/detect/system-model',
      data: formData,
      options: Options(
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          // HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
        },
        responseType: ResponseType.bytes,
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return response.data;
      default:
        return null;
    }
  }
}
