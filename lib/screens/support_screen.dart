import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protto_customer_app/utils/SizeConfig.dart';

Color orangeColor = new Color(0xfff15d24);

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Support',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'FAQs',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 1',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 2',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 3',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 4',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 5',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 6',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 7',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 8',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 9',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          'Subtitle 10',
                          style: TextStyle(
                            fontFamily:'SourceSansPro'
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'This is a paragraph. This is another paragraph. This paragraph contains a lot of spaces in the source code but the browser ignores it',
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: FlatButton(
                              onPressed: () {},
                              color: orangeColor,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'CALL',
                                      style: TextStyle(
                                          fontFamily: 'SourcsSansProSB',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: FlatButton(
                              onPressed: () {},
                              color: orangeColor,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'CHAT',
                                      style: TextStyle(
                                          fontFamily: 'SourceSansProSB',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
