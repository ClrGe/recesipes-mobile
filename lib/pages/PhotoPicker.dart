import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class PhotoPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PhotoPickerState();
  }
}

class PhotoPickerState extends State<PhotoPicker> {
  File? _image;

  Future chooseImgSource() async{
    showDialog(context: context, builder: (BuildContext context){
      return ImgSourcePopup(context);
    });
  }

  Widget ImgSourcePopup(BuildContext context){
    return AlertDialog(
      title: const Text('Choisir une source'),
      content: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  <Widget>[
            TextButton(
              onPressed: () {
                getImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Text("Appareil Photo", style: TextStyle(color: Color(0xFFEE8B60)),),
            ),
            TextButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                  },
                child: Text("Gallerie", style: TextStyle(color: Color(0xFFEE8B60)),)),
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource imgSource) async {
    var image = await ImagePicker().pickImage(source: imgSource);

    setState(() {
      _image = File(image!.path);;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Choisir une image'),
          backgroundColor: Color(0xFFEE8B60),
      ),
      body: new Center(
        child: _image == null
            ? new Text('Aucune image sélectionnée')
            : new Image.file(_image!),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Color(0xFFEE8B60),
        onPressed: chooseImgSource,
        tooltip: 'Choisir une image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}