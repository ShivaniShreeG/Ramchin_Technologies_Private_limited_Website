import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/upload_service.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Uint8List? selectedFileBytes;
  String? fileName;
  final categoryController = TextEditingController();
  bool loading = false;

  String sanitizeCategory(String category) {
    String safe = category.replaceAll("'", "").replaceAll('"', '');
    safe = safe.replaceAll(' ', '_'); // replace spaces with underscores
    return safe;
  }


  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true, // IMPORTANT
    );

    if (result != null) {
      setState(() {
        selectedFileBytes = result.files.single.bytes;
        fileName = result.files.single.name;
      });
    }
  }

  Future<void> upload() async {
    if (selectedFileBytes == null || categoryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File & category required')),
      );
      return;
    }

    setState(() => loading = true);

    try {
      // Sanitize the category before sending
      final safeCategory = sanitizeCategory(categoryController.text);

      await UploadService.uploadFile(
        fileBytes: selectedFileBytes!,
        fileName: fileName!,
        category: safeCategory,  // ✅ sanitized
      );
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Upload')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: pickFile,
              child: const Text('Pick File'),
            ),

            if (fileName != null) Text(fileName!),

            const SizedBox(height: 16),

            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: upload,
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
