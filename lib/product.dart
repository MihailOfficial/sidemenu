import 'package:flutter/material.dart';

import 'Animation/FadeAnimation.dart';
import 'app_drawer.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import "package:normal/normal.dart";
import "package:flame/time.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Product extends StatelessWidget {
  static const String routeName = "/product";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(centerTitle: true,
        title: Text('Primedash',style: TextStyle(fontFamily: 'logo', fontSize: 30, color: Color.fromRGBO(252,238,10, 1))),

        backgroundColor: Color.fromRGBO(28, 28, 28, 1),),
      body: Center(
        child: RegisterPage(),
      ),
    );
  }
}
  class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
      debugShowCheckedModeBanner: false,
  home: Scaffold(
  backgroundColor: Colors.white,

  body: SingleChildScrollView(
  child: Container(
  child: Column(
  children: <Widget>[
  Container(
  height: 400,
  decoration: BoxDecoration(
  image: DecorationImage(
  image: AssetImage('assets/images/background.png'),
  fit: BoxFit.fill,
  ),
  ),
  child: Stack(
  children: <Widget>[
  Positioned(
  left: 30,
  width: 80,
  height: 200,
  child: FadeAnimation(1, Container(
  decoration: BoxDecoration(
  image: DecorationImage(
  image: AssetImage('assets/images/light-1.png'),
  ),
  ),
  )),
  ),
  Positioned(
  left: 140,
  width: 80,
  height: 150,
  child: FadeAnimation(1.3, Container(
  decoration: BoxDecoration(
  image: DecorationImage(
  image: AssetImage('assets/images/light-2.png'),
  ),
  ),
  )),
  ),
  Positioned(
  right: 40,
  top: 40,
  width: 80,
  height: 150,
  child: FadeAnimation(1.5, Container(
  decoration: BoxDecoration(
  image: DecorationImage(
  image: AssetImage('assets/images/clock.png'),
  ),
  ),
  )),
  ),
  Positioned(
  child: FadeAnimation(1.6, Container(
  margin: EdgeInsets.only(top: 50),
  child: Center(
  child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
  ),
  )),
  )
  ],
  ),
  ),
  Padding(
  padding: EdgeInsets.all(30.0),
  child: Column(
  children: <Widget>[
  FadeAnimation(1.8, Container(
  padding: EdgeInsets.all(5),
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
  BoxShadow(
  color: Color.fromRGBO(143, 148, 251, .2),
  blurRadius: 20.0,
  offset: Offset(0, 10)
  )
  ]
  ),
  child: Column(
  children: <Widget>[
  Container(
  padding: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
  border: Border(bottom: BorderSide(color: Colors.grey[100]))
  ),
  child: TextField(
  decoration: InputDecoration(
  border: InputBorder.none,
  hintText: "Username",
  hintStyle: TextStyle(color: Colors.grey[400])
  ),
  ),
  ),
  Container(
  padding: EdgeInsets.all(8.0),
  child: TextField(
  decoration: InputDecoration(
  border: InputBorder.none,
  hintText: "Email",
  hintStyle: TextStyle(color: Colors.grey[400])
  ),
  ),
  ),
  Container(
  padding: EdgeInsets.all(8.0),
  child: TextField(
  decoration: InputDecoration(
  border: InputBorder.none,
  hintText: "Password",
  hintStyle: TextStyle(color: Colors.grey[400]),
  ),
  ),
  ),
  ],
  ),
  )),
  SizedBox(height: 30,),
  FadeAnimation(2, Container(
  height: 50,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  gradient: LinearGradient(
  colors: [
  Color.fromRGBO(143, 148, 251, 1),
  Color.fromRGBO(143, 148, 251, .6),
  ]
  )
  ),
  child: Center(
  child: Text("Create Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  ),
  )),
  ],
  ),
  )
  ],
  ),
  ),
  )
  ),);
  }
  }




