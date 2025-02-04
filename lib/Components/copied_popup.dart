import 'package:flutter/material.dart';

void showCompactSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Center(
      // Centering to avoid full width
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black87.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Keeps it as small as possible
          children: [
            Icon(Icons.cloud_done, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(message, style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.transparent, // Hide default snackbar background
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    duration: Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
