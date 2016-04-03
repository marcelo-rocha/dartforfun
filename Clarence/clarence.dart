import "dart:math";

final String keys = "123456789.0";
double distance(List<num> a, b) => sqrt(pow((b[1] - a[1]), 2) + pow((b[0] - a[0]), 2));
List<num> coords(String c) => [keys.indexOf(c) ~/ 3, keys.indexOf(c) % 3];

main(List<String> args) {
  var address = args[0];
  var data = new List<String>.generate(address.length, (int idx) => address[idx]);
  double total = data.fold([0, data[0]], (prev, element) => [prev[0] + distance(coords(prev[1]), coords(element)), element])[0];
  print(total.toStringAsFixed(2) + " cm");
}