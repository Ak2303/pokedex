import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final pokemonDetails;
  final pokemonColor;
  final heroTag;

  const DetailPage(
      {Key? key, this.pokemonDetails, this.pokemonColor, this.heroTag})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.pokemonColor,
      body: Stack(
        children: [
          Positioned(
              top: -170,
              left: -200,
              child: Image.asset(
                'images/pokeball.png',
                height: 350,
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          Positioned(
              top: 100,
              left: 30,
              child: Text(
                widget.pokemonDetails['name'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              top: 150,
              left: 30,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.5)),
                child: Text(
                  widget.pokemonDetails['type'][0],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Positioned(
              top: 150,
              left: 105,
              child: (widget.pokemonDetails['type'].length == 2)
                  ? Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.5)),
                      child: Text(
                        widget.pokemonDetails['type'][1],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container()),
          Positioned(
              top: 120,
              right: 30,
              child: Text(
                '#' + widget.pokemonDetails['num'],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
          Positioned(
              top: 200,
              right: -10,
              child: Image.asset(
                'images/pokeball.png',
                height: 175,
                fit: BoxFit.cover,
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                    color: Color(0xff181919).withOpacity(0.7),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
              )),
          Positioned(
              top: 200,
              right: MediaQuery.of(context).size.width / 2 - 100,
              child: Hero(tag: widget.heroTag, child: CachedNetworkImage(imageUrl: widget.pokemonDetails['img'], height: 200, fit: BoxFit.fitHeight,)))
        ],
      ),
    );
  }
}
