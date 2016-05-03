import "dart:io";
import "dart:math";

main() {
  var line, lines = new List<String>();
  while ((line = stdin.readLineSync()) != null) {
    lines.add(line.splitMapJoin(new RegExp(r"(\d)+"),
        onMatch: (m) => m.group(0).toString() + " ", onNonMatch: (n) => ""));
  }
  var values = lines.join().trimRight().split(" ");
  var size = sqrt(values.length).toInt();
  for (var i = 0; i < 2 * size - 1; i++) {
    var items = new List<String>();
    for (var j = 0;
        j < (size * ((i + 1) ~/ size) - (i + 1) % size).abs();
        j++) {
      var x = min(i - j, size - 1 - j),
          y = j + min(i ~/ size, 1) * (i % size + 1);
      items.add(values[y * size + x]);
    }
    print(items.join(" "));
  }
}
