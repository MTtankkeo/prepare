import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:prepare/components/prepare_builder.dart';
import 'package:prepare/components/source_file_manager.dart';
import 'package:prepare/log.dart';

/// A CLI command that triggers the prepare build process.
abstract class PrepareBuildCommand extends Command {
  @override
  String get name => "build";

  @override
  String get description => "Generates files for Dart.";

  /// Returns the instance of [PrepareBuilder]. 
  PrepareBuilder get builder;

  /// Attempts to build all Dart source files in the given [dir].
  Future<void> tryBuildAll(Directory dir) async {
    // Start the build process on the given directory.
    final files = SourceFileManager.loadAll(dir);

    for (final file in files) {
      builder.build(file);
    }
  }

  @override
  Future<void> run() async {
    final dir = Directory("./");

    try {
      // Start the build process on the current directory.
      tryBuildAll(dir);

      log("${builder.name} for pre-processing build completed successfully!", color: green);
    } catch (error) {
      log("${builder.name} Error: $error", color: red);
    }
  }
}
