
  import 'package:flutter/material.dart';
import 'package:protto_customer_app/utils/SizeConfig.dart';

class SupportScreen extends StatefulWidget {
    @override
    _SupportScreenState createState() => _SupportScreenState();
  }

  class _SupportScreenState extends State<SupportScreen> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pop(true);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Center(
              child: Text(
                'Support',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange
                ),
              ),
            ),
          ),
          body: Container(
              width: SizeConfig.blockSizeHorizontal * 100,
              height: SizeConfig.blockSizeVertical * 100,
              color: Colors.white,
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    )
                );
              }
              )
          )
      );
    }
  }
