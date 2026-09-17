import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:HAPPYPETS/services/pet_upload_store.dart';
import 'package:HAPPYPETS/widgets/pet_bottom_navigation.dart';

class UploadsScreen extends StatefulWidget {
  const UploadsScreen({super.key});
  @override
  State<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends State<UploadsScreen> {
  List<PetUpload> _uploads = [];
  bool _loading = true;
  bool _saving = false;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadFailed = false;
    });
    try {
      final uploads = await PetUploadStore.load();
      if (mounted) setState(() => _uploads = uploads);
    } catch (_) {
      if (mounted) setState(() => _loadFailed = true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pick(bool photo) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: photo
            ? ['jpg', 'jpeg', 'png', 'webp']
            : ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
        withData: true,
      );
      if (result == null || !mounted) return;
      final additions = <PetUpload>[];
      for (final file in result.files) {
        if (file.bytes == null || file.bytes!.isEmpty) {
          throw StateError('Could not read ${file.name}');
        }
        if (file.size > 10 * 1024 * 1024) {
          throw StateError('Please select files smaller than 10 MB');
        }
        additions.add(
            PetUpload(name: file.name, isPhoto: photo, bytes: file.bytes!));
      }
      final updated = [..._uploads, ...additions];
      await PetUploadStore.save(updated);
      if (!mounted) return;
      setState(() => _uploads = updated);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Files saved successfully.')));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unable to upload: $error')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Widget _section(String title, bool photos) {
    final items = _uploads.where((item) => item.isPhoto == photos).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        if (items.isEmpty)
          Text(photos ? 'No extra photos yet.' : 'No reports uploaded yet.'),
        ...items.map((item) => Card(
              child: photos
                  ? Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(item.bytes,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const SizedBox(
                                height: 120,
                                child: Center(
                                    child: Text('Photo preview unavailable')))),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(item.name)),
                    ])
                  : ListTile(
                      leading: const Icon(Icons.description_outlined,
                          color: Colors.blue),
                      title: Text(item.name),
                      subtitle: Text(
                          '${(item.bytes.length / 1024).toStringAsFixed(1)} KB • Saved on this device'),
                    ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet photos & reports')),
      bottomNavigationBar: const PetBottomNavigation(currentIndex: 1),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _loadFailed
              ? Center(
                  child: TextButton(
                      onPressed: _load,
                      child: const Text('Could not load uploads. Retry')))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                      child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                              'Add more photos and keep your pet’s reports together. Files are saved on this device.'),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                              onPressed: _saving ? null : () => _pick(true),
                              icon: const Icon(
                                  Icons.add_photo_alternate_outlined),
                              label: const Text('Add photos')),
                          const SizedBox(height: 8),
                          OutlinedButton.icon(
                              onPressed: _saving ? null : () => _pick(false),
                              icon: const Icon(Icons.upload_file),
                              label: const Text('Upload reports')),
                          const Text(
                              'Photos: JPG, PNG, WebP. Reports: PDF, JPG, PNG. Up to 10 MB per file.',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54)),
                          if (_saving)
                            const Padding(
                                padding: EdgeInsets.all(16),
                                child:
                                    Center(child: CircularProgressIndicator())),
                          const SizedBox(height: 24),
                          _section('Photos', true),
                          const SizedBox(height: 24),
                          _section('Reports', false),
                        ]),
                  )),
                ),
    );
  }
}
