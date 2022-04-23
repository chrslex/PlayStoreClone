import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gerbang_app/change_notifier/navigation.dart';
import 'package:gerbang_app/model/appModel.dart';
import 'package:gerbang_app/model/bookModel.dart';
import 'package:gerbang_app/utils/mockReviewList.dart';
import 'package:gerbang_app/utils/saveFiles.dart';
import 'package:gerbang_app/api/models/appApi.dart';
import 'package:gerbang_app/api/models/bookApi.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/widgetUtils.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() =>
      _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? productID;
  String? productType;
  bool isInstall = false;
  bool visibleItem = false;
  bool iconSelect = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    productID =
        Provider.of<Navigation>(context, listen: false)
            .productID;
    productType = Provider.of<Navigation>(context, listen: false).productType;
    isInstall = productType == "book" ? await InstalledBooksAndAppsDatabase.instance
        .checkBookExist(productID!) : await InstalledBooksAndAppsDatabase.instance.checkAppExist(productID!);
  }

  @override
  void dispose() {
    hideKeyboard(context);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var randomNumber = Random();

    List<Review> reviewList = getReviewList();

    Widget installButton() {
      return Consumer<Navigation>(
        builder: (context, navigation, _) => Container(
          decoration: boxDecoration(
              bgColor: Color(0xFF01875f), radius: 8),
          width: context.height(),
          height: 35,
          child: Center(
              child: Text('Install',
                  style: primaryTextStyle(
                      color: Colors.white))),
        ).onTap(() async {
          if(navigation.productType == "book"){
            Book response = await BookApi.getBooksById(
                navigation.productID!);
            await InstalledBooksAndAppsDatabase.instance
                .createBook(response);
            isInstall = true;
            setState(() {});
          }
          else{
            App response = await AppApi.getAppsById(navigation.productID!);
            await InstalledBooksAndAppsDatabase.instance.createApp(response);
            isInstall = true;
            setState(() {});
          }
          
        }),
      );
    }

    Widget unInstallButton() {
      return Container(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                    height: 50,
                    decoration: boxDecoration(
                        color: Color(0xFFDADADA),
                        radius: 4),
                    padding: EdgeInsets.only(
                        left: 16, right: 16),
                    child: Text('Cancel',
                            style: primaryTextStyle(
                                color: Color(0xFF01875f)))
                        .center())
                .expand(flex: 4),
            16.width,
            Container(
                    height: 50,
                    decoration: boxDecoration(
                        bgColor: Color(0xFFDADADA),
                        radius: 4),
                    padding: EdgeInsets.only(
                        left: 16, right: 16),
                    child: Text('Open',
                            style: primaryTextStyle())
                        .center())
                .expand(flex: 4),
          ],
        ),
      ).paddingOnly(left: 18, right: 18).onTap(() async {
        await InstalledBooksAndAppsDatabase.instance.deleteApp(productID!);
        await InstalledBooksAndAppsDatabase.instance.deleteBook(productID!);
        setState(() {
          isInstall = false;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<Navigation>(
            builder: (context, navigation, _) =>
                ElevatedButton.icon(
                    label: const Text(''),
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      navigation.setShowAppBar = true;
                      navigation.setPage =
                          navigation.productType == "app"
                              ? "App List"
                              : "Book List";
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent)),
          ),
          260.width,
          const Icon(
            Icons.search,
            color: Colors.black,
          ),
          12.width,
          PopupMenuButton(
            onSelected: (dynamic value) {
              if (value == 1) {
                Share.share("https://www.google.com");
              } else if (value == 2) {
                // PSFlagPropertiesScreen(data7: widget.data)
                //     .launch(context);
              }
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    const Icon(
                      Icons.share_sharp,
                      color: Colors.black,
                    ),
                    8.width,
                    Text('Share'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Icon(
                      Icons.flag_outlined,
                      color: Colors.black,
                    ),
                    8.width,
                    Text('Flag as inappropriate'),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: Consumer<Navigation>(
        builder: (context, navigation, _) =>
            SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Image.network(
                          "https://random.imagecdn.app/80/80",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover)
                      .cornerRadiusWithClipRRect(15),
                  8.width,
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                          navigation.productName ??=
                              "ProductName",
                          style: boldTextStyle(size: 20)),
                      Text("Soon filled with category",
                          style: secondaryTextStyle(
                              color: Color(0xFF01875f))),
                      Text("Contains ads In-app purchases",
                          style: secondaryTextStyle()),
                    ],
                  ).expand(),
                ],
              ).paddingOnly(left: 16, right: 16),
              24.height,
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${randomNumber.nextInt(5) + 0.3}',
                                    style: boldTextStyle()),
                                Icon(Icons.star, size: 10),
                              ],
                            ),
                            Text(
                                '${randomNumber.nextInt(153648) + 1000}K reviews',
                                style: secondaryTextStyle(
                                    size: 12))
                          ],
                        ).paddingOnly(right: 16, left: 8),
                        Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey),
                        Column(
                          children: [
                            Icon(
                                Icons.move_to_inbox_rounded,
                                size: 22),
                            Text(
                                navigation.productSize
                                                .toString() +
                                            navigation
                                                .productType! ==
                                        "app"
                                    ? "MB"
                                    : "Pages",
                                style: secondaryTextStyle(
                                    size: 12)),
                          ],
                        ).paddingOnly(right: 16, left: 16),
                        Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey),
                        Column(
                          children: [
                            Icon(Icons.add_box_rounded,
                                size: 20),
                            Text('Rated for 3+',
                                style:
                                    secondaryTextStyle()),
                          ],
                        ).onTap(() {
                          accountDialogBox(context,
                              onPressed: () {
                            finish(context);
                          });
                        }).paddingOnly(right: 16, left: 16),
                        Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey),
                        Column(
                          children: [
                            // Change to downloads atrributes from backend
                            Text(
                                '${randomNumber.nextInt(100) + 30}K',
                                style: boldTextStyle(
                                    size: 14)),
                            2.height,
                            Text('Downloads',
                                style: secondaryTextStyle(
                                    size: 13)),
                          ],
                        ).paddingOnly(right: 16, left: 16),
                      ],
                    ).paddingOnly(left: 14, right: 8),
                  ],
                ),
              ),
              32.height,
              FutureBuilder<bool>(
                  future: navigation.productType == "book" ? InstalledBooksAndAppsDatabase
                      .instance
                      .checkBookExist(productID!) : InstalledBooksAndAppsDatabase.instance.checkAppExist(productID!),
                  builder: (BuildContext context,
                      AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!
                          ? unInstallButton()
                          : installButton().paddingOnly(
                              left: 16, right: 16);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              24.height,
              GestureDetector(
                onTap: () {
                  const SnackBar(
                    content: Text('Feature incoming !'),
                  );
                  ;
                },
                child: Row(
                  children: [
                    Text('You might also like',
                            style: boldTextStyle())
                        .expand(),
                    Icon(Icons.arrow_forward_rounded),
                  ],
                ).paddingOnly(left: 16, right: 16),
              ),
              12.height,
              // Soon will be filled with apps/books with the same category

              // Container(
              //   height: 140,
              //   child: ListView.builder(
              //     padding: EdgeInsets.only(left: 8, right: 8),
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: details!.length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         width: 150,
              //         child: Column(
              //           crossAxisAlignment:
              //               CrossAxisAlignment.start,
              //           children: [
              //             Image.network(
              //                     navigation.productCover,
              //                     height: 80,
              //                     width: 150,
              //                     fit: BoxFit.cover)
              //                 .cornerRadiusWithClipRRect(15),
              //             3.height,
              //             Text(details![index].title!,
              //                 style: boldTextStyle(size: 13),
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1),
              //             Text(
              //                 details![index]
              //                         .appSize
              //                         .toString() +
              //                     "MB",
              //                 style: secondaryTextStyle(
              //                     size: 12)),
              //           ],
              //         ).paddingOnly(left: 8, right: 8),
              //       );
              //     },
              //   ),
              // ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text('About this game',
                      style: boldTextStyle()),
                  Icon(Icons.arrow_forward_rounded),
                ],
              )
                  .paddingOnly(left: 16, right: 16)
                  .onTap(() {}),
              12.height,
              Text(navigation.productDescription ??= "")
                  .paddingOnly(left: 16, right: 16),
              18.height,
              // Will be filled with all categories available

              // Container(
              //   height: 30,
              //   child: ListView.builder(
              //     padding: EdgeInsets.only(left: 8, right: 8),
              //     scrollDirection: Axis.horizontal,
              //     shrinkWrap: true,
              //     itemCount: list2.length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         height: 30,
              //         padding: EdgeInsets.only(
              //             left: 16, right: 16),
              //         decoration: boxDecoration(
              //             color: grey, radius: 16),
              //         child: Text(list2[index]).center(),
              //       ).paddingOnly(left: 8);
              //     },
              //   ),
              // ),
              18.height,
              Text('Rate this app', style: boldTextStyle())
                  .paddingOnly(left: 16, right: 16),
              Text('Tell other what you think')
                  .paddingOnly(left: 16, right: 16),
              18.height,
              RatingBarWidget(
                itemCount: 5,
                size: 26,
                spacing: 16,
                rating: 0,
                onRatingChanged: (v) {},
              ).paddingOnly(left: 16, right: 16),
              18.height,
              Text('Writes and reviews',
                      style: primaryTextStyle(
                          color: Color(0xFF01875f)))
                  .paddingOnly(left: 16, right: 16),
              28.height,
              Row(
                children: [
                  Row(
                    children: [
                      Text('Ratings and  reviews',
                          style: boldTextStyle(size: 18)),
                      16.width,
                      Icon(Icons.add_circle_outline,
                          size: 16),
                    ],
                  )
                      .paddingOnly(left: 16, right: 16)
                      .expand(),
                  Icon(Icons.arrow_forward_rounded)
                      .onTap(() {
                    // Will be filled with review screen

                    // ReviewScreen(data1: widget.data)
                    //     .launch(context);
                  }).paddingRight(16),
                ],
              ),
              16.height,
              Row(
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${randomNumber.nextInt(5) + 0.5}',
                          style: boldTextStyle(size: 45)),
                      RatingBarWidget(
                        itemCount: 5,
                        size: 10,
                        spacing: 16,
                        rating: 4.5,
                        onRatingChanged: (v) {},
                      ),
                      4.height,
                      Text(
                          '${randomNumber.nextInt(156629)}',
                          style:
                              primaryTextStyle(size: 10)),
                    ],
                  ).paddingOnly(left: 8, right: 8),
                  5.width,
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('5',
                              style:
                                  boldTextStyle(size: 12)),
                          4.width,
                          Container(
                            decoration: boxDecoration(
                                bgColor: Color(0xFFDADADA),
                                radius: 16),
                            width: context.width() * 0.6,
                            height: 12.0,
                            alignment: Alignment.topLeft,
                            child: Container(
                                    color:
                                        Color(0xFF01875f),
                                    width: 120.0,
                                    height: 50.0)
                                .cornerRadiusWithClipRRect(
                                    15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('4',
                              style:
                                  boldTextStyle(size: 12)),
                          8.width,
                          Container(
                            decoration: boxDecoration(
                                bgColor: Color(0xFFDADADA),
                                radius: 16),
                            width: context.width() * 0.6,
                            height: 12.0,
                            alignment: Alignment.topLeft,
                            child: Container(
                                    color:
                                        Color(0xFF01875f),
                                    width: 30.0,
                                    height: 50.0)
                                .cornerRadiusWithClipRRect(
                                    15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('3',
                              style:
                                  boldTextStyle(size: 12)),
                          8.width,
                          Container(
                            decoration: boxDecoration(
                                bgColor: Color(0xFFDADADA),
                                radius: 16),
                            width: context.width() * 0.6,
                            height: 12.0,
                            alignment: Alignment.topLeft,
                            child: Container(
                                    color:
                                        Color(0xFF01875f),
                                    width: 15.0,
                                    height: 50.0)
                                .cornerRadiusWithClipRRect(
                                    15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('2',
                              style:
                                  boldTextStyle(size: 12)),
                          8.width,
                          Container(
                            decoration: boxDecoration(
                                bgColor: Color(0xFFDADADA),
                                radius: 16),
                            width: context.width() * 0.6,
                            height: 12.0,
                            alignment: Alignment.topLeft,
                            child: Container(
                                    color:
                                        Color(0xFF01875f),
                                    width: 10.0,
                                    height: 50.0)
                                .cornerRadiusWithClipRRect(
                                    15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('1',
                              style:
                                  boldTextStyle(size: 12)),
                          8.width,
                          Container(
                            decoration: boxDecoration(
                                bgColor: Color(0xFFDADADA),
                                radius: 16),
                            width: context.width() * 0.6,
                            height: 12.0,
                            alignment: Alignment.topLeft,
                            child: Container(
                                    color:
                                        Color(0xFF01875f),
                                    width: 50.0,
                                    height: 50.0)
                                .cornerRadiusWithClipRRect(
                                    15),
                          ),
                        ],
                      )
                    ],
                  ).paddingOnly(left: 10),
                ],
              ),
              30.height,
              SingleChildScrollView(
                padding:
                    EdgeInsets.only(left: 16, right: 16),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Gameplay',
                            style: primaryTextStyle(
                                color: Colors.black45)),
                        8.width,
                        Text('4.1'),
                        Icon(Icons.star, size: 10),
                      ],
                    ),
                    40.width,
                    Row(
                      children: [
                        Text('Graphics',
                            style: primaryTextStyle(
                                color: Colors.black45)),
                        8.width,
                        Text('4.0'),
                        Icon(Icons.star, size: 10),
                      ],
                    ),
                    40.width,
                    Row(
                      children: [
                        Text('Control',
                            style: primaryTextStyle(
                                color: Colors.black45)),
                        8.width,
                        Text('4.0'),
                        Icon(Icons.star, size: 10),
                      ],
                    ),
                    30.height,
                  ],
                ),
              ),
              30.height,
              ListView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: reviewList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                child: Text(
                                    reviewList[index]
                                        .cirLogo![0]),
                                backgroundColor:
                                    Colors.blue),
                            14.width,
                            Text(reviewList[index].title!,
                                    style:
                                        secondaryTextStyle(
                                            size: 16))
                                .expand(),
                            PopupMenuButton(
                              onSelected: (dynamic value) {
                                if (value == 1) {
                                  toast(
                                      "Review flagged as inappropriate ");
                                } else if (value == 2) {
                                  toast(
                                      'Review flagged as spam');
                                }
                              },
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 1,
                                    child: Text(
                                        "Flag as inappropriate")),
                                PopupMenuItem(
                                  value: 2,
                                  child: const Text(
                                          "Flag as span")
                                      .onTap(() {
                                    toastLong(
                                        "Review flagged as span");
                                  }),
                                ),
                              ],
                            )
                          ],
                        ),
                        16.height,
                        Row(
                          children: [
                            RatingBarWidget(
                              itemCount: 5,
                              size: 10,
                              spacing: 16,
                              rating: 3.5,
                              onRatingChanged: (v) {},
                            ),
                            8.width,
                            Text(reviewList[index].date!,
                                style: secondaryTextStyle())
                          ],
                        ),
                        8.height,
                        Text(reviewList[index].subTile!,
                            style: secondaryTextStyle()),
                        32.height,
                        Row(
                          children: [
                            Text('Was this review helpful?',
                                style:
                                    secondaryTextStyle()),
                            16.width.expand(),
                            FlatButton(
                              highlightColor:
                                  Colors.green[200],
                              height: 25,
                              minWidth: 55,
                              onPressed: () {
                                toastLong(
                                    'Thanks for the feedback');
                              },
                              child: Text('Yes'),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors
                                          .grey[400]!),
                                  borderRadius:
                                      BorderRadius.circular(
                                          20)),
                            ).paddingRight(10),
                            FlatButton(
                              highlightColor:
                                  Colors.green[200],
                              height: 25,
                              minWidth: 55,
                              onPressed: () {
                                toastLong(
                                    'Thanks for the feedback');
                              },
                              child: Text('No'),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors
                                          .grey[400]!),
                                  borderRadius:
                                      BorderRadius.circular(
                                          20)),
                            ),
                          ],
                        ),
                        8.height,
                      ],
                    ).paddingOnly(left: 16, right: 16);
                  }),
              24.height,
              InkWell(
                onTap: () {},
                child: Text('See all reviews',
                        style: primaryTextStyle(
                            color: Color(0xFF01875f)))
                    .paddingOnly(left: 16),
              ),
              24.height,
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text('Developer contact',
                      style: boldTextStyle()),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        visibleItem = !visibleItem;
                      });
                    },
                    icon: visibleItem
                        ? const Icon(Icons
                            .keyboard_arrow_up_outlined)
                        : const Icon(Icons
                            .keyboard_arrow_down_rounded),
                  ),
                ],
              ).paddingOnly(left: 16, right: 16),
              8.height,
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.adjust_rounded, size: 22),
                      18.width,
                      Text('Website',
                          style:
                              primaryTextStyle(size: 15)),
                    ],
                  ),
                  16.height,
                  Row(
                    children: [
                      Icon(Icons.email_outlined, size: 22),
                      18.width,
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          4.height,
                          Text('Email',
                              style: primaryTextStyle(
                                  size: 15)),
                          Text('mockmail@gmail.com',
                              style: secondaryTextStyle(
                                  size: 13)),
                        ],
                      ),
                    ],
                  ),
                  16.height,
                  Row(
                    children: [
                      const Icon(
                          Icons
                              .not_listed_location_outlined,
                          size: 20),
                      18.width,
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text('Address',
                              style: primaryTextStyle(
                                  size: 15)),
                          Text(
                              'Bukit Algoritma Jl. Cisuba, Taman Sari, Kec. Cikidang, Kabupaten Sukabumi, Jawa Barat 43367',
                              style: secondaryTextStyle(
                                  size: 12)),
                        ],
                      ),
                    ],
                  ),
                  16.height,
                  Row(
                    children: [
                      const Icon(Icons.privacy_tip_sharp,
                          size: 18),
                      18.width,
                      Text('Privacy policy',
                          style:
                              primaryTextStyle(size: 15)),
                    ],
                  ),
                  24.height,
                ],
              )
                  .visible(visibleItem)
                  .paddingOnly(left: 16, right: 16),
              16.height,
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.refresh_outlined),
                    onPressed: () {},
                  ),
                  Text('App refund policy',
                      style: boldTextStyle()),
                ],
              ),
              16.height,
              Text('All price include PPN.',
                      style: primaryTextStyle())
                  .paddingAll(16),
              24.height,
            ],
          ),
        ),
      ),
    );
  }
}
