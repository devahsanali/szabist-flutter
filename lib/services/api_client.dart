import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../app_config.dart';
import '../provider/auth_provider.dart';

class ApiClient {
  final AuthProvider auth;

  ApiClient(this.auth);

  Future<http.Response> get(String path) async {
    final res = await http.get(
      Uri.parse("${AppConfig.baseUrl}$path"),
      headers: _headers(),
    );
    return _handle(res);
  }

  Future<http.Response> post(String path, dynamic body) async {
    final res = await http.post(
      Uri.parse("${AppConfig.baseUrl}$path"),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handle(res);
  }

  Future<http.Response> put(String path, dynamic body) async {
    final res = await http.put(
      Uri.parse("${AppConfig.baseUrl}$path"),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handle(res);
  }

  Future<http.Response> delete(String path) async {
    final res = await http.delete(
      Uri.parse("${AppConfig.baseUrl}$path"),
      headers: _headers(),
    );
    return _handle(res);
  }

  /// Multipart upload for files
  Future<http.Response> postMultipart(String path, Map<String, String> fields, Map<String, String> files) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${AppConfig.baseUrl}$path"),
    );

    // Add headers
    request.headers.addAll(_headersWithoutContentType());

    // Add fields
    request.fields.addAll(fields);

    // Add files
    for (var entry in files.entries) {
      final file = await http.MultipartFile.fromPath(
        entry.key,
        entry.value,
        contentType: _mediaTypeFromPath(entry.value),
      );
      request.files.add(file);
    }

    final streamedResponse = await request.send();
    final res = await http.Response.fromStream(streamedResponse);
    return _handle(res);
  }

  /// Multipart upload for updates
  Future<http.Response> putMultipart(String path, Map<String, String> fields, Map<String, String> files) async {
    final request = http.MultipartRequest(
      'PUT',
      Uri.parse("${AppConfig.baseUrl}$path"),
    );

    request.headers.addAll(_headersWithoutContentType());
    request.fields.addAll(fields);

    for (var entry in files.entries) {
      final file = await http.MultipartFile.fromPath(
        entry.key,
        entry.value,
        contentType: _mediaTypeFromPath(entry.value),
      );
      request.files.add(file);
    }

    final streamedResponse = await request.send();
    final res = await http.Response.fromStream(streamedResponse);
    return _handle(res);
  }

  Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      if (auth.token != null) "Authorization": "Bearer ${auth.token}",
    };
  }

  Map<String, String> _headersWithoutContentType() {
    return {
      if (auth.token != null) "Authorization": "Bearer ${auth.token}",
    };
  }

  http.Response _handle(http.Response response) {
    if (response.statusCode == 401) {
      auth.logout();
      throw Exception("UNAUTHORIZED");
    }
    return response;
  }

  /// Detect MIME type from file path extension
  MediaType _mediaTypeFromPath(String filePath) {
    final ext = filePath.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      case 'webp':
        return MediaType('image', 'webp');
      default:
        return MediaType('image', 'jpeg');
    }
  }
}