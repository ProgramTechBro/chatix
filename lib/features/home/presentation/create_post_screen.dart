import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import '../../../core/shared_widgets/app_button.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  XFile? _pickedImage;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    setState(() => _pickedImage = picked);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pickedImage = _pickedImage;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text('Create post', style: textTheme.titleSmall),
                  const Align(alignment: Alignment.centerLeft, child: AppBackButton()),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(radius: 25, backgroundImage: NetworkImage(AppNetworkImages.currentUserAvatar)),
                        const SizedBox(width: 8),
                        Text('Jack miller', style: textTheme.titleSmall),
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _captionController,
                      maxLines: null,
                      style: textTheme.labelLarge?.copyWith(color: AppColors.black),
                      decoration: InputDecoration(
                        hintText: 'Write a post...',
                        hintStyle: textTheme.titleSmall?.copyWith(color: AppColors.textSecondary),
                        filled: false,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (pickedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(pickedImage.path),
                          width: double.infinity,
                          height: 296,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 192,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.textSecondary),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
                                child: const Icon(Icons.upload_rounded, size: 24, color: AppColors.textSecondary),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Upload photos',
                                style: textTheme.labelMedium?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (pickedImage != null) ...[
                      const SizedBox(height: 16),
                      FutureBuilder<int>(
                        future: pickedImage.length(),
                        builder: (context, snapshot) {
                          final sizeMb = (snapshot.data ?? 0) / (1024 * 1024);
                          return Text(
                            'Estimated file size: ${sizeMb.toStringAsFixed(1)} MB (1 file)',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: AppButton(label: 'Post', onPressed: () => Navigator.of(context).pop()),
            ),
          ],
        ),
      ),
    );
  }
}
