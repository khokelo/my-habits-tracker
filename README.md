Habit Tracker App

Anggota Tim

Muhamad Kaisar Hudayef

Tema Aplikasi

* Habit Tracker*
Aplikasi ini membantu pengguna mencatat, memantau, dan mengelola kebiasaan positif sehari-hari seperti membaca, olahraga, atau minum air putih.


Deskripsi Singkat & Fitur Aplikasi

Aplikasi **Habit Tracker** merupakan aplikasi berbasis **Flutter** dengan konsep **CRUD (Create, Read, Update, Delete)**.
Fungsinya adalah untuk mencatat dan memonitor kegiatan harian pengguna agar konsisten membangun kebiasaan positif.

### Fitur Utama:

1. **Halaman Utama (Read)**

   * Menampilkan daftar kebiasaan (habit) dalam bentuk *Card ListView* yang menarik.
   * Setiap item berisi nama habit, status selesai, dan tombol hapus.
   * Habit yang sudah selesai akan otomatis dicoret (line-through).

2. **Tambah Data (Create)**

   * Tekan tombol **FloatingActionButton (FAB)** untuk menambah habit baru.
   * Muncul **AlertDialog** berisi `TextField` untuk input nama habit.
   * Tombol “Tambah” akan menambahkan habit ke dalam *List* menggunakan `setState()`.

3. **Ubah Status Habit (Update)**

   * Checkbox di tiap item digunakan untuk menandai habit sudah selesai atau belum.

4. **Hapus Data (Delete)**

   * Tekan ikon **Delete (🗑️)** untuk menghapus habit.
   * Muncul dialog konfirmasi “Apakah Anda ingin menghapus habit ini?” sebelum dihapus.

5. **Desain Antarmuka (UI)**

   * Menggunakan kombinasi widget: `Scaffold`, `AppBar`, `Card`, `Container`, `Column`, `Row`, `ListView`, `Padding`, dan `IconButton`.
   * Warna dominan: biru keabu-abuan (*blue-grey*) agar tampilan elegan dan profesional.

---

## Pembagian Tugas
 Muhamad Kaisar Hudayef - All In
---

## Screenshot Tampilan
<img width="614" height="880" alt="image" src="https://github.com/user-attachments/assets/7b688f26-217c-49aa-be11-783ffdac89ff" />

### 1️Halaman Daftar Habit

<img width="603" height="313" alt="image" src="https://github.com/user-attachments/assets/c96dda13-ef43-4262-8fa7-5db207027b85" />
---

### 2️Form Tambah Habit

<img width="608" height="799" alt="image" src="https://github.com/user-attachments/assets/ffd92e61-43f0-4ed5-9b29-8470cf1a6cdc" />


Penjelasan Penggunaan List untuk Menyimpan Data

Aplikasi ini menggunakan **List** bertipe `List<Map<String, dynamic>>` untuk menyimpan data kebiasaan (habit).
Contohnya:

```dart
List<Map<String, dynamic>> habits = [
  {"nama": "Minum Air", "selesai": true},
  {"nama": "Olahraga 30 Menit", "selesai": false},
];
```

Penjelasan:

* **List** digunakan agar data dapat diubah secara dinamis (tambah, ubah, hapus) menggunakan `setState()`.
* **Map** menyimpan pasangan *key-value*, seperti `"nama"` dan `"selesai"`.
* Ketika pengguna menambah habit baru, data dimasukkan ke dalam List:

  ```dart
  habits.insert(0, {"nama": text, "selesai": false});
  ```
* Saat pengguna menghapus habit:

  ```dart
  habits.removeAt(index);
  ```
* Saat pengguna menandai selesai:

  ```dart
  habits[index]['selesai'] = true;
  ```

List ini menjadi dasar sistem CRUD dalam aplikasi dan digunakan langsung oleh `ListView.builder()` untuk menampilkan seluruh data habit.

---

## Teknologi yang Digunakan

* **Bahasa:** Dart
* **Framework:** Flutter
* **UI Toolkit:** Material Design
* **Widget utama:** `Scaffold`, `ListView`, `AlertDialog`, `TextField`, `FloatingActionButton`, `Checkbox`, `IconButton`.

---

Cara Menjalankan Aplikasi

1. Pastikan Flutter sudah terinstal di perangkat.
2. Jalankan perintah berikut di terminal:

   ```bash
   flutter pub get
   flutter run
   ```
3. Aplikasi akan terbuka di emulator atau perangkat fisik.
