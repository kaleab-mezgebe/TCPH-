import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ViewNonMovableDataDetail extends StatefulWidget {
  final int id;

  const ViewNonMovableDataDetail({super.key, required this.id});

  @override
  _ViewNonMovableDataDetailState createState() =>
      _ViewNonMovableDataDetailState();
}

class _ViewNonMovableDataDetailState extends State<ViewNonMovableDataDetail> {
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataa = [];
  List<String> imageUrls = [];
  List<String> imageHeritageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataa();
    fetchImages();
    fetchHeritageImage();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/getnonMovableDataa?id=${widget.id}'));

      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
        print('Fetched data successfully: $data');
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchDataa() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/getNonMovableDataaa?id=${widget.id}'));
      if (response.statusCode == 200) {
        setState(() {
          dataa = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
        print('Fetched dataa successfully: $dataa');
      } else {
        print('Error fetching dataa: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching dataa: $e');
    }
  }

  Future<void> fetchHeritageImage() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/getNonMovHeritageImage?id=${widget.id}'));

      if (response.statusCode == 200) {
        setState(() {
          imageHeritageUrls = List<String>.from(jsonDecode(response.body));
        });
        print('Fetched heritage images: $imageHeritageUrls');
      } else {
        print('Error fetching heritage images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching heritage images: $e');
    }
  }

