import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ramchin_web/utils/utils.dart';

class UploadService {
  static Future<String?> uploadFile({
    required List<int> fileBytes,
    required String fileName,
    required String category,
  }) async {
    final uri = Uri.parse('${Utils.baseUrl}/upload');

    final request = http.MultipartRequest('POST', uri);

    request.fields['category'] = category;

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );

    final response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      return 'Upload success';
    } else {
      final body = await response.stream.bytesToString();
      throw Exception(body);
    }
  }
}
