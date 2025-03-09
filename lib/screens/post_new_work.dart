import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

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

  List<String> selectedFabrics = [];
  TextEditingController fabricController = TextEditingController();

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
          title: Text("Select Colors", style: GoogleFonts.poppins()),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              children: colors.map((color) {
                bool isSelected = selectedColors.contains(color);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected ? selectedColors.remove(color) : selectedColors.add(color);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 2),
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
              child: Text("Done", style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Title",
                  hintStyle: GoogleFonts.poppins(),
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
                        ? Center(child: Text("There is no image", style: GoogleFonts.poppins()))
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

              Text("Select Sizes:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              Wrap(
                spacing: 8.0,
                children: sizes.map((size) {
                  return ChoiceChip(
                    label: Text(size, style: GoogleFonts.poppins()),
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

              Text("Select Colors:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
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

              Text("Enter Fabric Type:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: fabricController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Type fabric name...",
                        hintStyle: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      String newFabric = fabricController.text.trim();
                      if (newFabric.isNotEmpty && !selectedFabrics.contains(newFabric)) {
                        setState(() {
                          selectedFabrics.add(newFabric);
                          fabricController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
              Wrap(
                children: selectedFabrics.map((fabric) {
                  return Chip(
                    label: Text(fabric, style: GoogleFonts.poppins()),
                    onDeleted: () {
                      setState(() {
                        selectedFabrics.remove(fabric);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              Text("Description:", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              TextField(
                controller: detailsController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write more details...",
                  hintStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Post", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