  Future<void> fetchImages() async {
    try {
      final response = await http.get(Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/getGalleryNonMovImages?id=${widget.id}'));

      if (response.statusCode == 200) {
        setState(() {
          imageUrls = List<String>.from(jsonDecode(response.body));
        });
        print('Fetched gallery images: $imageUrls');
      } else {
        print('Error fetching gallery images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching gallery images: $e');
    }
  }

  Future<void> _downloadPDF(BuildContext context) async {
    // Request storage permission
    if (await requestStoragePermission() != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied!')),
      );
      return;
    }

    final pdf = pw.Document();

    // Load the custom font
    final fontData =
        await rootBundle.load('assets/fonts/AbyssinicaSIL-Regular.ttf');
    final customFont = pw.Font.ttf(fontData);

    Directory? dir;
    if (Platform.isAndroid) {
      // Set the path for saving the PDF
      dir = Directory('/storage/emulated/0/Download/TCPH.NonMovableHeritages');
    } else if (Platform.isIOS) {
      // iOS Implementation; save it alternatively.
      dir = await getApplicationDocumentsDirectory();
    }

    // Create the Downloads folder if it doesn't exist
    if (await dir!.exists() == false) {
      await dir.create(recursive: true);
    }
    final imageList = <pw.MemoryImage>[];
    final imageHeritageList = <pw.MemoryImage>[];

    // Load images into MemoryImage format
    // for (String imageUrl in imageUrls) {
    //   final response = await http.get(Uri.parse(imageUrl));
    //   if (response.statusCode == 200) {
    //     imageList.add(pw.MemoryImage(response.bodyBytes));
    //   } else {
    //     print(
    //         'Error fetching image: ${response.statusCode} for URL: $imageUrl');
    //   }
    // }

    print('Image URL Count: ${imageUrls.length}');
    print('Image URLs: $imageUrls');

    // Load images into MemoryImage format
    for (String imageUrl in imageUrls) {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        imageList.add(pw.MemoryImage(response.bodyBytes));
      } else {
        print(
            'Error fetching image: ${response.statusCode} for URL: $imageUrl');
      }
    }

    // Retrieve captions
    List<String> captions = dataa.isNotEmpty
        ? dataa[0]['caption_for_image_of_heritages'].split('፣')
        : [];
    // Load images into MemoryImage format
    for (String imageUrl in imageHeritageUrls) {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        imageHeritageList.add(pw.MemoryImage(response.bodyBytes));
      } else {
        print(
            'Error fetching image: ${response.statusCode} for URL: $imageUrl');
      }
    }

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          List<pw.Widget> content = [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.SizedBox(), // Empty container on the left side
                ),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'ምስሊ ናይቲ ሓድጊ',
                        style: pw.TextStyle(
                          font: customFont,
                          fontSize: 12, // Decrease the font size
                          // Set the font style to italic
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      // Add images in a grid-like format
                      pw.Wrap(
                        spacing: 4, // Space between images
                        runSpacing: 4, // Space between rows
                        children: imageHeritageList.map((image) {
                          return pw.Container(
                            width: 175, // Adjust size as needed
                            height: 175, // Adjust size as needed
                            child: pw.Image(image),
                          );
                        }).toList(),
                      ),
                      // pw.SizedBox(height: 4),
                      pw.Text(
                        dataa[0]['caption_for_image_of_heritage'],
                        style: pw.TextStyle(
                          font: customFont,
                          fontSize: 12, // Decrease the font size
                          fontStyle: pw
                              .FontStyle.italic, // Set the font style to italic
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // pw.SizedBox(height: 20),
            // Title for data information
            pw.Expanded(
              child: pw.Text(
                'ዝርዝር ሓበሬታ ዘይንቀሳቐስ ሓድጊ',
                style: pw.TextStyle(
                  font: customFont,
                  fontSize: 16, // Increase the font size
                  decoration: pw.TextDecoration.underline, // Add the underline
                ),
              ),
            ),

            // Table with fetched data
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: const pw.FixedColumnWidth(250),
                1: const pw.FlexColumnWidth(),
              },
              children: data
                  .expand((row) => row.entries.map((entry) {
                        return pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                entry.key,
                                style: pw.TextStyle(font: customFont),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                entry.value.toString(),
                                style: pw.TextStyle(font: customFont),
                              ),
                            ),
                          ],
                        );
                      }))
                  .toList(),
            ),

            pw.SizedBox(height: 20),
            // Title for data information
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ማህደር ምስልታት',
                    style: pw.TextStyle(font: customFont, fontSize: 16),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),

            // Add images in a grid-like format
            // pw.Wrap(
            //   spacing: 4, // Space between images
            //   runSpacing: 4, // Space between rows
            //   children: imageList.map((image) {
            //     return pw.Container(
            //       width: 175, // Adjust size as needed
            //       height: 175, // Adjust size as needed
            //       child: pw.Image(image),
            //     );
            //   }).toList(),
            // ),

            // Add images in a grid-like format with captions
            pw.Wrap(
              spacing: 4, // Space between images
              runSpacing: 4, // Space between rows
              children: List<pw.Widget>.generate(imageList.length, (index) {
                return pw.Column(
                  children: [
                    pw.Container(
                      width: 150, // Adjust size as needed
                      height: 150, // Adjust size as needed
                      child: pw.Image(imageList[index]),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      index < captions.length ? captions[index] : '',
                      style: pw.TextStyle(font: customFont),
                      textAlign: pw.TextAlign.center,
                    ),
                  ],
                );
              }),
            ),

            pw.SizedBox(height: 50),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ሽምን ፌርማን ሓላዊ እቲ ሓድጊ/ሓድጊ ቦታ',
                    style: pw.TextStyle(
                      font: customFont,
                      fontSize: 16, // Increase the font size
                      decoration:
                          pw.TextDecoration.underline, // Add the underline
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ሽም: ______________________________________',
                    style: pw.TextStyle(font: customFont),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ፌርማ:______________________________________',
                    style: pw.TextStyle(font: customFont),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 50),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ሽምን ፌርማን መረዳእታ ኣካቢ እቲ ትካል',
                    style: pw.TextStyle(
                      font: customFont,
                      fontSize: 16, // Increase the font size
                      decoration:
                          pw.TextDecoration.underline, // Add the underline
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ሽም: ______________________________________',
                    style: pw.TextStyle(font: customFont),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ፌርማ:______________________________________',
                    style: pw.TextStyle(font: customFont),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    '\nበቲ ዝመዝገበ ትካል ዝምላእ',
                    style: pw.TextStyle(
                      font: customFont,
                      fontSize: 16, // Increase the font size
                      decoration:
                          pw.TextDecoration.underline, // Add the underline
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ርኢቶ ብናይቲ ትካል ሓላፊ፥ ________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________',
                    style: pw.TextStyle(font: customFont),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ሽም: ______________________________________',
                    style: pw.TextStyle(font: customFont),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Text(
                    'ፌርማ:______________________________________',
                    style: pw.TextStyle(font: customFont),
                  ),
                ),
              ],
            ),
          ];

          return content;
        },
      ),
    );
    final String path =
        '${dir.path}/Non_movable_data_${widget.id}.pdf'; // Note the added .pdf extension
    File file;

    // Check if the file exists
    if (await fileExists(path)) {
      // Show a dialog to ask if the user wants to replace the file
      bool? shouldReplace = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('እቲ ፋይል ወሪዱ እዩ'),
          content: const Text('እቲ ፋይል ክትክእዎ ትደልዩ ዶ?'),
          actions: [
            TextButton(
              child: const Text('እወ'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('ኣይደልን'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      );

      if (!shouldReplace!) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File not replaced')),
        );
        return;
      }
    }

    file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Notify user of success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF ወሪዱ ኣሎ')),
    );
  }

  Future<bool> fileExists(String path) async {
    try {
      final file = File(path);
      return file.existsSync();
    } catch (e) {
      return false;
    }
  }

  Future<PermissionStatus> requestStoragePermission() async {
    // Check current status
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      // Request permission
      status = await Permission.storage.request();
    }
    return status;
  }

  Widget buildImageGallery() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        List<String> captions = dataa.isNotEmpty
            ? dataa[0]['caption_for_image_of_heritages'].split('፣')
            : [];

        return GestureDetector(
          onTap: () {
            if (imageUrls.isNotEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      FullscreenImage(imageUrl: imageUrls[index]),
                ),
              );
            }
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    index < captions.length ? captions[index] : '',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget buildImageGalleryy() {
    if (imageHeritageUrls.isNotEmpty) {
      return Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'ምስሊ ናይቲ ሓድጊ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    if (imageHeritageUrls.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              FullscreenImage(imageUrl: imageHeritageUrls[0]),
                        ),
                      );
                    }
                  },
                  child: Card(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        imageHeritageUrls[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (dataa.isNotEmpty)
                  Text(
                    dataa[0]['caption_for_image_of_heritage'],
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 16),
                  ),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ዘይንቐሳቐስ ሓድጊ'),
        backgroundColor: Colors.blue,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.download),
        //     onPressed: _downloadPDF,
        //   ),
        // ],

        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadPDF(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildImageGalleryy(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final row = data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.grey, width: 1),
                    columnWidths: const {
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                    },
                    children: row.entries.map((entry) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(entry.key),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(entry.value.toString()),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ማህደር ስእልታት',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildImageGallery(),
          ],
        ),
      ),
    );
  }
}

class FullscreenImage extends StatelessWidget {
  final String imageUrl;

  const FullscreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text('ሙሉእ ምስሊ እቲ ሓድጊ', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
