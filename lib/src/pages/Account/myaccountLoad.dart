import 'package:flutter/material.dart';

class LoadingMyAccount extends StatelessWidget {
  const LoadingMyAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: <Widget>[
      SizedBox(
        height: 18,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        dense: true,
        leading: Image.asset(
          'assets/icons/user1.png',
          height: 36,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          "Name",
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
        ),
        subtitle: Text(
          "phoneNo",
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 17),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/Profile');
          },
          icon: Image.asset("assets/icons/pencil.png",
              height: 18, color: Theme.of(context).accentColor),
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        dense: true,
        leading: Image.asset(
          'assets/icons/myorders32.png',
          height: 25,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          "My Orders",
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/OrderHistory');
        },
        trailing: IconButton(
          onPressed: () {},
          iconSize: 20,
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ),
      Divider(thickness: 1, color: Colors.grey[100]),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        dense: true,
        leading: Image.asset(
          'assets/icons/earnings32.png',
          height: 25,
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          "My Earnings",
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/MyEarnings');
        },
        trailing: IconButton(
          onPressed: () {},
          iconSize: 20,
          icon: Icon(Icons.arrow_forward_ios),
        ),
      )
    ]);
  }
}
