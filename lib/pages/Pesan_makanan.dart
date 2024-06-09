import 'package:flutter/material.dart';

class PesanMakananPage extends StatefulWidget {
  @override
  _PesanMakananPageState createState() => _PesanMakananPageState();
}

class _PesanMakananPageState extends State<PesanMakananPage> {
  Map<String, int> _selectedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemesanan Kantin FT UNY'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListView(
          children: [
            const SizedBox(height: 16.0),
            Text(
              'Mau makan apa hari ini?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: [
                _buildMenuItem('Risol', 'Rp 3.500', 'Assets/risol.jpeg'),
                _buildMenuItem('Nasi Ayam Geprek', 'Rp 12.000', 'Assets/ayam geprek.jpg'),
                _buildMenuItem('Nasi Goreng', 'Rp 15.000', 'Assets/nasgor.jpg'),
                _buildMenuItem('Roti Aoka', 'Rp 2.000', 'Assets/aoka.webp'),
                _buildMenuItem('Dimsum', 'Rp 3.000', 'Assets/dimsum.jpeg'),
                _buildMenuItem('Soto Ayam Kampus', 'Rp 9.000', 'Assets/soto.jpg'),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int totalBiaya = 0;
                _selectedItems.forEach((key, value) {
                  if (value > 0) {
                    totalBiaya += value * _getPrice(key);
                  }
                });
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Pesanan Anda'),
                    content: Text('Pesanan Anda sedang dibuat, silahkan bayar Rp$totalBiaya ke Kantin FT UNY'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Pesan Sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String name, String price, String imagePath) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            name,
            style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2.0),
          Text(
            price,
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    _selectedItems[name] = (_selectedItems[name] ?? 0) - 1;
                  });
                },
              ),
              Text(
                '${_selectedItems[name] ?? 0}',
                style: TextStyle(fontSize: 16.0),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    _selectedItems[name] = (_selectedItems[name] ?? 0) + 1;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  int _getPrice(String itemName) {
    switch (itemName) {
      case 'Risol':
        return 3500;
      case 'Nasi Ayam Geprek':
        return 12000;
      case 'Nasi Goreng':
        return 15000;
      case 'Roti Aoka':
        return 2000;
      case 'Dimsum':
        return 3000;
      case 'Soto Ayam Kampus':
        return 9000;
      default:
        return 0;
    }
  }
}