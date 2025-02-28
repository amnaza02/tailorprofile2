import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;

  List<String> sizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  List<String> selectedSizes = [];

  List<Color> colors = Colors.primaries;
  List<Color> selectedColors = [];

  List<String> fabrics = ['Cotton', 'Silk', 'Denim', 'Linen', 'Wool', 'Polyester'];
  List<String> selectedFabrics = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  void showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Colors"),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              children: colors.map((color) {
                bool isSelected = selectedColors.contains(color);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedColors.remove(color);
                      } else {
                        selectedColors.add(color);
                      }
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Title",
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: _imageBytes == null
                        ? const Center(child: Text("There is no image"))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              _imageBytes!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_library, size: 30, color: Colors.purpleAccent),
                    onPressed: pickImage,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text("Select Sizes:"),
              Wrap(
                spacing: 8.0,
                children: sizes.map((size) {
                  return ChoiceChip(
                    label: Text(size),
                    selected: selectedSizes.contains(size),
                    onSelected: (selected) {
                      setState(() {
                        selected ? selectedSizes.add(size) : selectedSizes.remove(size);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              const Text("Select Colors:"),
              Wrap(
                spacing: 8.0,
                children: selectedColors.map((color) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  );
                }).toList(),
              ),
              IconButton(
                icon: const Icon(Icons.color_lens),
                onPressed: showColorPicker,
              ),
              const SizedBox(height: 20),

              const Text("Select Fabric:"),
              DropdownButtonFormField<String>(
                hint: const Text("Choose a fabric"),
                isExpanded: true,
                items: fabrics.map((String fabric) {
                  return DropdownMenuItem<String>(
                    value: fabric,
                    child: Text(fabric),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null && !selectedFabrics.contains(newValue)) {
                    setState(() {
                      selectedFabrics.add(newValue);
                    });
                  }
                },
              ),
              Wrap(
                children: selectedFabrics.map((fabric) {
                  return Chip(
                    label: Text(fabric),
                    onDeleted: () {
                      setState(() {
                        selectedFabrics.remove(fabric);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              const Text("Description:"),
              TextField(
                controller: detailsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write more details...",
                ),
              ),
              const SizedBox(height: 20),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Post"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
