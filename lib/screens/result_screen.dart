import 'package:flutter/material.dart';
import 'package:flutter_ocr_sederhana/screens/home_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ResultScreen extends StatefulWidget {
  final String ocrText;

  const ResultScreen({super.key, required this.ocrText});

  @override
  State<ResultScreen> createState() => _ResultScreenState();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Hasil OCR')),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: SingleChildScrollView(
  //         child: SelectableText(
  //           ocrText.isEmpty ? 'Tidak ada teks ditemukan.' : ocrText,
  //           style: const TextStyle(fontSize: 18),
  //         ),
  //       ),
  //     ),

  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (_) => const HomeScreen()),
  //           (route) => false,
  //         );
  //       },
  //       child: const Icon(Icons.home),
  //     ),
  //   );
  // }
}

class _ResultScreenState extends State<ResultScreen> {
  // menambahkan variabel untuk text to speech
  late FlutterTts flutterTts;

  // menambahkan inisialisasi text to speech
  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _initTts();
  }

  // mengatur bahasa menjadi indonesia
  Future<void> _initTts() async {
    await flutterTts.setLanguage("id-ID");
  }

  // implementasi dispose
  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  // method _speak
  Future<void> _speak() async {
    if (widget.ocrText.isNotEmpty) {
      await flutterTts.speak(widget.ocrText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil OCR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: _speak,
            tooltip: 'Bacakan teks',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText(
            widget.ocrText.isEmpty
                ? 'Tidak ada teks ditemukan.'
                : widget.ocrText,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
