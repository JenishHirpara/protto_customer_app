import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './service_screen.dart';

class Service {
  final String id;
  final String service;
  final String type;
  final double price;

  Service({
    @required this.id,
    @required this.service,
    @required this.type,
    @required this.price,
  });
}

class Services {
  List<Service> _items = [
    Service(
      id: DateTime.now().toString(),
      service: 'regular service',
      type: 'prodry',
      price: 1599,
    ),
    Service(
      id: DateTime.now().toString(),
      service: 'regular service',
      type: 'prowet',
      price: 1599,
    ),
  ];

  List<Service> get items {
    return [..._items];
  }

  int findByType(String type) {
    return _items.indexWhere((cartitem) => cartitem.type == type);
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _editingController = TextEditingController();

  List<Service> services = new Services().items;
  var display = List<Service>();

  @override
  void initState() {
    display.addAll(services);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Service> dummySearchList = List<Service>();
    dummySearchList.addAll(services);
    if (query.isNotEmpty) {
      List<Service> dummyListData = List<Service>();
      dummySearchList.forEach((item) {
        if (item.type.contains(query.toLowerCase()) ||
            item.service.contains(query.toLowerCase()) ||
            item.service.replaceAll(' ', '').contains(query.toLowerCase())) {
          print(item.service);
          dummyListData.add(item);
        } else {
          setState(() {
            display.clear();
          });
        }
      });
      setState(() {
        display.clear();
        display.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        display.clear();
        display.addAll(services);
      });
    }
  }

  PageRouteBuilder pageRouteBuilder(int i) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ServiceScreen(i);
      },
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Search Services',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(241, 93, 36, 1),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        titleSpacing: 20,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _editingController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: new InputDecoration(
                  suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.clear,
                        color: new Color(0xff626262),
                      ),
                      onTap: () {
                        _editingController.clear();
                      }),
                  prefixIcon: Icon(
                    Icons.search,
                    color: new Color(0xff626262),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  labelText: "Search Service",
                  hintText: "Search Service",
                  labelStyle: TextStyle(fontFamily: 'SourceSansPro'),
                  filled: true,
                  hintStyle: new TextStyle(
                      fontFamily: 'SourceSansPro', color: new Color(0xff1D1D1)),
                  fillColor: Colors.white),
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, i) => InkWell(
              child: ListTile(
                title: Text(
                  display[i].type,
                  style: TextStyle(fontFamily: 'SourceSansPro'),
                ),
                subtitle: Text(
                  display[i].service,
                  style: TextStyle(fontFamily: 'SourceSansPro'),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              onTap: () {
                if (display[i].service == 'regular service') {
                  int i = 0;
                  Navigator.of(context).push(pageRouteBuilder(i));
                }
              },
            ),
            itemCount: display.length,
          ),
        ],
      ),
    );
  }
}
