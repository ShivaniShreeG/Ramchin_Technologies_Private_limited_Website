import 'package:flutter/material.dart';

class AppData {
  final String title;
  final String description;
  final Widget icon;
  final Widget destinationPage;

  const AppData({
    required this.title,
    required this.description,
    required this.icon,
    required this.destinationPage,
  });
}
