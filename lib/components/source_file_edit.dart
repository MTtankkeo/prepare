import 'dart:io';

import 'package:prepare/components/source_file.dart';

/// A data class that represents a text edit in a source file, specifying
/// the range from [start] to [end] that should be replaced with [content].
class SourceFileEdit {
  const SourceFileEdit(this.start, this.end, this.content);

  final int start;
  final int end;
  final String content;

  /// Applies all collected edits to the source text and writes it back to the file.
  static void applyWith(SourceFile source, List<SourceFileEdit> edits) {
    edits.sort((a, b) => b.start.compareTo(a.start));

    for (final edit in edits) {
      source.text = source.text.replaceRange(
        edit.start,
        edit.end,
        edit.content,
      );
    }

    // Write the updated text back to the file.
    File(source.path).writeAsStringSync(source.text);
  }
}
