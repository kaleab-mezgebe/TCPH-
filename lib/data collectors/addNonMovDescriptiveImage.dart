import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

class AddDescriptiveImage extends StatefulWidget {
  // const AddSignatureImage({super.key});
  final int id;
  const AddDescriptiveImage({super.key, required this.id});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<AddDescriptiveImage> {
  final _formKey = GlobalKey<FormState>();

  List<XFile>? _imagesOfheritagePath;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImages() async {
    List<XFile> pickedImages = await _imagePicker.pickMultiImage();

    setState(() {
      _imagesOfheritagePath = pickedImages;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (_imagesOfheritagePath == null) {
          _imagesOfheritagePath = [pickedFile];
        } else {
          _imagesOfheritagePath!.add(pickedFile);
        }
      });
    }
  }

  Future<void> _registerUser() async {
    // Perform any additional form validation here
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final url =
        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/updateImageNonMovSignature/?id=${widget.id}'; // Replace with your API endpoint
    try {
      final dio = Dio();
      final formData = FormData();

      if (_imagesOfheritagePath != null) {
        for (var image in _imagesOfheritagePath!) {
          formData.files.add(MapEntry(
            'imageOfHeritage',
            MultipartFile.fromBytes(await image.readAsBytes(),
                filename: basename(image.path)),
          ));
        }
      }

      final response = await dio.put(url, data: formData);

      if (response.statusCode == 200) {
        // Registration successful
        print('User registered successfully');

        // Clear the selected images
        setState(() {
          _imagesOfheritagePath = null;
        });
      } else {
        // Registration failed
        print('Failed to register user');
      }
    } catch (error) {
      // Error occurred
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('መስፈሪ ስእሊ ሓድጊ'),
        backgroundColor: Colors.blue, // Set the background color to blue
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('\nስእሊ ናይቲ ሓድጊ ካሜራ ብምልዓል ወይ ድማ ካብ ፋይል ብምምራፅ ኣስፍሩ'),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_camera),
                      ],
                    ),
                  ),
                ),
                const Text('\n'),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: const Icon(Icons.folder),
                ),
                if (_imagesOfheritagePath != null)
                  Wrap(
                    spacing: 8,
                    children: [
                      for (var i = 0; i < _imagesOfheritagePath!.length; i++)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.file(
                                File(_imagesOfheritagePath![i].path)),
                          ),
                        ),
                    ],
                  ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _registerUser();
                    }
                  },
                  child: const Text('ኣስፍር'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
