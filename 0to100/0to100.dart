var rightHandValues = const[8, 12, 14, 15, 16, 24, 28, 30, 31];

String fingersToDecimal(String hand) {
  int idx = rightHandValues.indexOf(int.parse(hand, radix: 2));
  if (idx == - 1) throw "Invalid";
  return (idx + 1).toString();
} 

String reverse(String s) => new List.from(s.split('').reversed).join();

String decode(String input) {
  try {
    return fingersToDecimal(reverse(input.substring(0,5))) + fingersToDecimal(input.substring(5)); 
  }
  catch(e) {
    return e.toString();
  }
}

fmtOut(String input) => '$input -> ${decode(input)}';

void main() {
  print(fmtOut('0111011100'));
  print(fmtOut('1010010000'));
  print(fmtOut('0011101110'));
  print(fmtOut('0000110000'));
  print(fmtOut('1111110001'));
}

