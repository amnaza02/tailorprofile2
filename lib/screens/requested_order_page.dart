import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestedOrderPage extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String color;
  final String size;
  final String notes;

  const RequestedOrderPage({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.color,
    required this.size,
    required this.notes,
  });

  @override
  _RequestedOrderPageState createState() => _RequestedOrderPageState();
}

class _RequestedOrderPageState extends State<RequestedOrderPage> {
  final TextEditingController _priceController = TextEditingController();
  final FocusNode _priceFocusNode = FocusNode();
  bool _isPriceChanged = false;

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.price;

    _priceFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 243, 249),
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Original Price: ${widget.price}",
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              focusNode: _priceFocusNode,
              keyboardType: TextInputType.number,
              cursorColor:  const Color.fromARGB(255, 163, 119, 178),
              decoration: InputDecoration(
                labelText: "New Price (if modified)",
                labelStyle: TextStyle(
                  color: _priceFocusNode.hasFocus
                      ?   const Color.fromARGB(255, 163, 119, 178)
                      : Colors.grey,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color:    Color.fromARGB(255, 163, 119, 178),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _isPriceChanged = value.isNotEmpty && value != widget.price;
                });
              },
            ),
            const SizedBox(height: 20),
            
            _buildDetailRow("COLOR:", widget.color),
            _buildDetailRow("SIZE:", widget.size),
            _buildDetailRow("NOTES:", widget.notes),
            
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_isPriceChanged
                              ? "Order Accepted with New Price: ${_priceController.text}"
                              : "Order Accepted"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 130, 178, 119),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Accept Order",
                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Order Rejected")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color.fromARGB(255, 205, 114, 114),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Reject Order",
                      style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label + " ", 
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 163, 119, 178),
              ),
            ),
            TextSpan(
              text: value,
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}