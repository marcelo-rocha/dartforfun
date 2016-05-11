import 'dart:io';

main() {
  var size = int.parse(stdin.readLineSync());
  var nodes = new List<int>(size)..fillRange(0, size, 0);
  addNode(String node) => nodes[int.parse(node) - 1]++;
  var line;
  while ((line = stdin.readLineSync()) != null) {
    var pair = line.split(" ");
    addNode(pair[0]);
    addNode(pair[1]);
  }
  for (var i = 1; i <= size; i++) {
    print("Node $i has a degree of ${nodes[i - 1]}");
  }
}
