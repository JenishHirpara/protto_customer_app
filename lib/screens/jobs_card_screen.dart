
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protto_customer_app/utils/SizeConfig.dart';

Color appBarTitleColor = new Color(0xffF59671);
Color headingOneColor = new Color(0xffA9A9A9);
Color headingTwoColor = new Color(0xffF707070);


class PageCardScreen extends StatefulWidget {
  @override
  _PageCardScreenState createState() => _PageCardScreenState();
}

class _PageCardScreenState extends State<PageCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints){
                return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                              child: Text(
                                'Pre-Booked Services',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: headingOneColor

                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'PRODRY',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: headingOneColor

                                        ),
                                      ),
                                      Text(
                                        'Regular Service',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: headingOneColor

                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '₹ 1599',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: headingOneColor

                                    ),
                                  ),
                                ],
                              )
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Type 1',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: headingOneColor

                                          ),
                                        ),
                                        Text(
                                          'Tyre',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: headingOneColor

                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '₹ 1599',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: headingOneColor

                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Text(
                                'Additional Services',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: headingOneColor

                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                );
              }
          )
      ),
    );
  }
}
