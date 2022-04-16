// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';

class ProductWidget extends StatelessWidget {
  final String? imgAsset;
  final String? title;
  final String? size;
  final String? type;
  final String? description;
  final String? productID;
  final int? downloadCount;

  ProductWidget({Key? key, 
    required this.imgAsset,
    required this.title,
    required this.size,
    required this.type,
    required this.description,
    required this.productID,
    required this.downloadCount,
    }
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(
      builder : (context,navigation,_) => 
      InkWell(
        onTap: () {
          navigation.productID = productID;
          navigation.productName = title;
          navigation.productCover = imgAsset;
          navigation.productSize = type == "book" ? size!.toString() : size!;
          navigation.productType = type;
          navigation.productDescription = description;
          navigation.setDownloadCount = downloadCount;

          if(navigation.productType == "book"){
            navigation.setShowAppBar = false;
            navigation.setPage = "Product Detail Book";
          }
          else{
            navigation.setShowAppBar = false;
            navigation.setPage = "Product Detail App";
          }
        },
        child: Container(
          width: 150,
          padding: const EdgeInsets.only(
              top: 15.00, bottom: 15.00, left: 8, right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                imgAsset!,
                height: 100.0,
                width: 100.0,
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
              ),
              Text(
                title!,
                maxLines: 1,
                style: TextStyle(
                  color: Color.fromRGBO(32, 33, 36, 1),
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
              ),
              Text(
                size!,
                maxLines: 1,
                style: TextStyle(
                    color: Color(0xff5f6368), fontSize: 12.0),
                    overflow: TextOverflow.fade,
                    softWrap: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}