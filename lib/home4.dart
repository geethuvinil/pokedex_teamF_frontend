import 'dart:convert';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/alltypes.dart';
import 'package:pokedex/detail_page.dart';
import 'package:pokedex/drawer.dart';
import 'package:pokedex/features/fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  final String pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List<dynamic> pokedex = [];
  var scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
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
                                              ? Color.fromARGB(
                                                  255, 192, 192, 95)
                                              : type == 'Rock'
                                                  ? Colors.grey
                                                  : type == 'Ground'
                                                      ? const Color.fromARGB(
                                                          255, 101, 38, 15)
                                                      : type == 'Psychic'
                                                          ? Colors.indigo
                                                          : type == 'Fighting'
                                                              ? Colors.orange
                                                              : type == 'Bug'
                                                                  ? Colors
                                                                      .lightGreen
                                                                  : type ==
                                                                          'Ghost'
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          3,
                                                                          93,
                                                                          6)
                                                                      : type ==
                                                                              'Normal'
                                                                          ? Colors
                                                                              .black26
                                                                          : type == 'Poison'
                                                                              ? Colors.amberAccent
                                                                              : type == 'Ice'
                                                                                  ? Colors.blueGrey
                                                                                  : type == 'Dragon'
                                                                                      ? Color.fromARGB(255, 158, 86, 86)
                                                                                      : type == 'Flying'
                                                                                          ? const Color.fromARGB(255, 77, 3, 27)
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    pokemonDetail: pokedex[index],
                                    color: type == 'Grass'
                                        ? Colors.greenAccent
                                        : type == 'Fire'
                                            ? Colors.redAccent
                                            : type == 'Water'
                                                ? Colors.blueAccent
                                                : type == 'Electric'
                                                    ? Color
                                                        .fromARGB(255, 192, 192,
                                                            95)
                                                    : type == 'Rock'
                                                        ? Colors.grey
                                                        : type == 'Ground'
                                                            ? const Color
                                                                .fromARGB(
                                                                255, 101, 38, 15)
                                                            : type == 'Psychic'
                                                                ? Colors.indigo
                                                                : type ==
                                                                        'Fighting'
                                                                    ? Colors
                                                                        .orange
                                                                    : type ==
                                                                            'Bug'
                                                                        ? Colors
                                                                            .lightGreen
                                                                        : type ==
                                                                                'Ghost'
                                                                            ? const Color.fromARGB(
                                                                                255,
                                                                                3,
                                                                                93,
                                                                                6)
                                                                            : type == 'Normal'
                                                                                ? Colors.black26
                                                                                : type == 'Poison'
                                                                                    ? Colors.amberAccent
                                                                                    : type == 'Ice'
                                                                                        ? Colors.blueGrey
                                                                                        : type == 'Dragon'
                                                                                            ? Color.fromARGB(255, 158, 86, 86)
                                                                                            : type == 'Flying'
                                                                                                ? const Color.fromARGB(255, 77, 3, 27)
                                                                                                : Colors.pinkAccent,
                                    heroTag: index),
                              ));
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
              child: Padding(
                padding: EdgeInsets.all(16),
                child: FloatingActionBubble(
                  items: <Bubble>[
                    Bubble(
                      icon: Icons.catching_pokemon,
                      iconColor: Colors.purpleAccent,
                      title: 'All Types',
                      titleStyle: TextStyle(fontSize: 15),
                      bubbleColor: Colors.white,
                      onPress: () {
                        _animationController!.reverse();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TypePage(),
                            ));
                      },
                    ),
                    Bubble(
                      icon: Icons.favorite,
                      iconColor: Colors.purpleAccent,
                      title: 'Favorite Pokemons',
                      titleStyle: TextStyle(fontSize: 15),
                      bubbleColor: Colors.white,
                      onPress: () {
                        _animationController!.reverse();
                      },
                    ),
                    Bubble(
                      icon: Icons.search,
                      iconColor: Colors.purpleAccent,
                      title: 'Search',
                      titleStyle: TextStyle(fontSize: 15),
                      bubbleColor: Colors.white,
                      onPress: () {
                        if (_animationController != null) {
                          _animationController!.reverse();
                        }

                        showModalBottomSheet(
  context: context,
  builder: (BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )                        
                  
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  },
);

                      },
                    ),
                  ],
                  animation: _animation!,
                  onPress: () => _animationController!.isCompleted
                      ? _animationController!.reverse()
                      : _animationController!.forward(),
                  backGroundColor: Colors.white,
                  iconColor: Colors.purple,
                  iconData: Icons.home,
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
