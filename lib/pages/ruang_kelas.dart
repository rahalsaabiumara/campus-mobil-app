import 'package:flutter/material.dart';



class CekRuangKelasPage extends StatefulWidget {
  @override
  _CekRuangKelasPageState createState() => _CekRuangKelasPageState();
}

class _CekRuangKelasPageState extends State<CekRuangKelasPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDay = 'senin';
  TimeOfDay? _selectedTime;

  List<Map<String, dynamic>> rooms = [
    {
      'id_ruangan': 41001,
      'nomor_ruangan': '131',
      'nama_gedung': 'Gedung RK',
      'lantai': 1,
      'jenis_ruangan': 'Kelas',
      'jadwal': {
        'senin': ['09:00', '13:30'],
        'selasa': ['07:30', '09:10'],
        'rabu': ['13:45', '14:30']
      }
    },
    {
      'id_ruangan': 41002,
      'nomor_ruangan': '132',
      'nama_gedung': 'Gedung RK',
      'lantai': 1,
      'jenis_ruangan': 'Kelas',
      'jadwal': {
        'kamis': [],
        'jumat': []
      }
    },
    {
      'id_ruangan': 41003,
      'nomor_ruangan': '245',
      'nama_gedung': 'Gedung AR',
      'lantai': 1,
      'jenis_ruangan': 'Lab Komputer',
      'jadwal': {
        'senin': ['09:00', '13:30'],
        'selasa': ['07:30', '09:10'],
        'rabu': ['13:45', '14:30']
      }
    },
    {
      'id_ruangan': 41004,
      'nomor_ruangan': '241',
      'nama_gedung': 'Gedung AR',
      'lantai': 2,
      'jenis_ruangan': 'Lab Jaringan',
      'jadwal': {}
    },
    {
      'id_ruangan': 41005,
      'nomor_ruangan': '244',
      'nama_gedung': 'Gedung AR',
      'lantai': 2,
      'jenis_ruangan': 'Lab Teknologi dan Informasi',
      'jadwal': {
        'senin': [],
        'selasa': [],
        'rabu': [],
        'kamis': [],
        'jumat': []
      }
    },
    {
      'id_ruangan': 41006,
      'nomor_ruangan': '134',
      'nama_gedung': 'Gedung RK',
      'lantai': 2,
      'jenis_ruangan': 'Kelas',
      'jadwal': {}
    },
    {
      'id_ruangan': 41007,
      'nomor_ruangan': '242',
      'nama_gedung': 'Gedung AR',
      'lantai': 1,
      'jenis_ruangan': 'Lab Jaringan',
      'jadwal': {}
    },
    {
      'id_ruangan': 41008,
      'nomor_ruangan': '133',
      'nama_gedung': 'Gedung RK',
      'lantai': 2,
      'jenis_ruangan': 'Kelas',
      'jadwal': {}
    },
    {
      'id_ruangan': 41009,
      'nomor_ruangan': '135',
      'nama_gedung': 'Gedung RK',
      'lantai': 3,
      'jenis_ruangan': 'Kelas',
      'jadwal': {}
    },
    {
      'id_ruangan': 41010,
      'nomor_ruangan': '243',
      'nama_gedung': 'Gedung AR',
      'lantai': 2,
      'jenis_ruangan': 'Lab Elektronika',
      'jadwal': {}
    },
  ];

  List<Map<String, dynamic>> filteredRooms = [];
  bool noRoomsAvailable = false;

  void _searchRooms() {
    setState(() {
      filteredRooms = rooms.where((room) {
        String selectedTime = _selectedTime != null
            ? _selectedTime!.format(context)
            : '';
        Map<String, List<String>> schedule = room['jadwal'];

        if (schedule.containsKey(_selectedDay)) {
          for (String time in schedule[_selectedDay]!) {
            if (time == selectedTime) {
              return false;
            }
          }
        }
        return true;
      }).toList();

      noRoomsAvailable = filteredRooms.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Ruang Kelas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat datang di halaman Cek Ruang Kelas UNY Apps',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedDay,
                decoration: const InputDecoration(
                  labelText: 'Hari',
                ),
                items: ['senin', 'selasa', 'rabu', 'kamis', 'jumat', 'sabtu']
                    .map((day) => DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDay = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: TextEditingController(
                    text: _selectedTime != null
                        ? _selectedTime!.format(context)
                        : ''),
                decoration: const InputDecoration(
                  labelText: 'Jam (HH:MM)',
                ),
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _selectedTime = pickedTime;
                    });
                  }
                },
                readOnly: true,
                validator: (value) {
                  if (_selectedTime == null) {
                    return 'Masukkan jam';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _searchRooms();
                    }
                  },
                  child: const Text('Cari'),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: noRoomsAvailable
                    ? Center(
                        child: Text(
                            'Tidak ada ruangan yang tersedia pada hari dan jam tersebut'))
                    : ListView.builder(
                        itemCount: filteredRooms.length,
                        itemBuilder: (context, index) {
                          final room = filteredRooms[index];
                          return ListTile(
                            title: Text('Nomor Ruangan: ${room['nomor_ruangan']}'),
                            subtitle: Text(
                              'Gedung: ${room['nama_gedung']}, Lantai: ${room['lantai']}, Jenis: ${room['jenis_ruangan']}',
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
