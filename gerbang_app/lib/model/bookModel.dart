// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

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

  Map<String, Object?> toJson() => {
        InstalledBook.ID: ID,
        InstalledBook.Title: Title,
        InstalledBook.Description : Description,
        InstalledBook.ISBN : ISBN,
        InstalledBook.Author : Author,
        InstalledBook.Publisher : Publisher,
        InstalledBook.Publish_date : Publish_date,
        InstalledBook.Total_pages : Total_pages,
        InstalledBook.Cover: Cover,
        InstalledBook.File : File,
        InstalledBook.Pending_status : Pending_status,
        InstalledBook.DownloadCount : DownloadCount,
        InstalledBook.Subcategories : Subcategories.join(","),
      };

  Book copy({
    final String? ID,
    final String? Title,
    final String? Description,
    final String? ISBN,
    final String? Author,
    final String? Publisher,
    final String? Publish_date,
    final int? Total_pages,
    final String? Cover,
    final String? File,
    final String? Pending_status,
    final int? DownloadCount,
  }) =>
      Book(
          ID: ID,
          Title: Title,
          Description: Description,
          ISBN: ISBN,
          Author: Author,
          Publisher: Publisher,
          Publish_date: Publish_date,
          Total_pages: Total_pages,
          Cover: Cover,
          File: File,
          Pending_status: Pending_status,
          DownloadCount: DownloadCount,
          Subcategories: []);


  static Book fromJson(Map<String, Object?> json) => Book(
    ID: json[InstalledBook.ID] as String?,
    Title: json[InstalledBook.Title] as String?,
    Description: json[InstalledBook.Description] as String?,
    ISBN: json[InstalledBook.ISBN] as String?,
    Author: json[InstalledBook.Author] as String?,
    Publisher: json[InstalledBook.Publisher] as String?,
    Publish_date: json[InstalledBook.Publish_date] as String?,
    Total_pages: json[InstalledBook.Total_pages] as int?,
    Cover: json[InstalledBook.Cover] as String?,
    File: json[InstalledBook.File] as String?,
    Pending_status: json[InstalledBook.Pending_status] as String?,
    DownloadCount: json[InstalledBook.DownloadCount] as int?,
    Subcategories: jsonDecode(jsonEncode(json[InstalledBook.Subcategories])).split(","),
  );
}

class InstalledBook {
  static final String ID = "_id";
  static final String Title = "title";
  static final String Description = "description";
  static final String ISBN = "isbn";
  static final String Author = "author";
  static final String Publisher = "publisher";
  static final String Publish_date = "publish_date";
  static final String Total_pages = "total_pages";
  static final String Cover = "cover";
  static final String File = "file";
  static final String Pending_status = "pending_status";
  static final String DownloadCount = "download_count";
  static final String Subcategories = "subcategories";

}
