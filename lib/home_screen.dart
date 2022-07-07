import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/detail_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeApi =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  List pokedex = [];

  var typeColor = {
    'Fire': Color(0xffFD6C6C),
    'Grass': Color(0xff49D1B1),
    'Water': Color(0xff77BFFE),
    'Electric': Color(0xffFED76E),
    'Poison': Colors.purple,
    'Bug': Colors.lightGreen,
    'Ice': Colors.lightBlue,
    'Steel': Colors.blueGrey,
    'Flying': Colors.indigo,
    'Normal': Colors.brown,
    'Ground': Colors.amber[200],
    'Fighting': Colors.red[700],
    'Dark': Colors.brown[900],
    'Psychic': Colors.pink[200],
    'Rock': Colors.orange[300],
    'Ghost': Colors.deepPurple,
    'Fairy': Colors.pink[100],
    'Dragon': Color(0xff7039F9)
  };

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff181919),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Text(
                "Pokedex",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            (pokedex.isNotEmpty)
                ? Expanded(
                    child: GridView.builder(
                        padding: EdgeInsets.only(top: 30),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: pokedex.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: typeColor[pokedex[index]['type'][0]],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Image.asset(
                                          'images/pokeball.png',
                                          height: 100,
                                        )),
                                    Positioned(
                                        bottom: -15,
                                        right: -15,
                                        child: Hero(tag: index, child: CachedNetworkImage(
                                          imageUrl: pokedex[index]['img'],
                                          height: 150,
                                        ))),
                                    Positioned(
                                      top: 20,
                                      left: 15,
                                      child: Text(
                                        pokedex[index]['name'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 50,
                                        left: 15,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 4,
                                              bottom: 4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          child: Text(
                                            pokedex[index]['type'][0],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )),
                                    (pokedex[index]['type'].length == 2)
                                        ? Positioned(
                                            top: 85,
                                            left: 15,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 4,
                                                  bottom: 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white
                                                      .withOpacity(0.5)),
                                              child: Text(
                                                pokedex[index]['type'][1],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ))
                                        : Container(),
                                  ],
                                )),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailPage(
                                            pokemonColor: typeColor[
                                                pokedex[index]['type'][0]],
                                            pokemonDetails: pokedex[index],
                                            heroTag: index,
                                          )));
                            },
                          );
                        }),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ));
  }

  void fetchPokemonData() {
    var url = Uri.http('raw.githubusercontent.com',
        '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);

        pokedex = decodedJsonData['pokemon'];
        setState(() {});
      } else {
        print(value.statusCode);
      }
    });
  }
}
