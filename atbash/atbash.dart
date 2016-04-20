import "dart:io";

main() {
  var line;
  while ((line = stdin.readLineSync()) != null) {
    print(line.replaceAllMapped(
        new RegExp("[A-Za-z]"),
        (Match m) => new String.fromCharCode(
            (m[0].codeUnitAt(0) <= 90 ? 155 : 219) - m[0].codeUnitAt(0))));
  }
}
