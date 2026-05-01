import 'package:driver_reports_app/screens/full_screen_image.dart';
import 'package:flutter/material.dart';

class ReportDetailsScreen extends StatelessWidget {
  final Map report;

  const ReportDetailsScreen({super.key, required this.report});

  String _formatDate(String? date) {
    if (date == null) return "";
    return date.split("T")[0];
  }

  String paymentTypeToString(int value) {
    switch (value) {
      case 0:
        return "Cash";
      case 1:
        return "Cashless with VAT";
      case 2:
        return "Cashless without VAT";
      default:
        return "Unknown";
    }
  }

  String moneyHolderToString(int value, String driverName) {
    switch (value) {
      case 0:
        return driverName;
      case 1:
        return "Viktor";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Детали отчета"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // 👉 позже добавим экран редактирования
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            

            // 📄 ОСНОВНАЯ КАРТОЧКА
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _buildRow("📅 Дата", _formatDate(report["reportDate"])),

                  _buildRow("👤 Водитель", report["driverName"] ?? ""),

                  _buildRow("🧾 Заказчик", report["clientName"] ?? ""),

                  _buildRow("💰 Сумма", "${report["price"] ?? 0} ₽"),

                  _buildRow(
                    "💳 Тип платежа",
                    paymentTypeToString(report["paymentType"]),
                  ),

                  _buildRow(
                    "👛 Деньги у",
                    moneyHolderToString(
                      report["moneyHolder"],
                      report["driverName"],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 📝 ОПИСАНИЕ
            if (report["description"] != null &&
                report["description"].toString().isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Описание",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(report["description"]),
                  ],
                ),
              ),

            const SizedBox(height: 20),
// 📷 ФОТО
         if (report["imagePath"] != null)
  GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FullScreenImage(
            imageUrl: report["imagePath"],
          ),
        ),
      );
    },
    child: Hero(
      tag: report["imagePath"],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          report["imagePath"],
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover, // 🔥 важно
        ),
      ),
    ),
  ),

            const SizedBox(height: 16),
            // ✏️ КНОПКА РЕДАКТИРОВАНИЯ
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {
                  // 👉 потом сделаем EditScreen
                },
                icon: const Icon(Icons.edit),
                label: const Text("Редактировать отчет"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}