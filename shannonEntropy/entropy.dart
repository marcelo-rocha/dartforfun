import "dart:io";
import "dart:core";
import "dart:collection";
import "dart:math";

double log2(n) => log(n) / LN2;
double term(k) => k * log2(k);

double calcEntropy(String str) {
  var freq = new HashMap<int, int>();
  str.codeUnits.forEach((c) => freq[c] = 1 + (freq[c] ?? 0));
  var n = str.length, r = 0.0;
  freq.values.forEach((v) => r += term(v / n));
  return -r;
}

main() {
  var line;
  while((line = stdin.readLineSync()) != null) {
    print(calcEntropy(line));
  }
}