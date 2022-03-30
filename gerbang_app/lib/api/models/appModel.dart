import 'dart:convert';
import 'package:http/http.dart' as http;

class App {
  final int ID;
  final String CreatedAt;
  final String UpdatedAt;
  final String DeletedAt;
  final String Title;
  final String Description;
  final String Developer;
  final String Age;
  final String Size;
  final String Icon;
  final String File;
  final String Subowner;

  App({
    required this.ID,
    required this.CreatedAt,
    required this.UpdatedAt,
    required this.DeletedAt,
    required this.Title,
    required this.Description,
    required this.Developer,
    required this.Age,
    required this.Size,
    required this.Icon,
    required this.File,
    required this.Subowner,
  });
}
