import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  final int ID;
  final String CreatedAt;
  final String UpdatedAt;
  final String Title;
  final String Description;
  final String ISBN;
  final String Author;
  final String Publisher;
  final String Publish_date;
  final int Total_pages;
  final String Cover;
  final String File;
  final String Subowner;

  Book({
    required this.ID,
    required this.CreatedAt,
    required this.UpdatedAt,
    required this.Title,
    required this.Description,
    required this.ISBN,
    required this.Author,
    required this.Publisher,
    required this.Publish_date,
    required this.Total_pages,
    required this.Cover,
    required this.File,
    required this.Subowner,
    });

  @override
  String toString() {
    return '\n ID: $ID, Title: $Title, ISBN: $ISBN , Author; $Author, Publisher: $Publisher, Publish Date: $Publish_date, Total_pages: $Total_pages}';
  }
}
