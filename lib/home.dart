import 'package:flutter/material.dart';
import 'package:sidemenu/routes.dart';

import 'home.dart';
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
import 'package:flutter/material.dart';

import 'app_drawer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import "package:normal/normal.dart";
import "package:flame/time.dart";
import 'package:shared_preferences/shared_preferences.dart';

import 'app_drawer.dart';

const COLOR = const Color.fromRGBO(22, 22, 22, 0.7);
const SIZE = 52.0;
const GRAVITY = 700.0;
const BOOST = -300;
var score = 0;
bool updateScore = false;
int highScore = 0;
int gemCollected = -1;
MyGame game;
double tempHeight = 0;
bool updateLives  =false;
bool hasLives = true;
CharacterSprite character;
//Building APK --> flutter build apk --split-per-abi
double height = AppBar().preferredSize.height;
var count = new List(4);

class Home extends StatelessWidget{
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(

          centerTitle: true,
          title: Text('Primedash',style: TextStyle(fontFamily: 'logo', fontSize: 30, color: Color.fromRGBO(252,238,10, 1))),

          backgroundColor: Color.fromRGBO(28, 28, 28, 1),
        ),
      body: Center(
        child: myApp(),
      ),
    );

    }
  }

bool tapped = false;
class myApp extends StatelessWidget {
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;


    return MaterialApp(
    debugShowCheckedModeBanner: false,
      color: Colors.red,
      home: Scaffold(


        body: SafeArea(
          bottom: false,
          child: Center(
            child: Container(
              child: GestureDetector(
                // When the child is tapped, show a snackbar.
                onTap: () {

                  character.tap();
                },
                child: game.widget,
              ),
            ),
          ),
        ),

      ),);
  }

}

double tempX = 0;
double heightPos = 0;
int lives = 99;
double orgPos = 0;
class Prime extends TextComponent{
  double height = AppBar().preferredSize.height;

  bool collectedItem = false;
  double speedX = 150.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 0;
  int value1 = 0;
  bool returned = false;
  Prime(String text, TextConfig textConfig, double posX, double posY, int value) : super(text) {
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = posX+40;
    this.y = posY;
    orgPos = this.y;
    value1 = value;

  }
  @override
  bool destroy() {
    return returned;
  }
  @override
  void update(double tt){
    if (paused){
      this.x = -20000;
    }
    double dist = sqrt((compy-y)*(compy-y) + (compx-x)*(compx-x));

    if (dist<45 && !collectedItem){
      collectPrime = true;
      TextConfig collected = TextConfig(color: Color( 0xFFFFFF00), fontSize: 35);
      this.config = collected;
      score ++;

      count[0] = (score %10).toInt();
      count[1] = ((score /10) % 10).toInt();
      count[2] = ((score /100) % 10).toInt();
      count[3] = ((score /1000) % 10).toInt();

      updateScore = true;
      collectedItem = true;
    }
    if (this.x <-30 || this.y<0){
      returned = true;
      destroy();

    }
    super.update(tt);

    if(!collectPrime) {
      this.x -= speedX * tt;
    }
    else {
      accel++;
      this.y -= 2*accel;

    }
  }
}

class Composite extends TextComponent{
  bool collectedItem = false;
  double speedX = 150.0;
  double posX, posY;
  bool collectComp = false;
  double accel = 0;
  bool returned = false;
  Composite(String text, TextConfig textConfig, double posX, double posY) : super(text) {
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = posX+40;
    this.y = posY;
    orgPos = this.y;

  }
  @override
  bool destroy() {
    return returned;
  }
  @override
  void update(double tt){
    if (paused){
      this.x = -20000;
    }
    double dist = sqrt((compy-y)*(compy-y) + (compx-x)*(compx-x));

    if (dist<45 && !collectedItem){
      collectComp = true;
      TextConfig collected = TextConfig(color: Color( 0xFF808080), fontSize: 30);
      this.config = collected;
      if (score>0) {
        lives--;
        score --;
        count[0] = (score %10).toInt();
        count[1] = ((score /10) % 10).toInt();
        count[2] = ((score /100) % 10).toInt();
        count[3] = ((score /1000) % 10).toInt();
        updateLives  =true;
      }
      updateScore = true;
      collectedItem = true;
    }
    if (this.x <-30 || this.y>tempHeight){
      returned = true;
      destroy();

    }
    super.update(tt);

    if(!collectComp) {
      this.x -= speedX * tt;
    }
    else {
      accel++;
      this.y += 2*accel;

    }
  }
}


