import 'dart:io';
import 'package:file_picker/file_picker.dart';

abstract class MyFilePicker{
  static PlatformFile? file;

  static Future<File?> pickImage() async {
    File? pickedFile;
    file = null;
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    file = result?.files.first;
    if (result != null) {
      pickedFile = File(result.files.single.path!);
    }
    return pickedFile;
  }
}