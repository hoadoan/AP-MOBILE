import 'dart:convert';

import 'package:flutter_application_1/data/api_handling/api_path_constant.dart';
import 'package:flutter_application_1/data/models/room_model/room_model.dart';

import 'package:http/http.dart' as http;

class RoomService {
  RoomService._internalConstructor();

  static final RoomService instance = RoomService._internalConstructor();

  factory RoomService() {
    return instance;
  }

  Future<List<RoomModel>> fetchListRoom() async {
    final http.Response response = await http.get(
      Uri.http(
          APIPathConstant.API_SERVER_PATH, '/api/v1/room/list-room-mobile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        List<RoomModel> rooms = [];
        List data = json.decode(response.body);
        for (var element in data) {
          rooms.add(getRoom(element));
        }
        return rooms;
      default:
        return [];
    }
  }

  RoomModel getRoom(Map<String, dynamic> jsonData) {
    RoomModel roomModel = RoomModel.fromJson(jsonData);
    return roomModel;
  }
}
