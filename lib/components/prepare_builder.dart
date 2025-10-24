import 'package:prepare/components/source_file.dart';

/// Defines the base interface for all prepare builders.
///
/// Implementations of this class perform preprocessing tasks
/// on the provided [SourceFile] before the main build process.
abstract class PrepareBuilder {
  /// The unique name that identifies this builder.
  String get name;

  /// The list of file extensions this builder is responsible for processing.
  List<String> get extensions;

  /// Executes the build process for the given [SourceFile].
  Future<bool> build(SourceFile source);
}
