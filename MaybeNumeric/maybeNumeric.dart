import "dart:io";

bool isNumeric(String str) => num.parse(str, (s) => null) != null;
bool maybeNumeric(String value) => value.split(" ").every(isNumeric);

main() {
  var line;
  while ((line = stdin.readLineSync()) != null) {
    line.split("`").forEach(
        (v) => print(v + (maybeNumeric(v) ? " (number)" : " (string)")));
  }
}
