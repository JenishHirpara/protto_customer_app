import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bikes.dart';
import '../screens/edit_bike_screen.dart';
import './no_internet_dialog.dart';
import '../providers/cart_item.dart';

class MyBikes extends StatefulWidget {
  @override
  _MyBikesState createState() => _MyBikesState();
}

class _MyBikesState extends State<MyBikes> {
  PageRouteBuilder editBikeRouteBuilder(Bike bike) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return EditBikeScreen(bike);
      },
      transitionDuration: Duration(milliseconds: 300),
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

  Future<void> _handleDelete(BuildContext originalcontext, Bike bike) {
    if (bike.active == '1') {
      return showDialog(
        context: originalcontext,
        builder: (context) => AlertDialog(
          title: Text(
            'Request not possible',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          content: Text(
            'This bike is associated with a booking therefore cannot be deleted',
            style: TextStyle(fontFamily: 'SourceSansPro'),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      return showDialog(
        context: originalcontext,
        builder: (context) => AlertDialog(
          title: Text('Delete ${bike.brand} ${bike.model}?'),
          content: Text('Are you sure you want to delete this bike?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Bikes>(originalcontext, listen: false)
                    .deleteBike(bike.id);
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Border getBorder(BuildContext context, Bike bike) {
    if (Provider.of<Bikes>(context).activeBike != null) {
      return bike.id == Provider.of<Bikes>(context).activeBike.id
          ? Border.all(
              color: Theme.of(context).primaryColor,
            )
          : Border.all(color: Colors.white);
    } else {
      return Border.all(color: Colors.white);
    }
  }

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bike = Provider.of<Bike>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: getBorder(context, bike),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: 135,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 14, 0, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${bike.brand} ${bike.model}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Year: ',
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      color: Color.fromRGBO(100, 100, 100, 1),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    bike.year,
                                    style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Registration Number: ',
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color.fromRGBO(100, 100, 100, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: bike.number,
                                      style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        color: Color.fromRGBO(128, 128, 128, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Provider.of<Bikes>(context, listen: false).activeBike ==
                              null
                          ? Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => _handleDelete(context, bike),
                                ),
                              ),
                            )
                          : bike.id ==
                                  Provider.of<Bikes>(context, listen: false)
                                      .activeBike
                                      .id
                              ? Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Active',
                                            style: TextStyle(
                                              fontFamily: 'SourceSansProSB',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          if (bike.active == '1') {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text(
                                                  'Request not possible',
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat'),
                                                ),
                                                content: Text(
                                                  'This bike is associated with a booking therefore cannot be edited',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SourceSansPro'),
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('Okay'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            Navigator.of(context).push(
                                                editBikeRouteBuilder(bike));
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () =>
                                          _handleDelete(context, bike),
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await Provider.of<Bikes>(context, listen: false)
                        .changeActive(
                            bike, Provider.of<Cart>(context, listen: false));
                    setState(() {
                      _isLoading = false;
                    });
                  } catch (error) {
                    print(error.message);
                    if (error.message
                        .toString()
                        .contains('Failed host lookup')) {
                      setState(() {
                        _isLoading = false;
                      });
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return NoInternetDialog();
                        },
                      );
                    }
                  }
                },
              ),
      ),
    );
  }
}
