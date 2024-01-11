import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/detail_page.dart';
import 'package:pokedex/drawer.dart';
import 'package:pokedex/features/fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List<dynamic> pokedex = [];
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldkey,
      drawer: MyDrawer(),
      body: Stack(
        children: [
          Positioned(
            top: -25,
            right: -50,
            child: Image.asset(
              'assets/images/pball.png',
              color: Colors.grey,
              height: 230,
              width: 230,
            ),
          ),
          Positioned(
            top: 77,
            right: 53,
            child: GestureDetector(
              onTap: () {
                scaffoldkey.currentState!.openDrawer();
              },
              child: Icon(Icons.menu),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Text(
              'Pokedex',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Positioned(
            top: 23,
            left: 70,
            child: Lottie.asset(
              'assets/lottie/movingpika.json',
              height: 185,
              width: 185,
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: pokedex.length,
                    itemBuilder: (context, index) {
                      var type = pokedex[index]['type'][0];
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: type == 'Grass'
                                  ? Colors.greenAccent
                                  : type == 'Fire'
                                      ? Colors.redAccent
                                      : type == 'Water'
                                          ? Colors.blueAccent
                                          : type == 'Electric'
                                              ? Colors.yellowAccent
                                              : type == 'Rock'
                                                  ? Colors.grey
                                                  : type == 'Ground'
                                                      ? Colors.brown
                                                      : type == 'Psychic'
                                                          ? Colors.indigo
                                                          : type == 'Fighting'
                                                              ? Colors.orange
                                                              : type == 'Bug'
                                                                  ? Colors.lightGreen
                                                                  : type == 'Ghost'
                                                                      ? Colors.deepPurpleAccent
                                                                      : type == 'Normal'
                                                                          ? Colors.black26
                                                                          : type == 'Poison'
                                                                              ? Colors.deepPurple
                                                                              : Colors.pinkAccent,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -10,
                                  right: -8,
                                  child: Image.asset(
                                    'assets/images/pball.png',
                                    height: 100,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  left: 10,
                                  child: Text(
                                    pokedex[index]['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  left: 20,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 4,
                                        bottom: 4,
                                      ),
                                      child: Text(
                                        type.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white24,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  bottom: 5,
                                  child: Hero(
                                    tag: index,
                                    child: CachedNetworkImage(
                                      imageUrl: pokedex[index]['img'],
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                            pokemonDetail: pokedex[index],
                            color: type == 'Grass'
                                  ? Colors.greenAccent
                                  : type == 'Fire'
                                      ? Colors.redAccent
                                      : type == 'Water'
                                          ? Colors.blueAccent
                                          : type == 'Electric'
                                              ? Colors.yellowAccent
                                              : type == 'Rock'
                                                  ? Colors.grey
                                                  : type == 'Ground'
                                                      ? Colors.brown
                                                      : type == 'Psychic'
                                                          ? Colors.indigo
                                                          : type == 'Fighting'
                                                              ? Colors.orange
                                                              : type == 'Bug'
                                                                  ? Colors.lightGreen
                                                                  : type == 'Ghost'
                                                                      ? Colors.deepPurpleAccent
                                                                      : type == 'Normal'
                                                                          ? Colors.black26
                                                                          : type == 'Poison'
                                                                              ? Colors.deepPurple
                                                                              : Colors.pinkAccent, heroTag: index),));
                        },
                      );
                      
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: height * 0.1,
            width: width,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(padding: EdgeInsets.all(16),
                child: FloatingActionButton(
                  onPressed: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
                  },
                  child: Icon(Icons.tune),
                ),
            ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchPokemonData() async {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedJsonData = jsonDecode(response.body);
        setState(() {
          pokedex = decodedJsonData['pokemon'];
        });
      }
    } catch (error) {
      print("Error fetching Pokemon data: $error");
    }
  }
}