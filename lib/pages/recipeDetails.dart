import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/RecipeProvider.dart';

import '../pages/PhotoPicker.dart';
import '../models/recipe.dart';


class RecipeDetails extends StatelessWidget{
  final Recipe recipe;
  RecipeDetails({Key? key, required this.recipe}) : super(key: key);

  @override

  Widget build(BuildContext context){

    return Scaffold(appBar: AppBar(
      title: Text(recipe.name),
      backgroundColor: Color(0xFFEE8B60),
      actions: [
        Padding(padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.camera_alt),
              onTap: () { Navigator.push(context, MaterialPageRoute(
                builder: (context) => PhotoPicker(),
              )); },
            ))
      ],
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            child: Text(recipe.name, style: TextStyle(fontSize: 50)),
            alignment: Alignment.center,

          ),
          Text('Pour ${recipe.guestsNumber} personne${recipe.guestsNumber > 1 ? 's' : ''}', style: TextStyle(fontSize: 15)),
          Text('Description : \n ${recipe.description}'),
          Image.network(
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80',
            width: MediaQuery.of(context).size.width/1.8,
            height: MediaQuery.of(context).size.width/1.8,
            fit: BoxFit.cover,
          ),
          Text('Prix : ${recipe.pricing}'),
          Text('Difficulté : ${recipe.difficulty}'),
        ],
      ),
    );
  }
}

