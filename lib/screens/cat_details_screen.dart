import 'dart:ui';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:pmsna1/models/cat_model.dart';

class CatDetailsScreen extends StatelessWidget {
  final CatModel cat;

  const CatDetailsScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    final AssetImage defaultImage = AssetImage('assets/defaultCat.jpg');


    return SafeArea(
  child: Scaffold(
    body: Stack(
      children: [
        FutureBuilder(
          future: () async {
            try {
              await precacheImage(NetworkImage('https://cdn2.thecatapi.com/images/${cat.referenceImageId}.jpg'), context);
            } catch (e) {
              print(e.toString());
            }
          }(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.error == null && cat.name.toString() != 'Bengal' && cat.name.toString() != 'Devon Rex' && cat.name.toString() != 'European Burmese' && cat.name.toString() != 'Korat' && cat.name.toString() != 'Malayan') {
              return SizedBox(
                width: double.infinity,
                child: Image.network('https://cdn2.thecatapi.com/images/${cat.referenceImageId}.jpg'),
              );
            } else {
              return SizedBox(
                width: double.infinity,
                child: Image(image: defaultImage),
              );
            }
          },
        ),
        buttonArrow(context),
        scroll(),
      ],
    ),
  )
);
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.cyan,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                Text(cat.name.toString(),
                  style:  TextStyle(
                    color: Colors.blue[900],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial'
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                    height: 15,
                ),
                Text(cat.description.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                    height: 8,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                const SizedBox(
                    height: 8,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Temperament: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.pink[600],
                          fontSize: 16
                        ),
                      ),
                      TextSpan(
                        text: '\n${cat.temperament}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 15,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Origin: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.orange[900],
                          fontSize: 16
                        ),
                      ),
                      TextSpan(
                        text: '\n${cat.origin}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),              
                const SizedBox(
                    height: 15,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Life span: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.teal[900],
                          fontSize: 16
                        ),
                      ),
                      TextSpan(
                        text: '\n${cat.lifeSpan}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 15,
                ),
                Text('Affection level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.red[900],
                    fontSize: 16
                  ),
                  textAlign: TextAlign.center,
                ),
                RatingBar.readOnly(
                  filledIcon: Icons.favorite, 
                  emptyIcon: Icons.heart_broken,
                  initialRating: cat.affectionLevel!.toDouble(),
                  maxRating: 5,
                  filledColor: Colors.red,
                  emptyColor: Colors.grey,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
