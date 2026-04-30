import 'package:flutter/material.dart';
import '../core/api/report_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final reportService = ReportService();
  List reports = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  void loadReports() async {
    final data = await reportService.getReports();

    setState(() {
      reports = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reports")),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];

          return ListTile(
            title: Text(report["description"] ?? ""),
            subtitle: Text(report["price"].toString()),
          );
        },
      ),
    );
  }
}