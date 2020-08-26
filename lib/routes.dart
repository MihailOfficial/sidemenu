import 'package:flutter/cupertino.dart';
import 'package:sidemenu/home.dart';
import 'package:sidemenu/product.dart';
import 'package:sidemenu/topScores.dart';
class Routes{
  static const String home = Home.routeName;
  static const String product = Product.routeName;
  static const String topScores = TopScores.routeName;
    static getRoutes(BuildContext context){
      return {
        home:  (context) => Home(),
       product:  (context) => Product(),
        topScores:  (context) => TopScores(),};
    }


}