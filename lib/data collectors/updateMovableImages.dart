import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'addMovableImages.dart';
// Import the updateimages.dart file

class ImageGalleryPage extends StatefulWidget {
  final int id;
  const ImageGalleryPage({super.key, required this.id});

  @override
  _ImageGalleryPageState createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  List<String> imagePaths = [];
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    print('ID: ${widget.id}');

    fetchImagePaths();
  }

  Future<void> fetchImagePaths() async {
    setState(() {
      _isFetching = true;
    });

    final response = await http.get(Uri.parse(
        'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/api/images?id=${widget.id}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        imagePaths = List<String>.from(data['imagePaths']);
        _isFetching = false;
      });
    } else {
      setState(() {
        _isFetching = false;
      });
      throw Exception('Failed to fetch image paths');
    }
  }

  Future<void> deleteImage(String filename) async {
    final response = await http.delete(
      Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/api/images/$filename?id=${widget.id}'),
    );
    if (response.statusCode == 200) {
      setState(() {
        imagePaths.remove(filename);
      });
    } else {
      throw Exception('Failed to delete image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ናይቲ ሓድጊ ምስሊታት'),
        backgroundColor: Colors.blue, // Set the background color to

        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddImages(
                    id: widget.id,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _isFetching
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 2 : 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                  children: List.generate(imagePaths.length, (index) {
                    final imagePath = imagePaths[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FullImagePage(imagePath: imagePath),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          imagePath.isEmpty
                              ? const Center(child: Text('No Images Found'))
                              : Stack(
                                  children: [
                                    Image.network(
                                      'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/api/images/$imagePath',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Text('Image Not Found'),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      top: 16,
                                      right: 16,
                                      child: IconButton(
                                        icon: const Icon(
                                            Icons.remove_circle_outline),
                                        color: Colors.red,
                                        onPressed: () async {
                                          await deleteImage(imagePath);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
      ),
    );
  }
}

class FullImagePage extends StatelessWidget {
  final String imagePath;

  const FullImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ሙሉእ ምስሊ'),
      ),
      body: Center(
        child: Image.network(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/api/images/$imagePath',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Text('ምስሊ የብሉን');
          },
        ),
      ),
    );
  }
}
