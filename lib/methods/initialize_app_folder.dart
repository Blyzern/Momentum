import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  String folderName = "Momentum";

  // Create the folder if it doesn't exist
  Directory newDirectory = Directory('${directory.path}/$folderName');

  if (!(await newDirectory.exists())) {
    await newDirectory.create(recursive: true);
    return newDirectory.path;
  } else {
    return newDirectory.path;
  }
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/toDo.txt');
}

Future<File> writeToDo(List<Map<String, dynamic>> toDo) async {
  String jsonString = jsonEncode(toDo);
  final file = await _localFile;
  // Write the file
  return file.writeAsString(jsonString);
}

Future<List<Map<String, dynamic>>> readToDo() async {
  try {
    final file = await _localFile;
    // Read the file
    final contentsJson = await file.readAsString();
    List<dynamic> partiallyDecodedList = jsonDecode(contentsJson);

    List<Map<String, dynamic>> decodedList =
        List<Map<String, dynamic>>.from(partiallyDecodedList);

    return decodedList;
  } catch (e) {
    return [];
  }
}
