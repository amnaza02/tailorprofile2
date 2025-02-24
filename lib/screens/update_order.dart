import 'package:flutter/material.dart';

class UpdateOrderPage extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String color;
  final String size;
  final String notes;

  const UpdateOrderPage({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.color,
    required this.size,
    required this.notes,
  });

  @override
  State<UpdateOrderPage> createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  List<bool> isChecked = [false, false, false]; // حالة الصح لكل مستطيل

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Order")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ الصورة أصبحت في المنتصف وبحجم أكبر
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.image,
                  width: 250, // زيادة العرض
                  height: 250, // زيادة الارتفاع
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ تفاصيل الطلب
            Text(
              widget.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              widget.price,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            const Text(
              "Order Details:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            buildOrderDetail("Color", widget.color),
            buildOrderDetail("Size", widget.size),
            buildOrderDetail("Notes", widget.notes),

            const SizedBox(height: 20),

            // ✅ خطوات الطلب
            const Text(
              "Order Steps:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            buildTaskItem(0, "Step 1: Confirm Order"),
            buildTaskItem(1, "Step 2: Processing"),
            buildTaskItem(2, "Step 3: Completed"),
          ],
        ),
      ),
    );
  }

  // ✅ ويدجت لعرض تفاصيل الطلب
  Widget buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ ويدجت لإنشاء عنصر القائمة بدون حواف
  Widget buildTaskItem(int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked[index] = !isChecked[index]; // تغيير الحالة عند النقر
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isChecked[index] ? Colors.blue : Colors.transparent,
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: isChecked[index]
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
