import 'package:flutter/material.dart';

class UserProfileItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final PageRouteBuilder page;

  UserProfileItem({
    this.icon,
    this.title,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 50,
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            color: new Color(0xfffca9ac),
            child: icon,
          ),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
      onTap: () {
        Navigator.of(context).pushReplacement(page);
      },
    );
  }
}
