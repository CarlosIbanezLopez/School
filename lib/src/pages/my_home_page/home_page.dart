import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school/src/helpers/theme_colors.dart';

import '../../components/custom_image_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.textFieldBgColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.scaffoldBbColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: ThemeColors.primaryColor,
          ),
          onPressed: () {},
        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ThemeColors.scaffoldBbColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'School',
                      style: TextStyle(
                          color: ThemeColors.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ThemeColors.textFieldBgColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: ThemeColors.primaryColor,
                            ),
                            hintText: "Search you're looking for",
                            hintStyle:
                            TextStyle(color: ThemeColors.primaryColor, fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'bimestre',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: ThemeColors.primaryColor,),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard('images/colegio1.png'),
                          promoCard('images/colegio1.png'),
                          promoCard('images/colegio1.png'),
                          promoCard('images/colegio1.png'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomImageCard(
                      imagePath: 'images/colegio1.png',
                      title: 'notas',
                      description: 'alumnos',
                    ),
                    CustomImageCard(
                      imagePath: 'images/colegio1.png',
                      title: 'alumno',
                      description: 'alumno',
                    )

                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(image) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1)
              ])),
        ),
      ),
    );
  }
}