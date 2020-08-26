import 'package:flutter/material.dart';
import 'package:sidemenu/routes.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader (
                accountEmail: Text("mihaildev@gmail.com"),
                accountName: Text("Mihail Ghandi"),
                currentAccountPicture: CircleAvatar(
                  radius: 55,

                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/images/test.jpg'),
                  ),
                ),
                ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Game"),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.home),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.product),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Test"),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.topScores),
            )


          ],
        )
      );
  }
}
