import "dart:math";

var input = [
  [4, 1],
  [4, 4],
  [4, 5],
  [4, 6],
  [1, 10],
  [100, 200],
  [8, 20]
];

double P(d, h) => h <= 1 ? 1.0 : 1 / d * (P(d, h - d) + max(d - h, 0));
String pad(v, width) => v.toString().padLeft(width);

void main() {
  print("  d |   h |     p");
  for (var i = 0; i < input.length; i++) {
    print(
        "${pad(input[i][0], 3)} | ${pad(input[i][1], 3)} | ${pad(P(input[i][0], input[i][1]), 11)}");
  }
}
