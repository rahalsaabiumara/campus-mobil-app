import 'package:flutter/material.dart';

class UKM {
  final String name;
  final String description;
  final String vision;
  final List<String> missions;
  final String url;

  UKM({
    required this.name,
    required this.description,
    required this.vision,
    required this.missions,
    required this.url,
  });
}

List<UKM> ukmList = [
  UKM(
    name: "UKM Penelitian",
    description: "“Organisasi adalah tempat berbagi dan mewujudkan mimpi”...",
    vision: "Memasyarakatkan dan mengembangkan karya ilmiah...",
    missions: [
      "Memberdayakan anggota UKM Penelitian...",
      "Memberikan manfaat nyata UKM Penelitian...",
    ],
    url: "https://ukmpenelitianuny.id",
  ),
  UKM(
    name: "UKM Bahasa Asing (SAFEL)",
    description: "Student Activity Forum of Foreign Languages (SAFEL)...",
    vision: "Realizing UKM Bahasa Asing “SAFEL”...",
    missions: [
      "Provides a place for component of UKM Bahasa Asing “SAFEL”...",
      "Encourage all of component of UKM Bahasa Asing “SAFEL”...",
    ],
    url: "https://safeluny.com/",
  ),
  UKM(
    name: "UKM Rekayasa Teknologi (RESTEK)",
    description: "UKM Rekayasa Teknologi merupakan salah satu UKM...",
    vision: "",
    missions: [],
    url: "https://www.restek-uny.id/",
  ),
  UKM(
    name: "UKM Musik (SICMA BAND)",
    description: "UKM sicma adalah UKM yang mewadahi para mahasiswa...",
    vision: "",
    missions: [],
    url: "https://sicma.student.uny.ac.id",
  ),
  UKM(
    name: "UKM Seni Rupa dan Fotografi (SERUFO)",
    description: "UKM Seni Rupa dan Fotografi adalah salah satu Unit...",
    vision: "",
    missions: [],
    url: "https://www.serufo.com/",
  ),
];

class InformasiUKMPage extends StatefulWidget {
  @override
  _InformasiUKMPageState createState() => _InformasiUKMPageState();
}

class _InformasiUKMPageState extends State<InformasiUKMPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi UKM'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Selamat datang di halaman Informasi UKM UNY Apps',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Pilih UKM yang ingin Anda ketahui:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: ukmList.length,
                itemBuilder: (context, index) {
                  final ukm = ukmList[index];
                  return UKMCard(name: ukm.name, description: ukm.description);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UKMCard extends StatelessWidget {
  final String name;
  final String description;

  const UKMCard({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    // Define a map of icons for each UKM using Flutter's built-in icons
    final Map<String, IconData> ukmIcons = {
      "UKM Penelitian": Icons.book,
      "UKM Bahasa Asing (SAFEL)": Icons.language,
      "UKM Rekayasa Teknologi (RESTEK)": Icons.build,
      "UKM Musik (SICMA BAND)": Icons.music_note,
      "UKM Seni Rupa dan Fotografi (SERUFO)": Icons.brush,
    };

    // Get the icon for the current UKM
    final icon = ukmIcons[name] ?? Icons.info; // Default to Icons.info if no match

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.teal),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailUKMPage(name: name, description: description),
            ),
          );
        },
      ),
    );
  }
}

class DetailUKMPage extends StatelessWidget {
  final String name;
  final String description;

  DetailUKMPage({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
