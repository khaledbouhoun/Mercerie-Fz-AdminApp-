import 'dart:convert';
import 'dart:io';
import 'package:admin_ecommerce_app/core/services/services.dart';
import 'package:admin_ecommerce_app/linkapi.dart';
import 'package:dartz/dartz.dart';
import 'package:admin_ecommerce_app/core/class/statusrequest.dart';
import 'package:admin_ecommerce_app/core/functions/checkinternet.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Crud {
  MyServices myServices = Get.find<MyServices>();

  /// POST request for Laravel API (application/json)
  Future<Response> post(String linkurl, Map<String, dynamic> data) async {
    if (await checkInternet()) {
      try {
        var response = await http.post(
          Uri.parse(linkurl),
          headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
          body: jsonEncode(data),
          // body: jsonEncode({
          //   "items_name_fr": "bzbbz",
          //   "items_name_ar": "hzhsh",
          //   "items_desc_fr": "jjzz",
          //   "items_desc_ar": "jznnz",
          //   "items_size": "ggs",
          //   "items_price": "55",
          //   "items_cat": "8",
          //   "listcolor": ["ff1e88e5", "ff1e88e5"],
          // }),
        );
        print("Response status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        print("Request URL: $linkurl");

        return Response(statusCode: response.statusCode, body: jsonDecode(response.body));
      } catch (e) {
        print("Error in POST request: $e");
        throw Exception('Server exception: $e');
      }
    } else {
      print("No internet connection");
      throw Exception('No internet connection');
    }
  }

  /// GET request for Laravel API (application/json)
  Future<Response> get(String linkurl) async {
    if (await checkInternet()) {
      try {
        // Convert data map to query parameters
        var response = await http.get(Uri.parse(linkurl), headers: {'Content-Type': 'application/json', 'Accept': 'application/json'});
        print("Response status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        print("Request URL: $linkurl");

        return Response(statusCode: response.statusCode, body: jsonDecode(response.body));
      } catch (e) {
        print("Error in Get request: $e");
        throw Exception('Server exception: $e');
      }
    } else {
      print("No internet connection");
      throw Exception('No internet connection');
    }
  }

  /// DELETE request for Laravel API (application/json)

  Future<Response> delete(String linkurl, Map<String, dynamic> data) async {
    if (await checkInternet()) {
      try {
        var response = await http.delete(
          Uri.parse(linkurl),
          headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
          body: jsonEncode(data),
        );
        print("Response status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        print("Request URL: $linkurl");

        return Response(statusCode: response.statusCode, body: jsonDecode(response.body));
      } catch (e) {
        print("Error in DELETE request: $e");
        throw Exception('Server exception: $e');
      }
    } else {
      print("No internet connection");
      throw Exception('No internet connection');
    }
  }

  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    if (await checkInternet()) {
      var request = http.MultipartRequest('POST', Uri.parse(linkurl));
      request.fields.addAll(data.map((key, value) => MapEntry(key, value.toString())));
      var response = await request.send();
      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(await response.stream.bytesToString());
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Response> uploadImage(String linkUrl, File path, String folder) async {
    if (await checkInternet()) {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(linkUrl));

        // إضافة التوكن في الهيدر
        request.headers.addAll({'Accept': 'application/json'});

        // إضافة المجلد
        request.fields['folder'] = folder;

        // إضافة الصورة
        request.files.add(await http.MultipartFile.fromPath('image', path.path));

        // إرسال
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        print("Response status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        print("Request URL: $linkUrl");

        // تحويل إلى GetX Response
        return Response(statusCode: response.statusCode, body: jsonDecode(response.body));
      } catch (e) {
        print("Error in UPLOAD request: $e");
        throw Exception('Server exception: $e');
      }
    } else {
      print("No internet connection");
      throw Exception('No internet connection');
    }
  }

  Future<Response> updateImage(String linkUrl, File path, String folder, String oldPath) async {
    if (await checkInternet()) {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(linkUrl));

        request.headers.addAll({'Accept': 'application/json'});

        // البيانات المطلوبة
        request.fields['folder'] = folder;
        request.fields['old_path'] = oldPath; // المسار القديم للصورة

        // إضافة الصورة الجديدة
        request.files.add(await http.MultipartFile.fromPath('new_image', path.path));

        // إرسال
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        print("📡 Update Request URL: $linkUrl");
        print("✅ Response Code: ${response.statusCode}");
        print("📩 Response Body: ${response.body}");

        return Response(statusCode: response.statusCode, body: jsonDecode(response.body));
      } catch (e) {
        print("❌ Error in UPDATE request: $e");
        return Response(statusCode: 500, body: {'error': e.toString()});
      }
    } else {
      print("⚠️ No internet connection");
      return Response(statusCode: 0, body: {'error': 'No internet connection'});
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkurl, String path) async {
    if (await checkInternet()) {
      var response = await http.get(Uri.parse(linkurl + path));
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        print(responsebody);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Map> getyallidine(String url) async {
    final response = await http.get(Uri.parse(url), headers: <String, String>{'X-API-ID': AppLink.apiId, 'X-API-TOKEN': AppLink.apiToken});

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map;
    } else {
      return {"status": "error"};
    }
  }

  Future<Map> postyallidine(String url, Object data) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: <String, String>{'X-API-ID': AppLink.apiId, 'X-API-TOKEN': AppLink.apiToken},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map;
    } else {
      return {"status": "error"};
    }
  }
}
