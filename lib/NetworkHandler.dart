import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'Model/response_model.dart';

class NetworkHandler {
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();

  //String baseUrl = "https://plantholic.herokuapp.com";
  String baseUrl = "http://192.168.1.69:5000";
  ResponseModel response = ResponseModel();

  Future get(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.get(
      url,
      headers: {"Authorization": "bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }
    log.d(response.body);
    log.d(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token"
        },
        body: json.encode(body));
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return baseUrl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName.jpg");
    return NetworkImage(url);
  }

  Future<http.Response> post1(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<ResponseModel> forgetPassword(String mail) async {
    response = null;
    String body = '{"mail" : "$mail"}';
    try {
      final request = await http.post(baseUrl + "/user/forgetPassword" + "/$mail",
          headers: {"Content-type": "application/json"},
          body: body);
      if (request.statusCode == 200 || request.statusCode == 201 ) {
       return response = ResponseModel.fromJson(json.decode(request.body));
        // print(response);
      } else {
       return response = ResponseModel.fromJson(json.decode(request.body));
      }
    } catch (e) {
      return ResponseModel();
    }
  }
}
