import 'package:flutter/material.dart';
import 'package:gerbang_app/change_notifier/navigation.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F6F9),
          leading: SizedBox(
            child: Consumer<Navigation>(
              builder: (context, navigation, _) =>
                  FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(50)),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  navigation.setPage = "Book List";
                },
                child: const Icon(Icons.arrow_back_rounded),
              ),
            ),
          ),
        ),
        body: Column(
          children: const [
            Text("PRODUCT DETAILS"),
            content(),
            ],
        ));
  }
}

class content extends StatelessWidget {
  const content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Navigation>(
      builder: (context, navigation, _) => 
      Container(
        alignment: Alignment.center ,
        child: Column(
          children: [
            Text(navigation.productName),
            Image.network(navigation.productCover,
            height: MediaQuery.of(context).size.height * 1/2,
            fit: BoxFit.cover,),
            Text(navigation.productSize.toString() + " MB"),
          ],
        ),
      ),
    );
  }
}
