import 'package:flutter/material.dart';

class ReportDetailsScreen extends StatelessWidget {
  final dynamic report; // 👈 добавили параметр

  const ReportDetailsScreen({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Details"),
      ),

      body: Center(
        child: Text(
          "Report details coming soon...",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}