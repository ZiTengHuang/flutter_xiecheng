import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class FlutterPhoto extends StatefulWidget{
    _FlutterPhotoState createState()=> _FlutterPhotoState();
}

class _FlutterPhotoState extends State<FlutterPhoto>{
  List<File> _images= [];

  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(source: isTakePhoto ? ImageSource.camera :ImageSource.gallery);

    setState(() {
      _images.add(image);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
         child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: _getImages(),
         ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void _pickImage() {
    showModalBottomSheet(context: context, builder: (context) =>Container(
           height: 160,
           child: Column(
             children: <Widget>[
               _item('拍照',true),
               _item('从相册选择',false),
             ],
           ),
    ));
  }

  _item(String s, bool isTakePhoto) {
      return GestureDetector(
          child: ListTile(
              leading: Icon(isTakePhoto?Icons.camera_alt:Icons.photo),
              title: Text(s),
              onTap: ()=>getImage(isTakePhoto),
          ),
      );
  }

  _getImages() {
    return _images.map((file){
         return Stack(
            children: <Widget>[
               ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.file(file,width: 120,height: 90,fit: BoxFit.fill,),
               ),
               Positioned(
                  top: 5,
                  right: 6,
                  child: GestureDetector(
                      onTap: (){
                        setState(() {
                            _images.remove(file);
                        });
                      },
                    child: ClipOval(
                       child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                          ),
                          child: Icon(Icons.close,color: Colors.white,),
                       ),
                    ),
                  ),
               ),
            ],
         );
     }).toList();
  }
}

 