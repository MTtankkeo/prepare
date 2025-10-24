import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:prepare/components/prepare_builder.dart';
import 'package:prepare/components/source_file.dart';
import 'package:prepare/components/source_file_manager.dart';
import 'package:prepare/log.dart';
import 'package:pool/pool.dart';

/// A CLI command that triggers the prepare build process.
abstract class PrepareBuildCommand extends Command {
  @override
  String get name => "build";

  @override
  String get description => "Generates files for Dart.";

  /// Returns the instance of [PrepareBuilder].
  PrepareBuilder get builder;

  /// Attempts to build a given Dart source files in the given [PrepareBuilder].
  static Future<void> tryBuild(
    SourceFile source,
    PrepareBuilder builder,
  ) async {
    final stopwatch = Stopwatch()..start();
    final hasBuilded = await builder.build(source);

    if (hasBuilded) {
      final elapsedTime = "${stopwatch.elapsedMilliseconds} ms";
      log(
        "Building the specified path: ${source.path} ($elapsedTime)",
        color: gray,
      );
    }
  }

  /// Attempts to build all Dart source files in the given [dir].
  Future<void> tryBuildAll(Directory dir) async {
    final sources = SourceFileManager.loadAll(dir, builder.extensions);
    final pool = Pool(10);

    final futures = sources.map((source) async {
      return pool.withResource(() async {
        await tryBuild(source, builder);
      });
    });

    await Future.wait(futures);
    await pool.close();
  }

  @override
  Future<void> run() async {
    final dir = Directory("./");

    try {
      // Start the build process on the current directory.
      await tryBuildAll(dir);

      log(
        "${builder.name} for pre-processing build completed successfully!",
        color: green,
      );
    } catch (error) {
      log("${builder.name} Error: $error", color: red);
    }
  }
}