double tempWidth = 0;
String message;
bool specialMessage = false;
bool eliminateScoreFlash = false;
bool spikeDeath = false;
bool frozen = true;
double compx;
double compy;
bool paused = false;
double heightApp = AppBar().preferredSize.height;
class CharacterSprite extends AnimationComponent with Resizable {


  double speedY = 0.0;
  Rect catchGameTaps;
  double tempWid = 0;
  double tempHi = 0;
  CharacterSprite()
      : super.sequenced(SIZE/1.5 , SIZE/1.5, 'circle.png', 1,
      textureWidth: 256.0, textureHeight: 256.0) {
    this.anchor = Anchor.center;
    frozen = true;
    paused = true;


  }

  Position get velocity => Position(300.0, speedY);

  reset() {
    this.x = size.width / 4;
    this.y = size.height/2;

    heightPos = size.height;
    speedY = 0;
    angle = 0.0;
    frozen = true;

  }

  @override
  void resize(Size size) {

    super.resize(size);
    reset();
    double tempWid = size.width;
    double tempHi = size.height;
    frozen = true;
  }


  @override
  void update(double t) {
    if (lives<=0){
      this.x = -20000;
    }
    else {
      super.update(t);
      compx = this.x;
      compy = this.y;
      if (!frozen) {
        this.y += speedY * t; // - GRAVITY * t * t / 2
        this.speedY += GRAVITY * t;
        this.angle = velocity.angle();
        if (y > size.height || y < heightApp+10) {
          if (lives > 0) {
            lives--;
          }
          score = 0;
          updateLives  =true;
          updateScore = true;
          paused = true;

          reset();
        }
        if (spikeDeath){

          reset();
        }

      }
    }}

  void tap() {

    paused = false;

    spikeDeath = false;
    if (frozen) {
      frozen = false;
      return;
    }

    speedY = BOOST.toDouble();

  }
}


class MyGame extends BaseGame {


  double timerPrime = 0;
  double timerComp = 0;

  Prime prime;

  Composite composite;
  var primes = [
    2,
    3,
    5,
    7,
    11,
    13,
    17,
    19,
    23,
    29,
    31,
    37,
    41,
    43,
    47,
    53,
    59,
    61,
    67,
    71,
    73,
    79,
    83,
    89,
    97,
    101,
    103,
    107,
    109,
    113,
    127,
    131,
    137,
    139,
    149
  ];
  var composites = [
    4,
    6,
    8,
    9,
    10,
    12,
    14,
    15,
    16,
    18,
    20,
    21,
    22,
    24,
    25,
    26,
    27,
    28,
    30,
    32,
    33,
    34,
    35,
    36,
    38,
    39,
    40,
    42,
    44,
    45,
    46,
    48,
    49,
    50,
    51,
    52,
    54,
    55,
    56,
    57,
    58,
    60,
    62,
    63,
    64,
    65,
    66,
    68,
    69,
    70,
    72,
    74,
    75,
    76,
    77,
    78,
    80,
    81,
    82,
    84,
    85,
    86,
    87,
    88,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    98,
    99,
    100,
    102,
    104,
    105,
    106,
    108,
    110,
    111,
    112,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    125,
    126,
    128,
    129,
    130,
    132,
    133,
    134,
    135,
    136,
    138,
    140,
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
    150
  ];

  var subtrators = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var colours = [
    Color.fromRGBO(247, 220, 111, 1),
    Color.fromRGBO(215, 219, 221, 1),
    Color.fromRGBO(245, 176, 65, 1),
    Color.fromRGBO(88, 214, 141, 1),
    Color.fromRGBO(72, 201, 176, 1),
    Color.fromRGBO(93, 173, 226, 1),
    Color.fromRGBO(236, 112, 99, 1),
    Color.fromRGBO(255, 111, 0, 1)];
  var rng;

