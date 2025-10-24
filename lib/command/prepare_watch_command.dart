import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:prepare/components/prepare_builder.dart';
import 'package:prepare/components/prepare_queue.dart';
import 'package:prepare/log.dart';

/// A CLI command that triggers the prepare watch process.
abstract class PrepareWatchCommand extends Command {
  @override
  String get name => "watch";

  @override
  String get description => "Generates files for Dart with watch mode.";

  /// Returns the instance of [PrepareBuilder]. 
  PrepareBuilder get builder;

  @override
  Future<void> run() async {
    final dir = Directory("./");

    try {
      // Start the build process on the current directory.
      log("Starting ${builder.name.toLowerCase()} build in watch mode...", color: yellow);

      // Watch for changes.
      await for (final event in dir.watch(recursive: true)) {
        if (event.type == FileSystemEvent.modify) {
          // Skip if a build is already running.
          PrepareQueue.tryBuild(File(event.path), builder);
        }
      }
    } catch (error) {
      log("${builder.name} Error: $error", color: red);
    }
  }
}
