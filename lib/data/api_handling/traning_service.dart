import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'api_path_constant.dart';

class TrainingService {
  TrainingService._internalConstructor();

  static final TrainingService _instance =
      TrainingService._internalConstructor();

  factory TrainingService() {
    return _instance;
  }

  Future<bool> training({
    required Map<String, List<String>> trainingModelMap,
    required String id,
  }) async {
    List<MultipartFile> imageMultipartFiles = [];
    List<MultipartFile> labelMultipartFiles = [];

    List<String> keys = trainingModelMap.keys.toList();
    for (var key in keys) {
      int count = 0;
      for (var path in trainingModelMap[key]!) {
        count++;

        String fileName = '${key.toLowerCase()}$count';
        String imageFileName = '$fileName.${path.split('.').last}';
        log(imageFileName);

        imageMultipartFiles
            .add(MultipartFile.fromFileSync(path, filename: imageFileName));

        File image = File(path);
        decodeImageFromList(
          image.readAsBytesSync(),
          (result) async {
            final Directory directory =
                await getApplicationDocumentsDirectory();
            String txtFileName = '$fileName.txt';
            String txtFilePath = '${directory.path}/$txtFileName';
            log(txtFileName);
            log(txtFilePath);
            final File file = File(txtFilePath);
            String txtContent =
                '${key.toLowerCase()} 0 0 ${result.width} ${result.height}';
            log(txtContent);
            file.writeAsString(txtContent).then((value) =>
                labelMultipartFiles.add(MultipartFile.fromFileSync(value.path,
                    filename: '$txtFileName.txt')));
          },
        );
      }
    }

    await Future.delayed(const Duration(seconds: 1));

    FormData formData = FormData.fromMap({
      'id': id,
      'image': imageMultipartFiles.first,
      'label': labelMultipartFiles.first,
    });

    Response response = await Dio().post(
      'http://${APIPathConstant.API_SERVER_PATH}/api/v1/detect/upload-data',
      data: formData,
      options: Options(
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
          // HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
        },
      ),
    );
    log(response.data.toString());
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
