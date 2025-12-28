import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart'; // for PDF text extraction
import 'package:path/path.dart' as p;

class OcrScreen extends StatefulWidget {
  const OcrScreen({super.key});

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  String _extractedText = '';
  final ImagePicker _picker = ImagePicker();

  // 📸 Scan text from camera
  Future<void> _scanFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    await _processImage(image.path);
  }

  // 🖼️ Scan text from gallery
  Future<void> _scanFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    await _processImage(image.path);
  }

  // 📂 Upload and extract text from files
  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'txt', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final ext = p.extension(file.path).toLowerCase();

      if (ext == '.pdf') {
        final document = PdfDocument(inputBytes: await file.readAsBytes());
        String text = PdfTextExtractor(document).extractText();
        document.dispose();
        setState(() => _extractedText = text);
      } else if (ext == '.txt') {
        final text = await file.readAsString();
        setState(() => _extractedText = text);
      } else {
        // For Word docs, you’d typically use a package like `docx` parser
        setState(() => _extractedText = 'Word document selected: ${file.path}\n(Parsing logic to be added)');
      }
    }
  }

  // 🔎 Process image with ML Kit
  Future<void> _processImage(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    setState(() => _extractedText = recognizedText.text);
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Scanner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Action buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _scanFromCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _scanFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _uploadFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload File'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Extracted text area
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _extractedText.isEmpty
                        ? 'No text extracted yet.\nUse Camera, Gallery, or Upload File.'
                        : _extractedText,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