  TextPainter textPainterScore;
  TextPainter textPainterLives;
  TextPainter textPainterScoreText;
  TextPainter textPainterLivesText;
  TextPainter textPainterNoMoreLives;

  Offset positionScore;
  Offset positionLives;
  Offset positionScoreText;
  Offset positionLivesText;
  Offset positionNoMoreLives;
  static List<ParallaxImage> images = [

    ParallaxImage("Nebula Blue.png"),
    ParallaxImage("Stars Small_1.png"),
    ParallaxImage("Stars Small_2.png"),
    ParallaxImage("Stars-Big_1_1_PC.png"),
    ParallaxImage("Stars-Big_1_2_PC.png"),

  ];
  double previousPos = 0.0;
  var yPositions = new List(11);
  final parallaxComponent = ParallaxComponent(images,
      baseSpeed: const Offset(20, 0), layerDelta: const Offset(30, 0));
  MyGame(Size size) {

    add(parallaxComponent);
    add(Bg());
    add(character = CharacterSprite());

    this.rng = new Random();
    int intTemp = 1;
    for (int i = 0; i<11; i++){
      intTemp++;
      yPositions[i] = ((tempHeight-height)/12)*( intTemp);
    }

    textPainterNoMoreLives = TextPainter(text: TextSpan(
        text: "",
        style: TextStyle(
            color: Color(0xFFFF0000), fontSize: 32)),
        textDirection: TextDirection.ltr);
    textPainterNoMoreLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionNoMoreLives =
        Offset(size.width / 2 - textPainterNoMoreLives.width / 2,
            size.height / 2 - textPainterNoMoreLives.height / 2);

    textPainterLivesText = TextPainter(text: TextSpan(
        text: "LIVES: ",
        style: TextStyle(
            color: Color.fromRGBO(72, 212, 88, 1), fontSize: 18, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLivesText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionLivesText = Offset(size.width *(4/20) - textPainterLivesText.width / 2,
        heightApp/2 - textPainterLivesText.height / 2);

    textPainterLives = TextPainter(text: TextSpan(
        text: lives.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionLives = Offset(size.width *(7/20)- textPainterLives.width / 2,
        heightApp/2 - textPainterLives.height / 2);

    textPainterScoreText = TextPainter(text: TextSpan(
        text: "SCORE: " ,
        style: TextStyle(
            color: Color.fromRGBO(255, 46, 46, 1), fontSize: 18, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScoreText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScoreText = Offset(size.width *(11/20) - textPainterScoreText.width / 2,
        heightApp/2 - textPainterScoreText.height / 2);

    textPainterScore = TextPainter(text: TextSpan(
        text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScore.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionScore = Offset(size.width *(15.5/20) - textPainterScore.width / 2,
        heightApp/2 - textPainterScore.height / 2);





  }

  static const COLOR = const Color(0xFF527A80);

  @override
  bool recordFps() => true;
  final debugTextconfig = TextConfig(color: Color(0xFFFFFFFF));
  final Position debugPosition = Position(0, tempHeight -100);

  @override
  void render(Canvas c) {

    super.render(c);
    textPainterScore.paint(c, positionScore);
    textPainterScoreText.paint(c, positionScoreText);
    textPainterLives.paint(c, positionLives);
    textPainterLivesText.paint(c, positionLivesText);
    textPainterNoMoreLives.paint(c, positionNoMoreLives);


  }

  @override
  void update(double t) {
    textPainterLivesText = TextPainter(text: TextSpan(
        text: "LIVES: ",
        style: TextStyle(
            color: Color.fromRGBO(72, 212, 88, 1), fontSize: 18, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLivesText.layout(
      minWidth: 0,
      maxWidth: tempWidth,
    );
    textPainterScoreText = TextPainter(text: TextSpan(
        text: "SCORE: " ,
        style: TextStyle(
            color: Color.fromRGBO(255, 46, 46, 1), fontSize: 18, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScoreText.layout(
      minWidth: 0,
      maxWidth: tempWidth,
    );
    if (updateLives) {
      textPainterLives = TextPainter(text: TextSpan(
          text: lives.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterLives.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );

    }
    if (updateScore) {
      textPainterScore = TextPainter(text: TextSpan(
          text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterScore.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );


      updateScore = false;
    }
    int genColourComp = rng.nextInt(8);
    TextConfig comp = TextConfig(color: colours[genColourComp], fontSize: 32, fontFamily: "fontNum");
    int genColourPrime = rng.nextInt(5);
    TextConfig primeC = TextConfig(color: colours[genColourPrime], fontSize: 32, fontFamily: "fontNum");
    if (lives > 0) {
      timerPrime -= t;


      if (!paused) {

        if (timerPrime < 0) {
          int typeNum = rng.nextInt(2);
          double Pos = yPositions[rng.nextInt(10)].toDouble();
          int temp = 0;
          while (temp == 0) {
            if (previousPos == Pos) {
              Pos = yPositions[rng.nextInt(9)].toDouble();
            }
            else {
              temp++;
              previousPos = Pos;
            }
          }
          if (typeNum == 0) {
            int gen = rng.nextInt(3);
            if (gen == 0) {
              add(prime = Prime(
                  primes[rng.nextInt(35)].toString(), comp, tempWidth, Pos,
                  2));
            }
            else if (gen == 1) {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempPrime;
              while (tempLoop == 0) {
                tempPrime = primes[rng.nextInt(35)];
                if (tempPrime > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempPrime = primes[rng.nextInt(35)];
                }
              }

              int finalnum = tempPrime + tempGenNum;
              add(prime = Prime(
                  finalnum.toString() + "-" + tempGenNum.toString(), comp,
                  tempWidth, Pos, 2));
            }

            else {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempPrime;
              while (tempLoop == 0) {
                tempPrime = primes[rng.nextInt(35)];
                if (tempPrime > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempPrime = primes[rng.nextInt(35)];
                }
              }

              int finalnum = tempPrime - tempGenNum;
              add(prime = Prime(
                  finalnum.toString() + "+" + tempGenNum.toString(), comp,
                  tempWidth, Pos, 2));
            }
          }


          if (typeNum == 1) {
            int gen = rng.nextInt(3);
            if (gen == 0) {
              add(composite = Composite(
                  composites[rng.nextInt(35)].toString(), comp, tempWidth,
                  Pos));
            }
            else if (gen == 1) {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempComp;
              while (tempLoop == 0) {
                tempComp = composites[rng.nextInt(35)];
                if (tempComp > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempComp = composites[rng.nextInt(35)];
                }
              }

              int finalnum = tempComp + tempGenNum;
              add(composite = Composite(
                  finalnum.toString() + "-" + tempGenNum.toString(), comp,
                  tempWidth, Pos));
            }

            else {
              int tempGenNum = subtrators[rng.nextInt(10)];
              int tempLoop = 0;
              int tempComp;
              while (tempLoop == 0) {
                tempComp = composites[rng.nextInt(35)];
                if (tempComp > tempGenNum) {
                  tempLoop++;
                }
                else {
                  tempComp = composites[rng.nextInt(35)];
                }
              }

              int finalnum = tempComp - tempGenNum;
              add(composite = Composite(
                  finalnum.toString() + "+" + tempGenNum.toString(), comp,
                  tempWidth, Pos));
            }
          }timerPrime = 0.6;
        }

      }
    }

    else {
      textPainterNoMoreLives = TextPainter(text: TextSpan(
          text: "Out of lives",
          style: TextStyle(
              color: Color(0xFFFF0000), fontSize: 32)),
          textDirection: TextDirection.ltr);
      textPainterNoMoreLives.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      positionNoMoreLives =
          Offset(size.width / 2 - textPainterScore.width / 2,
              size.height / 2 - textPainterScore.height / 2);
    } super.update(t);
  }



}
class Bg extends Component with Resizable {
  static final Paint _paint = Paint()
    ..color = COLOR;

  @override
  void render(Canvas c) {
    c.drawRect(Rect.fromLTWH(0,0, tempWidth, heightApp), _paint);

  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}

