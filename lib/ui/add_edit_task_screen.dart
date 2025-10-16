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
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (_isEditMode) {
      provider.updateItem(widget.item!.id, title, description);
    } else {
      provider.addItem(widget.status, title, description);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final String action = _isEditMode ? '수정하기' : '추가하기';
    String statusLabel = widget.status.label.replaceAll('-', '');
    final String screenTitle = '$statusLabel $action';

    const labelStyle = TextStyle(
      color: Colors.purple,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        leadingWidth: 56,
        leading: IconButton(
          tooltip: '뒤로가기',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(LucideIcons.arrowLeft, size: 24),
        ),
        title: Text(
          screenTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          children: [
            const Text('타이틀', style: labelStyle),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: false,
                border: outlineBorder,
                enabledBorder: outlineBorder,
                focusedBorder: outlineBorder.copyWith(
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                // ✅ 추가하기 화면일 때만 지우기 버튼 표시
                suffixIcon: (!_isEditMode && _titleController.text.isNotEmpty)
                    ? IconButton(
                        tooltip: '지우기',
                        onPressed: () => _titleController.clear(),
                        icon: const Icon(LucideIcons.x),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            const Text('내용', style: labelStyle),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              minLines: 16,
              maxLines: null,
              decoration: InputDecoration(
                filled: false,
                border: outlineBorder,
                enabledBorder: outlineBorder,
                focusedBorder: outlineBorder.copyWith(
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 2),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(
          120, // 좌우 여백을 늘려 버튼 크기 조절
          8,
          120, // 좌우 여백을 늘려 버튼 크기 조절
          48 + MediaUtils.viewInsetsBottom(context),
        ),
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isTitleEmpty ? null : _onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008080),
              disabledBackgroundColor: Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isEditMode ? LucideIcons.pencil : LucideIcons.plus,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  _isEditMode ? '수정하기' : '추가하기',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MediaUtils {
  static double viewInsetsBottom(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom;
}