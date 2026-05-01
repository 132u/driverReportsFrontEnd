import 'package:driver_reports_app/screens/report_details_screen.dart';
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
  bool isLoading = true;

  final String driverName = "Driver Viktor"; // потом возьмешь из JWT

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  void loadReports() async {
    final data = await reportService.getReports();

    setState(() {
      reports = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      // 🔥 HEADER
      appBar: AppBar(
        title: Text(driverName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/createReport');
            },
          )
        ],
      ),

      // 🔥 BODY
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reports.isEmpty
              ? const Center(child: Text("No reports yet"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    final report = reports[index];

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),

                        // 💰 цена
                        title: Text(
                          "€ ${report["price"] ?? 0}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        // 📄 детали
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Text(report["description"] ?? ""),
                          ],
                        ),

                        trailing: const Icon(Icons.arrow_forward_ios),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReportDetailsScreen(
                                report: report,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

      // 🔥 кнопка создания отчета (дублирует AppBar + удобно)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createReport');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}