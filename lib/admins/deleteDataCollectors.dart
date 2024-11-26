// delete_logic.dart

import 'package:http/http.dart' as http;

Future<void> deleteDataCollectors(String? username, String? deletedby) async {
  try {
    final response = await http.delete(
      Uri.parse(
          'https://repositoryformymobapp-kaleab-mezgebe.onrender.com/deleteDataCollector/$username/$deletedby'),
    );

    if (response.statusCode == 200) {
      print('Data deleted successfully');
    } else {
      print('Error deleting data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error deleting data: $e');
  }
}
