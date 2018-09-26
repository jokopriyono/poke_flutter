import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:poke_flutter/pokemon.dart';
import 'package:poke_flutter/pokemondetail.dart';

void main()=>runApp(MaterialApp(
  title: "Poke Flutter",
  home: HomePage(),

  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();

    ambilData();
  }

  ambilData() async{
    var res = await http.get(url);
    var data = jsonDecode(res.body);

    pokeHub = PokeHub.fromJson(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke Flutter"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub == null
          ? Center(
        child: CircularProgressIndicator(),
      )
      : GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon.map((poke)=> Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=>PokeDetail(
                        pokemon: poke,
                      )));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 3.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(poke.img)
                          )
                      ),
                    ),
                    Text(
                      poke.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}