import 'dart:convert';
import 'api_client.dart';

class ReportService {
  final ApiClient _client = ApiClient();

  Future<List<dynamic>> getReports() async {
    final response = await _client.get("/api/reports");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load reports");
  }

  // 🚀 СОЗДАНИЕ ОТЧЕТА
  Future<void> createReport(Map<String, dynamic> data) async {
    final response = await _client.post(
      "/api/reports",
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("Failed to create report");
    }
  }
}