import 'package:flutter/material.dart';
import 'package:pmsna1/network/api_cat.dart';
import 'package:pmsna1/models/cat_model.dart';

import 'cat_details_screen.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  late Future<List<CatModel>?> _catsFuture;

  @override
  void initState() {
    super.initState();
    _catsFuture = ApiCat().getCats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat List'),
      ),
      body: FutureBuilder<List<CatModel>?>(
        future: _catsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cats = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final cat = cats[index];
                return InkWell(
                  child: Card(
                      color: Colors.grey[900],
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://cdn2.thecatapi.com/images/${cat.referenceImageId}.jpg',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5), BlendMode.darken),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                cat.name.toString(),
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    cat.origin.toString(),
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              IconButton(onPressed: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CatDetailsScreen(cat: cat),
                                ),
                              );
                              }, icon: const Icon(Icons.help_outline), color: Colors.lightBlueAccent,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}