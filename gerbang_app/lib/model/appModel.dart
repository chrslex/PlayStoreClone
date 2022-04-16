// ignore_for_file: non_constant_identifier_names

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
  final List<String> Subcategories;

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

  Map<String, Object?> toJson() => {
        InstalledApp.ID: ID,
        InstalledApp.Title: Title,
        InstalledApp.Description: Description,
        InstalledApp.Developer: Developer,
        InstalledApp.Age: Age,
        InstalledApp.Size: Size,
        InstalledApp.Icon: Icon,
        InstalledApp.File: File,
        InstalledApp.Pending_status: Pending_status,
        InstalledApp.DownloadCount: DownloadCount,
        InstalledApp.Subcategories:
            Subcategories.join(","),
      };

  static App fromJson(Map<String, Object?> json) => App(
        ID: json[InstalledApp.ID] as String?,
        Title: json[InstalledApp.Title] as String?,
        Description:
            json[InstalledApp.Description] as String?,
        Developer: json[InstalledApp.Developer] as String?,
        Age: json[InstalledApp.Age] as String?,
        Size: json[InstalledApp.Size] as String?,
        Icon: json[InstalledApp.Icon] as String?,
        File: json[InstalledApp.File] as String?,
        Pending_status: json[InstalledApp.Pending_status] as String?,
        DownloadCount:
            json[InstalledApp.DownloadCount] as int?,
        Subcategories: jsonDecode(jsonEncode(
                json[InstalledApp.Subcategories]))
            .split(","),
      );
}

class InstalledApp {
  static const String ID = "_id";
  static const String Title = "title";
  static const String Description = "description";
  static const String Developer = "developer";
  static const String Age = "age";
  static const String Size = "size";
  static const String Icon = "icon";
  static const String File = "file";
  static const String Pending_status = "pending_status";
  static const String DownloadCount = "download_count";
  static const String Subcategories = "subcategories";
}
