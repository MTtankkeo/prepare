import 'dart:io';

// ANSI color codes for console output.
const red = "\x1B[31m";
const green = "\x1B[32m";
const reset = "\x1B[0m";
const gray = "\x1B[90m";
const yellow = "\x1B[33m";

/// Simple logger with optional color.
void log(String str, {String color = ""}) {
  print("$color$str$reset");
}

void error(String str) {
  log(str, color: red);
  exit(0);
}
