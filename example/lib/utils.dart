import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Future<void> alert(String title) async {
    return showDialog(
      context: this,
      builder: (_) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(onPressed: Navigator.of(this).pop, child: const Text('确定'))
        ],
      ),
    );
  }

  Future<void> snackBar(String message) async {
    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  bool get isDark {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
