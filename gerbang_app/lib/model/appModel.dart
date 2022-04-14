import 'dart:convert';
import 'package:http/http.dart' as http;

class App {
  final String? ID;
  final String? Title;
  final String? Description;
  final String? Developer;
  final String? Age;
  final String? Size;
  final String? Icon;
  final String? File;
  final String? Pending_status;
  final int? DownloadCount;
  final List<String>? Subcategories;

  App({
    required this.ID,
    required this.Title,
    required this.Description,
    required this.Developer,
    required this.Age,
    required this.Size,
    required this.Icon,
    required this.File,
    required this.Pending_status,
    required this.DownloadCount,
    required this.Subcategories,
  });
}
