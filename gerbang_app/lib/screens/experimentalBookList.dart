import 'package:flutter/material.dart';
import 'package:gerbang_app/api/models/bookApi.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../change_notifier/navigation.dart';
import '../model/bookModel.dart';
import '../widget/bookWidget.dart';

class ExperimentalBookList extends StatelessWidget {
  ExperimentalBookList({
    Key? key,
  }) : super(key: key);
  static List<String> listSubcategory = [];

  Future<List<List<Book>>> getBookList() async {
    late Future<List<String>?> subcategories = BookApi.getBookSubcategories();
    List<List<Book>> bookList = [];
    subcategories.then((value) => {
      listSubcategory = value!
    });

    List<Book> bookSubcatList;
    for (var i = 0; i < listSubcategory.length; i++) {
      bookSubcatList = await BookApi.getBooksBySubcategory(listSubcategory[i], 1);
      bookList.add(bookSubcatList);
    }
    return bookList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBookList(),
      builder: (BuildContext context,
        AsyncSnapshot<List<List<Book>>> snapshot) {
        if (snapshot.hasData) {
          List<List<Book>>? bookList = snapshot.data;
          return Consumer<Navigation>(
            builder: (context, navigation, _) =>
            SingleChildScrollView(
            child: Column(
              children:
              [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return IndividualBookList(subcategory: listSubcategory[index], books: bookList![index]);
                    },
                )
              ]
            )
          )
        );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ).paddingBottom(16);
  }
}
