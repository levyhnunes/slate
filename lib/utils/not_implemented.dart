import 'package:flutter/material.dart';

/// Tells the user that [what] is a placeholder for now.
void showNotImplemented(BuildContext context, String what) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('$what not implemented yet')));
}
