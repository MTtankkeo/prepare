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

  /// The directory to monitor for file changes during watch mode.
  Directory get directory => Directory("./");

  /// The types of file system events to monitor during watch mode.
  List<int> get observedEvents {
    return [
      FileSystemEvent.create,
      FileSystemEvent.modify,
      FileSystemEvent.move,
    ];
  }

  /// Returns the instance of [PrepareBuilder].
  PrepareBuilder get builder;

  @override
  Future<void> run() async {
    try {
      // Start the build process on the current directory.
      log(
        "Starting ${builder.name.toLowerCase()} build in watch mode...",
        color: yellow,
      );

      // Watch for changes.
      await for (final event in directory.watch(recursive: true)) {
        if (!observedEvents.contains(event.type)) continue;

        if (!event.isDirectory) {
          // Skip if a build is already running.
          PrepareQueue.tryBuild(File(event.path), builder);
        }
      }
    } catch (error) {
      log("${builder.name} Error: $error", color: red);
    }
  }
}
