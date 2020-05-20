import 'package:flutter/material.dart';

import '../utils/select_address_item.dart';

class SelectAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(24),
              child: Text(
                'Select Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => Column(
                children: <Widget>[
                  SelectAddressItem(),
                  SizedBox(height: 10),
                  Divider(
                    endIndent: 40,
                    indent: 40,
                    color: Color.fromRGBO(200, 200, 200, 1),
                    thickness: 1,
                  ),
                ],
              ),
              itemCount: 3,
            ),
          ],
        ),
      ),
    );
  }
}
