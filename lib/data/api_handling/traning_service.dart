import 'dart:io';

import 'package:dio/dio.dart';

import 'api_path_constant.dart';

class TrainingService {
  TrainingService._internalConstructor();

  static final TrainingService _instance =
      TrainingService._internalConstructor();

  factory TrainingService() {
    return _instance;
  }

  Future<bool> training(
      {required Map<String, List<String>> trainingModelMap,
      required String userId}) async {
    List<MultipartFile> multipartFiles = [];

    List<String> keys = trainingModelMap.keys.toList();
    for (var key in keys) {
      int count = 0;
      for (var path in trainingModelMap[key]!) {
        count++;
        String fileName = '${key.toLowerCase()}.$count.${path.split('.').last}';
        multipartFiles
            .add(MultipartFile.fromFileSync(path, filename: fileName));
      }
    }

    FormData formData = FormData.fromMap({
      'userId': userId,
      'file': multipartFiles,
    });

    Response response = await Dio().post(
      'http://${APIPathConstant.API_SERVER_PATH}/api/v1/detect/train-model',
      data: formData,
      options: Options(
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          // HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return true;
      default:
        return false;
    }
  }
}
