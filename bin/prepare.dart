import 'package:args/command_runner.dart';
import 'command/build_command.dart';
import 'command/watch_command.dart';

void main(List<String> args) {
  final runner = CommandRunner("prepare", "Manage pre-processing build");

  runner.addCommand(BuildCommand());
  runner.addCommand(WatchCommand());
  runner.run(args);
}
