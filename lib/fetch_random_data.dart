import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FetchData {
  static Future<Map> fetchRandomData() async {
    try {
      const url = 'http://41.216.186.97:5000/req/random';

      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return {
        'error': jsonResponse['error'],
        'items': jsonResponse['items'],
      };
    } on SocketException catch (e) {
      return {'error': true};
    }
  }

  static Future<Map> fetchNewsData(int pages) async {
    try {
      final url = 'http://41.216.186.97:5000/xxx/news?pages=$pages';

      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return {
        'error': jsonResponse['error'],
        'items': jsonResponse['items'],
      };
    } on SocketException catch (e) {
      return {'error': true};
    }
  }
}
