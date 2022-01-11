import 'package:flutter/material.dart';
import 'coffee_data.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final data = CoffeeData().returnData();
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details){
          if(details.primaryDelta! < -10){
            Navigator.push(context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, _){
                return FadeTransition(opacity: animation,
                  child: MyHomePage(title: ''),
                );
              })
            );
          }

        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.orange,
                        Colors.white
                      ]
                  )
                ),
              ),
            ),
            Positioned(
              left: size.width * 0.4,
                top: size.height * 0.08,
                child: Text('Delish',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),

            ),
            Positioned(
                height: size.height * 0.7,
                left: 0,
                right: 0,
                top: size.height * 0.03,

                child: Hero(
                  tag: data[4]['name'],
                  child: Image.asset(data[4]['image']),
                )
            ),
            Positioned(
                height: size.height * 0.7,
                left: 0,
                right: 0,
               bottom: 0,

                child: Hero(
                  tag: data[5]['name'],
                  child: Image.asset(data[5]['image'],
                    fit: BoxFit.cover,
                  ),
                )
            ),
            Positioned(
                height: size.height * 0.6,
                left: 0,
                right: 0,
                bottom: -size.height * 0.29,

                child: Hero(
                  tag: data[6]['name'],
                  child: Image.asset(data[6]['image'],
                    fit: BoxFit.cover,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
