import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/rgservice_item.dart';
import './shopping_cart_screen.dart';
import '../providers/bikes.dart';
import '../providers/cart_item.dart';
import '../utils/badge.dart';
import '../utils/custom_repairs_item.dart';
import './no_internet_screen.dart';

Color orangeColor = new Color(0xFFF69C7A);
Color greyColor = new Color(0xFFC2C2C2);

class ServiceScreen extends StatefulWidget {
  final int i;

  ServiceScreen(this.i);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  PageRouteBuilder shoppingCartRouteBuilder() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return ShoppingCartScreen();
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

  void retry() async {
    try {
      final activeBike = Provider.of<Bikes>(context, listen: false).activeBike;
      Provider.of<Bikes>(context, listen: false).startLoad();
      await Provider.of<Bikes>(context, listen: false)
          .getRgPrice(activeBike.brand, activeBike.model);
      Provider.of<Bikes>(context, listen: false).endLoad();
      setState(() {
        _isInternet = true;
      });
    } catch (error) {
      print(error.message);
      if (error.message.toString().contains('Failed host lookup')) {
        Provider.of<Bikes>(context, listen: false).endLoad();
        setState(() {
          _isInternet = false;
        });
      }
    }
  }

  var _isInit = true;
  var _isLoading;
  var _isInternet = true;

  @override
  void didChangeDependencies() async {
    _isLoading = Provider.of<Bikes>(context, listen: false).loadServices;
    if (_isInit) {
      if (_isLoading) {
        final activeBike = Provider.of<Bikes>(context).activeBike;
        if (activeBike != null) {
          setState(() {
            _isInternet = true;
          });
          try {
            await Provider.of<Bikes>(context, listen: false)
                .getRgPrice(activeBike.brand, activeBike.model);
            Provider.of<Bikes>(context, listen: false).endLoad();
          } catch (error) {
            print(error.message);
            if (error.message.toString().contains('Failed host lookup')) {
              Provider.of<Bikes>(context, listen: false).endLoad();
              setState(() {
                _isInternet = false;
              });
            }
          }
        }
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var bike = Provider.of<Bikes>(context, listen: false).activeBike;
    return DefaultTabController(
      initialIndex: widget.i,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          title: bike != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${bike.brand}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${bike.model}',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Choose a bike',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(child: ch, value: cart.itemCount.toString()),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).push(shoppingCartRouteBuilder());
                },
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 40),
            unselectedLabelColor: Colors.grey,
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontFamily: 'SourceSansPro'),
            tabs: [
              Tab(
                text: "Regular Service",
              ),
              Tab(text: "Tyre"),
              Tab(text: "Wash + Coat"),
              Tab(text: "Custom Repairs"),
              Tab(text: "Denting & Painting"),
            ],
          ),
        ),
        body: _isLoading
            ? Center(
                child: Image.asset(
                  'assets/images/loader.gif',
                  fit: BoxFit.cover,
                  height: 85,
                  width: 85,
                ),
              )
            : _isInternet
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: TabBarView(
                      children: <Widget>[
                        regularServicesPage(),
                        comingSoonPage(),
                        comingSoonPage(),
                        customRepairsPage(),
                        comingSoonPage(),
                      ],
                    ),
                  )
                : NoInternetScreen(retry),
      ),
    );
  }

  Widget regularServicesPage() {
    final activeBike = Provider.of<Bikes>(context).activeBike;
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        RgServiceItem(
          price: activeBike != null
              ? double.parse(Provider.of<Bikes>(context, listen: false).proDry)
              : 0.0,
          type: 'PRODRY',
          image: 'assets/images/popular_service_1.png',
        ),
        RgServiceItem(
          price: activeBike != null
              ? double.parse(Provider.of<Bikes>(context, listen: false).proWet)
              : 0.0,
          type: 'PROWET',
          image: 'assets/images/popular_service_2.png',
        ),
      ],
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }

  Widget customRepairsPage() {
    final activeBike = Provider.of<Bikes>(context).activeBike;
    return SingleChildScrollView(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          CustomRepairsItem(
            price: activeBike != null ? 149 : 0.0,
            type: 'Insurance Claim',
            image: 'assets/images/insurance_claim.png',
          ),
          CustomRepairsItem(
            price: activeBike != null ? 149 : 0.0,
            type: 'Brake Inspection',
            image: 'assets/images/brake_inspection.png',
          ),
          CustomRepairsItem(
            price: activeBike != null ? 149 : 0.0,
            type: 'Electrical Inspection',
            image: 'assets/images/electrical_inspection.png',
          ),
          CustomRepairsItem(
            price: activeBike != null ? 149 : 0.0,
            type: 'Clutch Inspection',
            image: 'assets/images/clutch_inspection.png',
          ),
          CustomRepairsItem(
            price: activeBike != null ? 149 : 0.0,
            type: 'Other',
            image: 'assets/images/other.png',
          ),
        ],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Widget comingSoonPage() {
    return Center(
      child: Container(
        child: Image.asset(
          'assets/images/coming_soon.png',
          fit: BoxFit.cover,
        ),
        height: MediaQuery.of(context).size.height * 0.4,
      ),
    );
  }
}
