

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Colors.dart';


class NoDataFound{


noItemFound(String text) {
    return
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ListView(
              children: <Widget>[
                SizedBox(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //no_item_found.png
                        Image.asset(
                          "assets/images/search.png",
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 18,
                            color: awsMixedColor,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  height: constraints.maxHeight,
                ),

              ],
            );
          });


      Expanded(
      child: Center(
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //no_item_found.png
                  Image.asset(
                    "assets/images/no_item_found.png",
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.hint_color,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      flex: 1,
    );
  }

}