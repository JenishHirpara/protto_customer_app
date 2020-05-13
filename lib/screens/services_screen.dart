
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color orangeColor = new Color(0xFFF69C7A);
Color greyColor = new Color(0xFFC2C2C2);

int bottomNavBarIndex = 0;
var tabsLength = 3;

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: (){
              Navigator.of(context)
                  .pop();
            },
          ),
          title: Text(
            'Yamaha FZ',
            style: TextStyle(
                color: orangeColor,
                fontSize: 20
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.account_circle,
                color: greyColor,
              ),
              onPressed: (){
                // TODO Account icon on pressed...
              },
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: greyColor,
              ),
              onPressed: (){
                // TODO Cart icon on pressed...
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text:
                "Regular Service",
              ),
//              Tab(text: "Tyre"),
//              Tab(text: "Wash + Coat"),
            ],
            labelColor: orangeColor,
          ),
        ),

        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: bottomNavBarIndex,
          backgroundColor: greyColor,
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          iconSize: 30,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: Text('')
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: Text('')
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.event_note),
                title: Text('')
            ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.wifi_tethering),
                title: Text('')
            )
          ],
          onTap: (int newIndex){
            setState(() {
              bottomNavBarIndex = newIndex;
            });
          },
        ),
        body: Padding(padding: EdgeInsets.all(10),
        child: TabBarView(
            children: <Widget>[
            regularServicesPage()
        ],
      )),
      ),
    );
  }

  Widget regularServicesPage() {
    return GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        children: new List<Widget>.generate(8, (index) {
          return new GridTile(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                  color: Colors.white,
                  child: new Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text(
                            'PRODRY',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text(
                            '₹ 1599',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: orangeColor
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            height: 50,
                            color: new Color(0xFFF0F0F0),
                            child: Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.8,
                                heightFactor: 0.5,
                                child: Container(
                                  width: 20,
                                  height: 10,
                                  color: (index == 2 || index == 3 || index == 6 || index == 7 ) ? new Color(0xFF4CAF50) : new Color(0xFFF15D24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add,
                                        color: Colors.white
                                      ),
                                      Text(
                                        (index == 2 || index == 3 || index == 6 || index == 7 ) ? 'ADDED' :
                                        'ADD',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
          );
        }
        )
    );
  }
}
