import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spot_memo/domain/mappers/memo_mapper.dart';
import 'package:spot_memo/l10n/generated/l10n/app_localizations.dart';
import 'package:spot_memo/presentation/features/add_memo/logic/add_memo_provider.dart';
import 'package:spot_memo/presentation/features/add_memo/logic/add_memo_state.dart';
import 'package:spot_memo/presentation/shared_widgets/location_selector.dart';

class AddMemoScreen extends ConsumerStatefulWidget {
  const AddMemoScreen({super.key});

  @override
  ConsumerState<AddMemoScreen> createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends ConsumerState<AddMemoScreen> {
  final _imagePicker = ImagePicker();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickAndCropImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (!mounted || croppedImage == null) return;

    final documentsDirectory = await getApplicationDocumentsDirectory();

    final imagesDirectory = Directory('${documentsDirectory.path}/memo_images');

    if (!await imagesDirectory.exists()) {
      await imagesDirectory.create(recursive: true);
    }

    final fileName = 'memo_${DateTime.now().microsecondsSinceEpoch}.jpg';

    final permanentPath = '${imagesDirectory.path}/$fileName';

    await File(croppedImage.path).copy(permanentPath);

    if (!mounted) return;

    ref.read(addMemoProvider.notifier).changeImagePath(permanentPath);
  }

  @override
  Widget build(BuildContext context) {
    final addMemoState = ref.watch(addMemoProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [IconButton(icon: const Icon(Icons.arrow_back_outlined), onPressed: () => context.pop())],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    InkWell(
                      onTap: _pickAndCropImage,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                          child: addMemoState.imagePath == null
                              ? Center(child: Text(AppLocalizations.of(context).addImage))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(File(addMemoState.imagePath!), fit: BoxFit.cover),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context).title),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context).description),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      maxLength: 500,
                    ),
                    const SizedBox(height: 16),
                    LocationSelector(
                      selectedLocation: MemoMapper.convertAddMemoLocationStateToGeoPoint(addMemoState.location),
                      onLocationChanged: (lat, lon) => ref.read(addMemoProvider.notifier).changeLocation(lat, lon),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                addMemoState.status.map(
                  idle: (_) => SizedBox(),
                  loading: (_) => CircularProgressIndicator(),
                  error: (value) => Text(value.error),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(addMemoProvider.notifier).changeTitle(_titleController.text);
                        ref.read(addMemoProvider.notifier).changeDesc(_descriptionController.text);
                        ref.read(addMemoProvider.notifier).saveMemo(AppLocalizations.of(context));
                      },
                      child: Text(AppLocalizations.of(context).save),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
