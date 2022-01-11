import 'package:flutter/material.dart';
import 'coffee_data.dart';


class DetailsScreen extends StatelessWidget{
  const DetailsScreen({Key? key, required this.data}) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:  IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.black87,)),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: size.width * 0.2),
              child: Text(data['name'],
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onVerticalDragUpdate: (value){
                if(value.primaryDelta! > 10){
                  Navigator.pop(context);
                }
              },
              child: SizedBox(
                height: size.height * 0.5,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Hero(
                          tag: data['name'],
                          child: Image.asset(data['image'],
                            fit: BoxFit.fitHeight,
                          ),
                        )
                    ),
                    Positioned(
                      left: size.width * 0.05,
                      bottom: 6,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1.0, end: 0.0),
                          duration: Duration(milliseconds: 500),
                          builder: (context, value, child){
                            return Transform.translate(
                              offset: Offset(-100.00 * value, 240.00 * value),
                              child: child,

                            );
                          },
                          child: Text('\$${data['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    spreadRadius: 20,
                                  )
                                ]

                            ),
                            textAlign: TextAlign.center,

                          ),

                        )

                    ),
                    Positioned(
                      left: size.width * 0.7,
                      child: Container(),
                      // child: Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      //   child: Text('+',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //     fontSize: 20,
                      //     ),),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     color: Colors.orange,
                      //   ),
                      // ),
                    ),

                  ],
                ),

              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(right: size.width * 0.4, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Option(text: 'S',  size: 30, radius: 5, selectedColor: Colors.orange,),
                  Option(text: 'M', size: 35, radius: 5),
                  Option(text: 'L', size: 45, radius: 5,),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Extras', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),),
            ),
            SizedBox(height: 5,),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Extra(),
                  Extra(),
                  Extra(),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
        onPressed: (){},
        elevation: 3,
        child: Container(
          child: Icon(Icons.shopping_cart),
        )

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

    );
  }
}

class Extra extends StatefulWidget {
  const Extra({
    Key? key,
  }) : super(key: key);

  @override
  State<Extra> createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  bool toogle = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          toogle = !toogle;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 5,
                spreadRadius: 2,
                color: toogle? Colors.orange.shade300 : Colors.grey.shade300
              ),
            ]
          ),
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            children: [
              Image.asset('images/am.png', scale: 10,),
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text('Ham', style: TextStyle(fontSize: 14, color: Colors.black87),),
                 Text('\$90', style: TextStyle(fontSize: 14, color: Colors.black87),)
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    this.color,
    this.textColor,
    this.selectedColor,
    this.radius,
    required this.size
  }) : super(key: key);

  final text;
  final Color? color;
  final Color? textColor;
  final Color? selectedColor;
  final double? radius;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.rice_bowl, color: selectedColor == null? Colors.grey.shade400 : selectedColor, size: size,),
        SizedBox(height: 10,),
        Container(
          child: Text(text.toString(),
           style: TextStyle(fontSize: 16,color: textColor == null? Colors.grey.shade400 : textColor,),),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius!),
            color: color,
          ),
        ),
      ],
    );
  }
}


// Container(
// width: 100,
// alignment: Alignment.center,
// padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
// child: Text('Add', style:TextStyle(color: Colors.white, fontSize: 19),),
// decoration: BoxDecoration(
// color: Colors.orange,
// borderRadius: BorderRadius.circular(100),
// boxShadow:[
// BoxShadow(
// offset: Offset(2, 3),
// blurRadius: 5,
// color: Colors.grey.withOpacity(0.5)
// )
// ]
// ),
// ),