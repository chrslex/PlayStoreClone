import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:gerbang_app/widget/bookWidget.dart';
import 'package:http/http.dart' as http;

class Book {
  final String? ID;
  final String? Title;
  final String? Description;
  final String? ISBN;
  final String? Author;
  final String? Publisher;
  final String? Publish_date;
  final int? Total_pages;
  final String? Cover;
  final String? File;
  final String? Pending_status;
  final int? DownloadCount;
  final List<String> Subcategories;

  Book({
    required this.ID,
    required this.Title,
    required this.Description,
    required this.ISBN,
    required this.Author,
    required this.Publisher,
    required this.Publish_date,
    required this.Total_pages,
    required this.Cover,
    required this.File,
    required this.Pending_status,
    required this.DownloadCount,
    required this.Subcategories,
    });

  @override
  String toString() {
    return '\n ID: $ID, Title: $Title, ISBN: $ISBN , Author; $Author, Publisher: $Publisher, Publish Date: $Publish_date, Total_pages: $Total_pages}';
  }
}

Future<int> main() async {
  late Future<List<Book>> futureBook;
  futureBook = BookWidget.getAllBooks(1);
  debugPrint(futureBook.toString());
  return 0;
}