import "dart:core";
import "dart:collection";

String toCommaList(List l) {
  var s = l.toString();
  return s.substring(1, s.length - 1);
}

const lettersFreq = const [
  9,
  2,
  2,
  4,
  12,
  2,
  3,
  2,
  9,
  1,
  1,
  4,
  2,
  6,
  8,
  2,
  1,
  6,
  4,
  6,
  4,
  2,
  2,
  1,
  2,
  1,
  2
]; // letters A..Z _

main(List<String> args) {
  const CHARCODE_A = 65;
  final keys = new List<String>.generate(
      26, (int index) => new String.fromCharCode(CHARCODE_A + index),
      growable: true)..add('_');
  final remaining = new HashMap<String, int>.fromIterables(keys, lettersFreq);

  String input = args[0];
  for (int i = 0; i < input.length; i++) {
    var c = input[i];
    if (--remaining[c] < 0) {
      print("Invalid input. More $c"
          "'s have been taken from the bag than possible.");
      return;
    }
  }

  final totals = new SplayTreeMap<int, List<String>>();
  remaining.forEach(
      (c, n) => (totals[-n] == null ? totals[-n] = [c] : totals[-n].add(c)));
  totals.forEach((n, l) => l.sort());
  totals.forEach((n, l) => print("${-n}: ${toCommaList(l)}"));
}
