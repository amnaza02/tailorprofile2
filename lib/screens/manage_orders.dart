import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'update_order.dart';
import 'requested_order_page.dart';

class ManageOrders extends StatefulWidget {
  const ManageOrders({super.key});

  @override
  State<ManageOrders> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<ManageOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Define the number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "My Orders",
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 245, 243, 249),
          foregroundColor: Colors.black,
          bottom: TabBar(
            indicatorColor: Color.fromARGB(255, 163, 119, 178), // Tab indicator color
            labelColor: Color.fromARGB(255, 163, 119, 178), // Text color when selected
            unselectedLabelColor: Colors.black, // Text color when unselected
            labelStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Received"), // Received orders
              Tab(text: "Tailoring"), // Orders in tailoring process
              Tab(text: "Completed"), // Completed orders
              Tab(text: "Canceled"), // Canceled orders
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrdersList(orderType: "view Request"), // List of received orders
            OrdersList(orderType: "Update"), // List of orders that can be updated
            OrdersList(orderType: "Review"), // List of completed orders
            OrdersList(orderType: "Canceled"), // List of canceled orders
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatefulWidget {
  final String orderType;
  const OrdersList({super.key, required this.orderType});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  // Sample list of orders
  final List<Map<String, String>> orders = [
    {
      "title": "Karako",
      "price": "21000 DA",
      "image": "images/1.jpg",
      "color": "Blue",
      "size": "Large",
      "notes": "Add silver embroidery"
    },
    {
      "title": "Kaftan",
      "price": "12000 DA",
      "image": "images/2.jpg",
      "color": "Green",
      "size": "Medium",
      "notes": "Custom length"
    },
    {
      "title": "Skirt",
      "price": "4000 DA",
      "image": "images/3.jpg",
      "color": "Red",
      "size": "Small",
      "notes": "Extra pleats"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: orders.length, // Number of orders
      itemBuilder: (context, index) {
        final order = orders[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Rounded image shape
            child: Image.asset(
              order["image"]!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            order["title"]!,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            order["price"]!,
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
          ),
          trailing: (widget.orderType == "Update" || widget.orderType == "view Request")
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 163, 119, 178),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    if (widget.orderType == "Update") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateOrderPage(
                            title: order["title"]!,
                            price: order["price"]!,
                            image: order["image"]!,
                            color: order["color"]!,
                            size: order["size"]!,
                            notes: order["notes"]!,
                          ),
                        ),
                      );
                    } else if (widget.orderType == "view Request") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestedOrderPage(
                            title: order["title"]!,
                            price: order["price"]!,
                            image: order["image"]!,
                            color: order["color"]!,
                            size: order["size"]!,
                            notes: order["notes"]!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    widget.orderType,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  ),
                )
              : null,
        );
      },
    );
  }
}