const prog1 = """  ld a,14
  out (0),a
  ld a,12
  out (0),a
  ld a,8
  out (0),a

  out (0),a
  ld a,12
  out (0),a
  ld a,14
  out (0),a"""; 

const prog2 = """  ld b,3

triple:
  ld a,126
  out (0),a
  ld a,60
  out (0),a
  ld a,24
  out (0),a
  djnz triple""";

const prog3 = """  ld a,1
  ld b,9

loop:
  out (0),a
  rlca
  djnz loop""";

const prog4 = """  ld a,2
  ld b,9

loop:
  out (0),a
  rrca
  djnz loop""";

final rxLabel = new RegExp(r'(\w+):');
final rxLoad = new RegExp(r'\s+ld\s(a|b),(\d+)');
final rxOut = new RegExp(r'\s+out\s\(0\),a');
final rxJump = new RegExp(r'\s+djnz\s(\w+)');
final rxRot = new RegExp(r'\s+(rlca|rrca)');

void interpret(List<String> program) {
  var match;
  int ra = 0, rb = 0;
  int pc = 0;
  while(pc < program.length) {
		String line = program[pc];
  	if ((match = rxLoad.firstMatch(line)) != null) {
      var v = num.parse(match.group(2)); 
      match.group(1) == 'a' ? ra = v: rb = v;
  	}
  	else if ((match = rxOut.firstMatch(line)) != null) {
      print(ra.toRadixString(2).padLeft(8, "0").replaceAll("0", ".").replaceAll("1", "*"));
  	}
		else if ((match = rxRot.firstMatch(line)) != null) {
    	if(match.group(1) == 'rlca') {
        ra = ((ra << 1) & 0xff) | ((ra >= 0x80 ? 1 : 0)); 
      }
      else {
        ra = (ra >> 1) | (ra.isOdd ? 0x80: 0);
      }
  	}
  	else if ((match = rxJump.firstMatch(line)) != null) {
      if(--rb != 0) {
      	pc = program.indexOf(match.group(1) + ':');	  
      }
  	}
    pc++;                    
  }
}

void main() {
  var program = new List<String>();
  new RegExp('.+').allMatches(prog1).forEach((m)=>(program.add(m.group(0))));
  interpret(program);
}
