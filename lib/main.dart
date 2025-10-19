import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[700],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}

/// 🏠 Halaman utama aplikasi
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  /// List data habit (dummy awal)
  List<Map<String, dynamic>> habits = [
    {"nama": "Minum Air", "selesai": true},
    {"nama": "Baca Buku", "selesai": false},
    {"nama": "Meditasi", "selesai": true},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 🧠 Fungsi Smart Reminder Otomatis
  void _cekKebiasaanTidakSelesai() {
    final belumSelesai = habits.where((h) => !h['selesai']).length;

    // Jika ada lebih dari 2 habit belum selesai, tampilkan pengingat
    if (belumSelesai >= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '💡 Kamu punya $belumSelesai habit yang belum selesai hari ini. Yuk semangat!',
            style: const TextStyle(fontSize: 15),
          ),
          backgroundColor: Colors.orangeAccent,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  /// 📝 Dialog tambah habit baru
  void _showAddDialog() {
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Tambah Habit',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Masukkan nama habit...',
              hintStyle: TextStyle(color: Colors.white54),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.tealAccent),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    habits.insert(0, {"nama": text, "selesai": false});
                  });
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('✅ Habit "$text" berhasil ditambahkan!'),
                      backgroundColor: Colors.greenAccent,
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  /// 🗑️ Dialog konfirmasi penghapusan habit
  void _hapusHabit(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[800],
        title: const Text(
          'Konfirmasi Hapus',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus habit "${habits[index]['nama']}"?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.delete_forever),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                habits.removeAt(index);
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🗑️ Habit berhasil dihapus.'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            label: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧭 My Habit Tracker '),
        centerTitle: true,
      ),
      body: habits.isEmpty
          ? const Center(
              child: Text(
                'Belum ada habit. Tambahkan satu yuk!',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                final String habitName = habit["nama"];
                final bool isDone = habit["selesai"];

                return Card(
                  color: Colors.blueGrey[700],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    title: Text(
                      habitName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: isDone,
                          onChanged: (bool? value) {
                            setState(() {
                              habits[index]['selesai'] = value ?? false;
                            });
                            _cekKebiasaanTidakSelesai();
                          },
                          checkColor: Colors.black,
                          activeColor: Colors.tealAccent,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => _hapusHabit(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Habit'),
      ),
    );
  }
}
