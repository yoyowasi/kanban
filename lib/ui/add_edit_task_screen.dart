import 'package:flutter/material.dart';
import 'package:kanban/enums/kanban_status.dart';
import 'package:kanban/models/kanban_item.dart';
import 'package:kanban/providers/kanban_provider.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddEditTaskScreen extends StatefulWidget {
  final KanbanStatus status;
  final KanbanItem? item;

  const AddEditTaskScreen({
    super.key,
    required this.status,
    this.item,
  });

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool _isTitleEmpty = true;

  bool get _isEditMode => widget.item != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.item?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
    _isTitleEmpty = _titleController.text.isEmpty;
    _titleController.addListener(() {
      if (mounted) {
        setState(() {
          _isTitleEmpty = _titleController.text.isEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    final provider = context.read<KanbanProvider>();
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (_isEditMode) {
      provider.updateItem(widget.item!.id, title, description);
    } else {
      provider.addItem(widget.status, title, description);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final String action = _isEditMode ? '수정' : '추가하기';
    String statusLabel = widget.status.label.replaceAll('-', '');
    final String screenTitle = '$statusLabel $action';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(screenTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        leading: ShadButton.ghost(
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(LucideIcons.arrowLeft, size: 28),
        ),
      ),
      // 하단 버튼을 ElevatedButton으로 교체하고 스타일 직접 지정
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _isTitleEmpty ? null : _onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008080),
              disabledBackgroundColor: Colors.grey.shade400,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isEditMode)
                  const Icon(
                    LucideIcons.plus,
                    color: Colors.white,
                    size: 20,
                  ),
                if (!_isEditMode) const SizedBox(width: 8),
                Text(
                  _isEditMode ? '수정하기' : '추가하기',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '타이틀',
              style: TextStyle(color: Colors.purple, fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.purple, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                suffixIcon: _titleController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () => _titleController.clear(),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '내용',
              style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextFormField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.purple, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}