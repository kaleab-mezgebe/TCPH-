// delete_logic.dart

import 'package:http/http.dart' as http;

Future<void> deleteMovableData(int id) async {
  try {
    final response = await http.delete(
      Uri.parse('https://repositoryformymobapp-kaleab-mezgebe.onrender.com/movableData/$id'),
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
