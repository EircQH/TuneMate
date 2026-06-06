import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/note_utils.dart';

class FretboardGrid extends StatefulWidget {
  final List<List<String>> notes;
  final bool compact;

  const FretboardGrid({super.key, required this.notes, this.compact = false});

  @override
  State<FretboardGrid> createState() => _FretboardGridState();
}

class _FretboardGridState extends State<FretboardGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      // 把鼠标滚轮的垂直滚动转为横向滚动
      final delta = event.scrollDelta.dy;
      _scrollController.jumpTo(
        (_scrollController.offset + delta).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.notes.isEmpty) return const SizedBox();

    final fretCount = widget.notes[0].length;
    final compact = widget.compact;
    final padding = compact ? 8.0 : 16.0;
    final cellHeight = compact ? 28.0 : 36.0;
    final cellWidth = compact ? 40.0 : 44.0;
    final noteBoxSize = compact ? 22.0 : 28.0;
    final noteFontSize = compact ? 10.0 : 11.0;
    final labelWidth = compact ? 32.0 : 40.0;

    return Listener(
      onPointerSignal: _onPointerSignal,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 品号标题行
              Row(
                children: [
                  SizedBox(width: labelWidth),
                  ...List.generate(fretCount, (fret) {
                    return SizedBox(
                      width: cellWidth,
                      child: Center(
                        child: Text(
                          fret == 0 ? '空' : '$fret',
                          style: TextStyle(
                            fontSize: compact ? 10 : 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: compact ? 2 : 4),
              // 各弦音名
              ...List.generate(widget.notes.length, (stringIndex) {
                return _buildString(
                  context, stringIndex, widget.notes[stringIndex],
                  cellHeight: cellHeight,
                  cellWidth: cellWidth,
                  noteBoxSize: noteBoxSize,
                  noteFontSize: noteFontSize,
                  labelWidth: labelWidth,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildString(
    BuildContext context,
    int stringIndex,
    List<String> stringNotes, {
    required double cellHeight,
    required double cellWidth,
    required double noteBoxSize,
    required double noteFontSize,
    required double labelWidth,
  }) {
    final stringNum = stringIndex + 1;
    return Row(
      children: [
        SizedBox(
          width: labelWidth,
          child: Text(
            '${stringNum}弦',
            style: TextStyle(
              fontSize: widget.compact ? 10 : 12,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        ...stringNotes.asMap().entries.map((entry) {
          final fret = entry.key;
          final note = entry.value;
          final isNatural = NoteUtils.isNaturalNote(note);
          final isOpen = fret == 0;

          return Container(
            width: cellWidth,
            height: cellHeight,
            decoration: BoxDecoration(
              color: isOpen ? Colors.grey.shade900 : Colors.transparent,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade800, width: 0.5),
                right: BorderSide(
                  color: isOpen ? Colors.amber.shade700 : Colors.grey.shade900,
                  width: isOpen ? 2 : 0.5,
                ),
              ),
            ),
            child: Center(
              child: Container(
                width: noteBoxSize,
                height: noteBoxSize,
                decoration: BoxDecoration(
                  color: isNatural
                      ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    note,
                    style: TextStyle(
                      fontSize: noteFontSize,
                      fontWeight: isNatural ? FontWeight.bold : FontWeight.normal,
                      color: isNatural
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
