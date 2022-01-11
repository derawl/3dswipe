import 'package:flutter/material.dart';
import 'coffee_data.dart';
import 'home.dart';
import 'details_page.dart';
import 'package:badges/badges.dart';

const duration = Duration(milliseconds: 300);
const initialPage = 6.0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final pageController = PageController(
    viewportFraction: 0.35,
    initialPage: initialPage.toInt()
  );

  final textPageController = PageController(initialPage: initialPage.toInt());

  var data = CoffeeData().returnData();
  double _currentPage = initialPage;
  double _textPage = initialPage;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void coffeeScrollListener(){
    setState(() {
      _currentPage = pageController.page!;
    });
  }

  void textScrollListener(){
    setState(() {
      _textPage = _currentPage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {coffeeScrollListener();});
    textPageController.addListener(() {textScrollListener();});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.removeListener(() {coffeeScrollListener();});
    textPageController.removeListener(() {textScrollListener();});
    pageController.dispose();
    textPageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.black87,)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 5),
          child: Badge(
            badgeColor: Colors.orange,
            position: BadgePosition.topEnd(top: 1, end: -6),
            badgeContent: Text('3', style: TextStyle(color: Colors.white),),
            child: Icon(Icons.shopping_bag_outlined, color: Colors.black87,),
          )
        ),
      ],

    ),
      body: Stack(
        children: [
          Positioned(
            child: DecoratedBox(
                decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5),
                  blurRadius: 90,
                  offset: Offset.zero,
                  spreadRadius: 45
                )
              ]
            )),
            left: 20,
            right: 20,
            bottom: -size.height*0.2,
            height: size.height*0.3,
          ),
          Transform.scale(
            scale: 2.0,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: data.length+1,
              onPageChanged: (value){
                if(value < data.length){
                  textPageController.animateToPage(value, duration: duration, curve: Curves.easeOut);
                }
                if (value == data.length){
                  pageController.animateToPage(0, duration: duration, curve: Curves.linear);
                }
              },
              itemBuilder: (context, index){
                if (index == 0.0){
                  print('stank');
                  return SizedBox.shrink();
                }
                final result = _currentPage - index + 1;
                final coffer = data[index - 1 ];
                final value = -0.4 * result + 1;
                final opacity = value.clamp(0.0, 1.0);
                print(result);
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (context, animation, _){
                              return FadeTransition(opacity: animation,
                                child: DetailsScreen(data: coffer),
                              );
                            })
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Transform(
                      alignment: Alignment.center,
                        transform: Matrix4.identity()..setEntry(3, 2, 0.001)
                        ..translate(0.0, size.height / 1.7* (1-value).abs())
                        ..scale(value),
                        child: Opacity(opacity: opacity,
                          child:  Hero(
                            tag: coffer['name'],
                            child: Image.asset(coffer['image'],
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                    ),
                  ),
                );
              },

              // children: [
              //   Transform(
              //     transform: Matrix4.identity()..setEntry(3, 2, 0.001)
              //       ..translate(0.0, MediaQuery.of(context).size.height / 2.6 * (1-(-0.5+1)).abs())
              //       ..scale(-0.5+1),
              //       child: Image.asset('images/buck.png',)),
              //   Transform(
              //     transform: Matrix4.identity()..setEntry(3, 2, 0.001)
              //       ..translate(0.0, MediaQuery.of(context).size.height / 2.6 * (1-(-0.5+1)).abs())
              //       ..scale(-0.5+1),
              //       child: Image.asset('images/buck.png',)),
              //
              // ],
            ),
          ),
          Positioned(
              height: 100,
              top: 0,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                duration:duration,
                builder: (context, value, child){
                  return Transform.translate(
                    offset: Offset(0.0, -100.00 * value),
                    child: child,

                  );
                },
                child: Column(
                  children: [
                    Expanded(child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: textPageController,
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          print('baba: ${_textPage.toInt()}');
                          final opacity = (1- (index - _textPage).abs()).clamp(0.0, 1.0);
                          return Opacity(opacity: opacity,
                            child: Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                              child: Text(data[index]['name'],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                          );
                        }
                    )),
                    AnimatedSwitcher(
                        duration: duration,
                        key: Key(data[_currentPage.toInt()]['image']),
                        child: Text('\$${data[_currentPage.toInt()]['price'].toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24),
                        )
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
