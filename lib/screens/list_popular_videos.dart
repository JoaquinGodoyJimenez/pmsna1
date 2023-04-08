import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pmsna1/models/actors_model.dart';
import 'package:pmsna1/models/popular_model.dart';
import 'package:pmsna1/models/trailer_model.dart';
import 'package:pmsna1/network/api_actors.dart';
import 'package:pmsna1/network/api_popular.dart';
import 'package:pmsna1/network/api_trailer.dart';
import 'package:pmsna1/widgets/item_popular.dart';
import 'package:pmsna1/widgets/movie_trailer.dart';

class ListPopularVideos extends StatefulWidget {
  const ListPopularVideos({Key? key}) : super(key: key);

  @override
  State<ListPopularVideos> createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Popular')),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemCount: snapshot.data != null ? snapshot.data!.length : 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return VideoDetailsScreen(
                          video: snapshot.data![index],
                          trailer: TrailerModel(),
                          actors: ActorsModel(),
                        );
                      }),
                    );
                  },
                  child: ItemPopular(popularModel: snapshot.data![index]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ocurrio un error :()'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class VideoDetailsScreen extends StatefulWidget {
  final PopularModel video;
  final TrailerModel trailer;
  final ActorsModel actors;
  const VideoDetailsScreen({
    Key? key,
    required this.video,
    required this.trailer,
    required this.actors,
  }) : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  ApiTrailer? apiTrailer;
  ApiActors? apiactors;
  List<ActorsModel>? actors;

  @override
  void initState() {
    super.initState();
    apiTrailer = ApiTrailer(widget.video.id.toString());
    apiactors = ApiActors(widget.video.id.toString());
    apiactors!.getAllActors().then((value) {
      setState(() {
        actors = value;
      });
    });
  }

@override
Widget build(BuildContext context) {
  Color iconColor = Colors.grey;
  bool isPressed = false;

  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(widget.video.originalTitle.toString() +
          ' - ' +
          widget.video.releaseDate.toString()),
      actions: [
        IconButton(
          // ignore: dead_code
          icon: isPressed ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
          color: iconColor,
          onPressed: () {
            setState(() {
              // actualizar el estado del botón al presionar el botón
              isPressed = !isPressed;
              // actualizar el color del icono al presionar el botón
              iconColor = isPressed ? Colors.red : Colors.grey;
            });
          },
        ),
      ],
      ),
      body: FutureBuilder(
        future: apiTrailer!.getTrailer(),
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${widget.video.posterPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Hero(
                        tag: 'poster_${widget.video.id}',
                        //aqui va el vidio
                        child: TrailerItem(
                          trailerkey: (snapshot.data as List<TrailerModel>)[0]
                              .key
                              .toString(),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating:
                                  widget.video.voteAverage!.toDouble(),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 10,
                              ignoreGestures: true,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),

                            const SizedBox(height: 20),
                            FutureBuilder(
                              future: apiactors!.getAllActors(),
                              builder: (context, actorsSnapshot) {
                                if (actorsSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (actorsSnapshot.hasError) {
                                  return const Center(
                                    child: Text('Failed to load actors'),
                                  );
                                }
                                return CarouselSlider(
                                  items: (actorsSnapshot.data
                                          as List<ActorsModel>)
                                      .map((actor) => Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            height:
                                                110, // Altura del contenedor que envuelve la imagen y el texto
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      65, // Ancho de la imagen
                                                  height:
                                                      60, // Altura de la imagen
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey,
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      'https://image.tmdb.org/t/p/w500/${actor.profilePath}',
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          const Icon(
                                                              Icons.person,
                                                              size: 65),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        5), // Espacio entre la imagen y el texto
                                                Text(
                                                  actor.name.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  actor.character.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  options: CarouselOptions(
                                    height: 110, // Altura fija de la vista
                                    aspectRatio: 1.0, // Relación de aspecto 1:1
                                    viewportFraction:
                                        0.2, // Fracción de la pantalla que se muestra
                                    initialPage: 0, // Página inicial
                                    enableInfiniteScroll:
                                        true, // Habilitar el desplazamiento infinito
                                    reverse:
                                        false, // Ordenar los elementos en orden inverso
                                    autoPlay:
                                        false, // Reproducción automática de elementos
                                    autoPlayInterval: Duration(
                                        seconds:
                                            3), // Intervalo de tiempo de reproducción automática
                                    autoPlayAnimationDuration: Duration(
                                        milliseconds:
                                            800), // Duración de la animación de reproducción automática
                                    autoPlayCurve: Curves
                                        .fastOutSlowIn, // Curva de animación de reproducción automática
                                    enlargeCenterPage:
                                        false, // Enfocar en el elemento central
                                    scrollDirection: Axis
                                        .horizontal, // Dirección del desplazamiento
                                  ),
                                );
                              },
                            ),
                            //Descripcion de la pelicula
                            const SizedBox(height: 10),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  widget.video.overview.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
