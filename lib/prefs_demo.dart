import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsDemoPage extends StatefulWidget {
  const PrefsDemoPage({super.key});

  @override
  State<PrefsDemoPage> createState() => _PrefsDemoPageState();
}

class _PrefsDemoPageState extends State<PrefsDemoPage> {
  final TextEditingController _controller = TextEditingController();
  String _storedText = '';
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedText = prefs.getString('greeting') ?? '';
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _saveText() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('greeting', _controller.text);
    _controller.clear();
    _loadPrefs();
  }

  Future<void> _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() => _darkMode = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: _darkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Prefs Demo')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Mode Gelap'),
                value: _darkMode,
                onChanged: _toggleDarkMode,
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Tulis salam',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _saveText, child: const Text('Simpan')),
              const SizedBox(height: 12),
              Text(
                'Tersimpan: ${_storedText.isEmpty ? "(kosong)" : _storedText}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
