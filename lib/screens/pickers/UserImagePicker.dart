import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {

  final void Function(XFile pickedImage) Imagepickfn;
  const UserImagePicker(this.Imagepickfn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  var _pickedImage = null;
  final ImagePicker _picker = ImagePicker();


void _pickImage(ImageSource src)async{
 final XFile _pickImageFile = await _picker.pickImage(source: src, imageQuality: 50, maxWidth: 150) as XFile;
 if(_pickImageFile != null){
   setState(() {
     _pickedImage = File(_pickImageFile.path);
   });
   widget.Imagepickfn(_pickImageFile);
 }else{
   print('No image Selected');
 }
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null? FileImage(_pickedImage):null,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(onPressed: ()=>_pickImage(ImageSource.camera) ,
             icon: const Icon(Icons.photo_camera_back_outlined),
              label:  Text('Add Image\n from camera',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              ),
              textAlign: TextAlign.center,
              )
              ),
              SizedBox(width: 10,),
              TextButton.icon(onPressed: ()=>_pickImage(ImageSource.gallery) ,
             icon: const Icon(Icons.image_outlined),
              label:  Text('Add Image\n from gallery',
              style: TextStyle(
                color: Theme.of(context).primaryColor
              ),
              textAlign: TextAlign.center,
              )
              )
          ],
        )
      ],
    );
  }
}