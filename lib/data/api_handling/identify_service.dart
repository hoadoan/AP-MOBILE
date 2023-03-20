import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/api_handling/api_path_constant.dart';
import 'package:flutter_application_1/data/models/detect_result_model/detect_result_model.dart';

class IdentifyService {
  IdentifyService._internalConstructor();

  static final IdentifyService _instance =
      IdentifyService._internalConstructor();

  factory IdentifyService() {
    return _instance;
  }

  Future<DetectResultModel?> identifyObject(
      {required String evidencePath}) async {
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
        responseType: ResponseType.json,
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return DetectResultModel.fromJson(response.data);
      default:
        return null;
    }
  }
}
