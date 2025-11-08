import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileDemoPage extends StatefulWidget {
  const FileDemoPage({super.key});
  @override
  State<FileDemoPage> createState() => _FileDemoPageState();
}

class _FileDemoPageState extends State<FileDemoPage> {
  int _counter = 0;

  Future<File> get _localFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/counter.txt');
  }

  Future<void> _readCounter() async {
    try {
      final file = await _localFile;
      final content = await file.readAsString();
      setState(() => _counter = int.tryParse(content) ?? 0);
    } catch (_) {
      setState(() => _counter = 0);
    }
  }

  Future<void> _writeCounter(int value) async {
    final file = await _localFile;
    await file.writeAsString('$value');
  }

  @override
  void initState() {
    super.initState();
    _readCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Demo')),
      body: Center(
        child: Text('Counter: $_counter', style: const TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() => _counter += 1);
          await _writeCounter(_counter);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
