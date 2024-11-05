import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CatatanTransaksi(),
    );
  }
}

class CatatanTransaksi extends StatefulWidget {
  @override
  _CatatanTransaksiState createState() => _CatatanTransaksiState();
}

class _CatatanTransaksiState extends State<CatatanTransaksi> {
  final List<Map<String, dynamic>> items = [
    {'name': 'Laptop', 'price': 25000000, 'quantity': TextEditingController()},
    {'name': 'Mouse', 'price': 1250000, 'quantity': TextEditingController()},
    {'name': 'Keyboard', 'price': 1500000, 'quantity': TextEditingController()},
    {'name': 'Monitor', 'price': 5000000, 'quantity': TextEditingController()},
    {'name': 'Printer', 'price': 2200000, 'quantity': TextEditingController()},
  ];
  
  double totalBayar = 0.0;
  List<Map<String, dynamic>> struk = [];

  void reset() {
    setState(() {
      for (var item in items) {
        item['quantity'].clear();
      }
      struk.clear();
      totalBayar = 0.0;
    });
  }

  void cetakStruk() {
    setState(() {
      struk.clear();
      totalBayar = 0.0;
      for (var item in items) {
        int qty = int.tryParse(item['quantity'].text) ?? 0;
        if (qty > 0) {
          double subtotal = (qty * item['price']).toDouble();
          struk.add({
            'name': item['name'],
            'quantity': qty,
            'price': item['price'],
            'subtotal': subtotal,
          });
          totalBayar += subtotal;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Komputer'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rp ${item['price']}',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        Container(
                          width: 50,
                          child: TextField(
                            controller: item['quantity'],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: '0',
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: cetakStruk,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Cetak Struk'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: struk.map((item) {
                return ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp ${item['subtotal']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'Rp ${item['price']} x ${item['quantity']}',
                    style: TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.pink[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp $totalBayar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
