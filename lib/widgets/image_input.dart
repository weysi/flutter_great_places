import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'dart:io';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput({
    required this.onSelectImage,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    print('File Name : ' + fileName + ' Appdir' + appDir.path);
    File imagePathFile = File('${appDir.path}/${fileName}');
    await imageFile.saveTo(imagePathFile.path);
    // String saveCoordinating = appDir.path + '/' + fileName;
    widget.onSelectImage(imagePathFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            onPressed: _takePicture,
            label: Text('Take Picture'),
            style: TextButton.styleFrom(
                textStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        )
      ],
    );
  }
}
