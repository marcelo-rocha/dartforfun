import "dart:io";

main() {
  var line;
  while ((line = stdin.readLineSync()) != null) {
    print(line.splitMapJoin(new RegExp("[A-Za-z]"),
        onMatch: (m) => new String.fromCharCode(
            (m[0].codeUnitAt(0) <= 90 ? 155 : 219) - m[0].codeUnitAt(0))));
  }
}
