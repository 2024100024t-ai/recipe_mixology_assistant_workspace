library terminal_colors;

extension TerminalColorStyles on String {
  String get styleHeader => '\x1B[1;36m$this\x1B[0m';
  String get styleSuccess => '\x1B[32m$this\x1B[0m';
  String get styleWarning => '\x1B[33m$this\x1B[0m';
  String get styleError => '\x1B[31m$this\x1B[0m';
}
