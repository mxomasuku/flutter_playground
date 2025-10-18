import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> with WidgetsBindingObserver {
  final _picker = ImagePicker();
  File? _selectedImage;
  bool _recovering = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _recoverLostData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _recoverLostData() async {
    setState(() => _recovering = true);
    try {
      final LostDataResponse response = await _picker.retrieveLostData();
      if (response.isEmpty) return;

      File? recovered;
      if (response.files != null && response.files!.isNotEmpty) {
        recovered = File(response.files!.first.path);
      } else if (response.file != null) {
        recovered = File(response.file!.path);
      } else if (response.exception != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recover error: ${response.exception}')),
        );
      }

      if (recovered != null && mounted) {
        setState(() => _selectedImage = recovered);
        // ✅ notify parent
        widget.onPickImage(recovered);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recover exception: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() => _recovering = false);
    }
  }

  Future<void> _takePicture() async {
    try {
      final picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,     // 0–100 only
        maxWidth: 2048,
      );
      if (picked == null || !mounted) return;

      final file = File(picked.path);
      setState(() => _selectedImage = file);
      // ✅ notify parent
      widget.onPickImage(file);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _selectedImage == null
        ? TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Picture'),
          )
        : GestureDetector(
            onTap: _takePicture,
            child: Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: _recovering ? const CircularProgressIndicator() : content,
    );
  }
}