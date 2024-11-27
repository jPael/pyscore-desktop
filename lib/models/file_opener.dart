import 'dart:io';

class FileOpener {
  String? fileDirectory;

  setFileDirectory(String path) {
    fileDirectory = path;
  }

  Future<String> readFileDataAsString() async {
    try {
      if (fileDirectory == null) {
        return "Error: No file were selected";
      }

      final file = File(fileDirectory!);

      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return "There was an error opening the file";
    }
  }

  String get getFileName => fileDirectory!.split(Platform.pathSeparator).last;
  // String get getFileName() {
  // return fileDirectory.split(Platform.pathSeparator).last;
  // }
}
