import "dart:io";
import "dart:math";

log10(n) => log(n) / LN10;

bool isKaprekar(int value) {
  int n = pow(value, 2);
  int d = log10(n).round();
  return [0, 1, 2].any((x) {
    int p = pow(10, d ~/ 2 + x);
    int h = n ~/ p;
    int l = n % p;
    return ((h + l) == value) && (l > 0);
  });
}

List<int> calcKaprekarNumbers(int rangeStart, rangeEnd) {
  var l = new List<int>();
  for (var i = rangeStart; i <= rangeEnd; i++) {
    if (isKaprekar(i)) l.add(i);
  }
  return l;
}

main() {
  var line;
  while ((line = stdin.readLineSync().trim()) != null) {
    if (line == "") break;
    var args = line.split(" ");
    var first = int.parse(args[0]), last = int.parse(args[1]);
    print(calcKaprekarNumbers(first, last)
        .toString()
        .replaceAll(new RegExp(r'[\[\],]'), ""));
  }
}
