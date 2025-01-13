// ignore_for_file: unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SwitcherApp());
}

class SwitcherApp extends StatelessWidget {
  const SwitcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ThemeSwitcher(),
    );
  }
}

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  // Load the theme from Shared Preferences
  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  // Toggle the theme and save it
  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('darkMode', _isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Switch(
            value: _isDarkMode,
            onChanged: (value) => _toggleTheme(),
          ),
        ),
      ),
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
    );
  }
}
