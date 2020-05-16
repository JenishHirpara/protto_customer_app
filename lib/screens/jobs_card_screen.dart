import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protto_customer_app/screens/dashboard_screen.dart';
import 'package:protto_customer_app/utils/SizeConfig.dart';

Color appBarTitleColor = new Color(0xffF59671);
Color headingOneColor = new Color(0xffa2a2a2);
Color headingTwoColor = new Color(0xffb1b1b1);

bool checkedValue = false;

class JobsCardScreen extends StatefulWidget {
  @override
  _JobsCardScreenState createState() => _JobsCardScreenState();
}

class _JobsCardScreenState extends State<JobsCardScreen> {
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
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'PRODRY',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: headingTwoColor

                                        ),
                                      ),
                                      Text(
                                        'Regular Service',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: headingTwoColor

                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '₹ 1599',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: headingOneColor

                                    ),
                                  ),
                                ],
                              )
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'Type 1',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: headingTwoColor

                                          ),
                                        ),
                                        Text(
                                          'Tyre',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: headingTwoColor

                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '₹ 1599',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: headingTwoColor

                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(
                                'Additional Services',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: headingOneColor

                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 200,
                                height: SizeConfig.blockSizeVertical * 40,
                                child: ListView(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                          'Job Number 1',
                                        style: TextStyle(
                                          color: headingTwoColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: 100,
                                        height: 25,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                                '₹ 1599',
                                              style: TextStyle(
                                                  color: headingTwoColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16
                                              ),
                                            ),
                                            Checkbox(
                                                value: checkedValue,
                                                onChanged: (bool newValue) {
                                                  setState(() {
                                                    checkedValue = newValue;
                                                  });
                                                }),
                                          ],
                                        ),
                                      )
                                    ),
                                    ListTile(
                                        title: Text('Job Number 2',
                                          style: TextStyle(
                                              color: headingTwoColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16
                                          ),),
                                        trailing: SizedBox(
                                          width: 100,
                                          height: 25,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text('₹ 1599',
                                                style: TextStyle(
                                                    color: headingTwoColor,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 16
                                                ),),
                                              Checkbox(
                                                  value: checkedValue,
                                                  onChanged: (bool newValue) {
                                                    setState(() {
                                                      checkedValue = newValue;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        )
                                    ),
                                    ListTile(
                                        title: Text('Job Number 3',
                                          style: TextStyle(
                                              color: headingTwoColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16
                                          ),),
                                        trailing: SizedBox(
                                          width: 100,
                                          height: 25,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text('₹ 1599',
                                                style: TextStyle(
                                                    color: headingTwoColor,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 16
                                                ),),
                                              Checkbox(
                                                  value: checkedValue,
                                                  onChanged: (bool newValue) {
                                                    setState(() {
                                                      checkedValue = newValue;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        )
                                    ),
                                    ListTile(
                                        title: Text('Job Number 4',
                                          style: TextStyle(
                                              color: headingTwoColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16
                                          ),),
                                        trailing: SizedBox(
                                          width: 100,
                                          height: 25,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text('₹ 1599',
                                                style: TextStyle(
                                                    color: headingTwoColor,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 16
                                                ),),
                                              Checkbox(
                                                  value: checkedValue,
                                                  onChanged: (bool newValue) {
                                                    setState(() {
                                                      checkedValue = newValue;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        )
                                    ),
                                    ListTile(
                                        title: Text('Job Number 5',
                                          style: TextStyle(
                                              color: headingTwoColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16
                                          ),),
                                        trailing: SizedBox(
                                          width: 100,
                                          height: 25,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text('₹ 1599',
                                                style: TextStyle(
                                                    color: headingTwoColor,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 16
                                                ),),
                                              Checkbox(
                                                  value: checkedValue,
                                                  onChanged: (bool newValue) {
                                                    setState(() {
                                                      checkedValue = newValue;
                                                    });
                                                  }),
                                            ],
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Item Total',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: new Color(0xff9D8E92),
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    '............',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: new Color(0xff9D8E92),
                                    ),
                                  ),
                                  Text(
                                    '₹ 3198',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: new Color(0xff9D8E92),
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Center(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 0),
                                  color: Theme.of(context).primaryColor,
                                  height: 50,
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: new Color(0xffF15D24),
                                    onPressed: () {
                                      // TODO Approve All OnPressed ...

                                    },
                                    child: Text(
                                      'Approve All',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 0),
                                    color: Theme.of(context).primaryColor,
                                    height: 50,
                                    width: SizeConfig.blockSizeHorizontal * 35,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0.0),
                                          side: BorderSide(color: orangeColor)
                                      ),
                                      child: Text(
                                          'Approve Selected',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey
                                          )
                                      ),
                                      onPressed: (){
                                        // TODO Approve Selected OnPressed...

                                      },
                                    ),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    color: Theme.of(context).primaryColor,
                                    height: 50,
                                    width : SizeConfig.blockSizeHorizontal * 35,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0.0),
                                          side: BorderSide(color: orangeColor)
                                      ),
                                      child: Text(
                                          'Contact Support',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey
                                          )
                                      ),
                                      onPressed: (){
                                        // TODO Approve Selected OnPressed...

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
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
