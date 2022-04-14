import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'appColors.dart';

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

Future accountDialogBox(BuildContext context,
    {Function? onPressed}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 200,
          width: 400,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.all_inbox).paddingOnly(
                      top: 16, right: 16, left: 16),
                  Text('Rated for 3+',
                          style: boldTextStyle())
                      .paddingOnly(top: 16),
                ],
              ),
              Text('Suitable for all age groups. Some violence in Comical or fantasy context is acceptable Bad language is not permitted.',
                      style: secondaryTextStyle())
                  .paddingOnly(left: 16, top: 8, right: 8),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      minWidth: 10,
                      height: 10,
                      onPressed: () {},
                      child: Text('Learn more',
                          style: primaryTextStyle(
                              color: Color(0xFF01875f)))),
                  FlatButton(
                    minWidth: 10,
                    height: 10,
                    onPressed: () {
                      onPressed!().call();
                    },
                    child: Text('Got it',
                        style: primaryTextStyle(
                            color: Color(0xFF01875f))),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
