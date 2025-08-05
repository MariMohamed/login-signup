import 'package:image_picker/image_picker.dart';

Future<XFile> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    return XFile(pickedFile.path);
  } else {
    throw Exception('No image selected');
  }
}
