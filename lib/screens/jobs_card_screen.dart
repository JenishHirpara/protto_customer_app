import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protto_customer_app/screens/dashboard_screen.dart';
import 'package:protto_customer_app/utils/SizeConfig.dart';

Color appBarTitleColor = new Color(0xffF59671);
Color headingOneColor = new Color(0xffa2a2a2);
Color headingTwoColor = new Color(0xffb1b1b1);

String alertDialogText = "You have approved all of your \n" +
                          "additional services. Your new total is ";

String alertDialogTwo = "You did not approve all the services \n" +
    "suggested in the job card. Are you sure \n" +
    "you still want to move forward without \n"+
    "those services? ";

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
          title: Text(
            'Yamaha FZ',
            style: TextStyle(
                fontSize: 18,
                color: orangeColor,
                fontWeight: FontWeight.bold
            ),
          ),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context)
                  .pop(true);
            },
          )
      ),
      body: Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 100,
          child: LayoutBuilder(
              builder: (BuildContext context,
                  BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(
                                  'Pre-Booked Services',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: headingOneColor

                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Text(
                                            'PRODRY',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: headingTwoColor

                                            ),
                                          ),
                                          Text(
                                            'Regular Service',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 14,
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
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Text(
                                            'Type 1',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: headingTwoColor

                                            ),
                                          ),
                                          Text(
                                            'Tyre',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 14,
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
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  'Additional Services',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: headingOneColor

                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                                child: SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 100,
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: <Widget>[
                                                Text(
                                                  '₹ 1599',
                                                  style: TextStyle(
                                                      color: headingTwoColor,
                                                      fontWeight: FontWeight
                                                          .normal,
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: <Widget>[
                                                Text('₹ 1599',
                                                  style: TextStyle(
                                                      color: headingTwoColor,
                                                      fontWeight: FontWeight
                                                          .normal,
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: <Widget>[
                                                Text('₹ 1599',
                                                  style: TextStyle(
                                                      color: headingTwoColor,
                                                      fontWeight: FontWeight
                                                          .normal,
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: <Widget>[
                                                Text('₹ 1599',
                                                  style: TextStyle(
                                                      color: headingTwoColor,
                                                      fontWeight: FontWeight
                                                          .normal,
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
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .end,
                                              children: <Widget>[
                                                Text('₹ 1599',
                                                  style: TextStyle(
                                                      color: headingTwoColor,
                                                      fontWeight: FontWeight
                                                          .normal,
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
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    height: 50,
                                    width: double.infinity,
                                    child: RaisedButton(
                                      color: new Color(0xffF15D24),
                                      onPressed: () {
                                        // TODO Approve All OnPressed ...
                                        approveAllAlertDialog(context);
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
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      height: 50,
                                      width: SizeConfig.blockSizeHorizontal *
                                          35,
                                      child: RaisedButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                0.0),
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
                                        onPressed: () {
                                          // TODO Approve Selected OnPressed...
                                          approveSelectedAlertDialog(context);
                                        },
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      height: 50,
                                      width: SizeConfig.blockSizeHorizontal *
                                          35,
                                      child: RaisedButton(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.0),
                                          side: BorderSide(color: orangeColor),
                                        ),
                                        child: Text(
                                            'Contact Support',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey
                                            )
                                        ),
                                        onPressed: () {
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 3.0,
              color: Color.fromRGBO(241, 93, 36, 1),
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: bottomNavBarIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          iconSize: 30,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.event_note),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.flash_on),
              title: Text(''),
            )
          ],
          onTap: (int newIndex) {
            setState(() {
              bottomNavBarIndex = newIndex;
            });
          },
        ),
      ),
    );
  }


  Future<dynamic> approveAllAlertDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context)
    {
      return Dialog(
        elevation: 5,
        backgroundColor: Colors.white,
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            children: <Widget>[
              Padding(
                child: RichText(
                  text: TextSpan(
                      text: alertDialogText,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "₹ 3198",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            )
                        )
                      ]
                  ),
                ),
                padding: EdgeInsets.all(20),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0.0),
                        side: BorderSide(color: orangeColor),
                      ),
                      onPressed: (){
                        // TODO Jobs button OnPressed...
                        Navigator.of(context)
                            .pop(true);
                      },
                      elevation: 5,
                      child: Text(
                        'Jobs',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    RaisedButton(
                      elevation: 5,
                      color: orangeColor,
                      child: Text(
                          'Checkout',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          )
                      ),
                      onPressed: () {
                        // TODO Approve Selected OnPressed...

                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    );
    }


  Future<dynamic> approveSelectedAlertDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return Dialog(
            elevation: 5,
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: 400,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: RichText(
                      text: TextSpan(
                          text: alertDialogTwo,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal
                          ),
//                          children: <TextSpan>[
//                            TextSpan(
//                                text: "₹ 3198",
//                                style: TextStyle(
//                                    fontSize: 16,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.black
//                                )
//                            )
//                          ]
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0.0),
                            side: BorderSide(color: orangeColor),
                          ),
                          onPressed: (){
                            // TODO Jobs button OnPressed...
//                            Navigator.of(context)
//                                .pop(true);
                          },
                          elevation: 5,
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0.0),
                            side: BorderSide(color: orangeColor),
                          ),
                          onPressed: (){
                            // TODO Jobs button OnPressed...
                            Navigator.of(context)
                                .pop(true);
                          },
                          elevation: 5,
                          child: Text(
                            'No',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }


}



