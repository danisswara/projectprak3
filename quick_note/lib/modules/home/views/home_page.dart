import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> absenList = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Pencatatan Absen Cabor Bulutangkis UTY',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              const Text(
                'INPUT ABSEN',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              _buildTextField(idController, 'NPM', TextInputType.number),
              const SizedBox(height: 10),
              _buildTextField(namaController, 'Nama Mahasiswa / Mahasiswi'),
              const SizedBox(height: 10),
              _buildDateField(tanggalController, 'Tanggal Absen'), // Input Tanggal dengan DatePicker
              const SizedBox(height: 10),
              _buildTextField(statusController, 'Status (Hadir/Tidak Hadir)', TextInputType.text),
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _buttonScaleAnimation,
                child: ElevatedButton(
                  onPressed: () {
                    _animationController.forward().then((value) => _animationController.reverse());
                    final id = int.tryParse(idController.text) ?? 0;
                    final nama = namaController.text;
                    final tanggal = tanggalController.text;
                    final status = statusController.text;

                    if (id > 0 && nama.isNotEmpty && tanggal.isNotEmpty && status.isNotEmpty) {
                      setState(() {
                        absenList.add({
                          'id': id,
                          'nama': nama,
                          'tanggal': tanggal,
                          'status': status,
                        });
                      });
                      _clearFields();
                      _showSnackBar('Absen berhasil ditambahkan!', Colors.green);
                    } else {
                      _showSnackBar('Mohon isi semua data dengan benar!', Colors.red);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text('Tambah Absen'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Daftar Absen',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: absenList.isEmpty
                    ? const Center(
                        child: Text('Belum ada data absen yang ditambahkan.'),
                      )
                    : ListView.builder(
                        itemCount: absenList.length,
                        itemBuilder: (context, index) {
                          final absen = absenList[index];
                          return FadeTransition(
                            opacity: _buttonScaleAnimation,
                            child: Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('${absen['id']}'),
                                ),
                                title: Text(absen['nama']),
                                subtitle: Text(
                                  'Tanggal: ${absen['tanggal']}\nStatus: ${absen['status']}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    _editItem(absen, index);
                                  },
                                ),
                              ),
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

  Widget _buildTextField(TextEditingController controller, String labelText, [TextInputType inputType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              setState(() {
                controller.text = "${selectedDate.toLocal()}".split(' ')[0];
              });
            }
          },
        ),
      ),
    );
  }

  void _clearFields() {
    idController.clear();
    namaController.clear();
    tanggalController.clear();
    statusController.clear();
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _editItem(Map<String, dynamic> absen, int index) {
    idController.text = absen['id'].toString();
    namaController.text = absen['nama'];
    tanggalController.text = absen['tanggal'];
    statusController.text = absen['status'];

    setState(() {
      absenList.removeAt(index);
    });

    _showSnackBar('Silakan edit data absen.', Colors.orange);
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
