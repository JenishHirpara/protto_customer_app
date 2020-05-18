
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:protto_customer_app/screens/dashboard_screen.dart';
import 'package:protto_customer_app/utils/SizeConfig.dart';


Color appBarTitleColor = new Color(0xffF59671);
Color headingOneColor = new Color(0xffa2a2a2);
Color headingTwoColor = new Color(0xffb1b1b1);

int bottomNavBarIndex = 0;

class MyBikesScreen extends StatefulWidget {
  @override
  _MyBikesScreenState createState() => _MyBikesScreenState();
}

class _MyBikesScreenState extends State<MyBikesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'My Bikes',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: appBarTitleColor
            ),
          ),
        ),
        leading: InkWell(
          onTap: (){
            // TODO Back Arrow onTap..

          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar:  Container(
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
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 100,
                                height: SizeConfig.blockSizeVertical * 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 1.0
                                    ),
                                   color: Colors.white,
                                  boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                  ),]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                      child: Expanded(
                                        flex: 2,
                                        child: Icon(
                                          Icons.directions_bike,
                                          color: Colors.grey,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 35, 20, 35),
                                      child: Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Yamaha FZ',
                                            style: TextStyle(
                                              color: orangeColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),),

                                            Text(
                                              '2017',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),

                                            Text(
                                              'MH 02 KG 0904',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.grey,
                                                size: 25,
                                              ),
                                              padding: EdgeInsets.all(10)
                                            ),
                                            Padding(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                  size: 25,
                                                ),
                                                padding: EdgeInsets.all(10)
                                            ),
                                          ],
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                  'Add New Bike',
                                  style: TextStyle(
                                      color: orangeColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                );
              }
          )
      )
    );
  }
}
