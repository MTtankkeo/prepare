import 'dart:io';
import 'source_file.dart';

/// Utility class for loading source files from a directory.
class SourceFileManager {
  const SourceFileManager._();

  /// Loads a [SourceFile] from the given [file] if its extension
  /// matches one of the allowed [extensions].
  static SourceFile? load(File file, List<String> extensions) {
    // Skip files that don't match any of the given extensions.
    if (extensions.isNotEmpty) {
      if (!extensions.any((e) => file.path.endsWith(e))) {
        return null;
      }
    }

    // Read file content and create a SourceFile instance.
    final content = file.readAsStringSync();
    return SourceFile(path: file.path, text: content);
  }

  /// Recursively loads all files under [entryDir] and
  /// returns them as a list of [SourceFile] instances.
  /// Throws an exception if [entryDir] does not exist.
  static List<SourceFile> loadAll(Directory entryDir, List<String> extensions) {
    if (!entryDir.existsSync()) {
      throw Exception("Directory '${entryDir.path}' does not exist.");
    }

    final files = <SourceFile>[];

    /// Helper function to traverse directories recursively.
    void collectFiles(Directory dir) {
      for (var entity in dir.listSync()) {
        if (entity is File) {
          final sourceFile = load(entity, extensions);

          // Read file content and create a SourceFile instance
          if (sourceFile != null) {
            files.add(sourceFile);
          }
        } else if (entity is Directory) {
          // Recursively collect files from subdirectories
          collectFiles(entity);
        }
      }
    }

    collectFiles(entryDir);
    return files;
  }
}
