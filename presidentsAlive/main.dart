import "dart:io";
import "dart:collection";

int extractYear(String date) => int.parse(date.substring(date.lastIndexOf(" ") + 1));

final int maxYear = new DateTime.now().year;

List<int> parseLine(String line) {
  var data = line.split(",");
  var birthDate = data[1];
  int firstYear = extractYear(birthDate);
  var deathDate = data[3].trim();
  int lastYear = deathDate.isNotEmpty ? extractYear(deathDate) : maxYear;
  return [firstYear, lastYear];
}

main() {
  stdin.readLineSync(); // skip the header
  var yearsMap = new HashMap<int, int>();
  var line;
  while ((line = stdin.readLineSync()) != null) {
    var pair = parseLine(line);
    for (var y = pair[0]; y <= pair[1]; y++) {
      yearsMap[y] = yearsMap.containsKey(y) ? yearsMap[y] + 1: 1;
    }
  }

  int resultCount = 0;
  yearsMap.values.forEach((qty) => resultCount = resultCount > qty ? resultCount : qty);
  var years = new List<int>();
  yearsMap.forEach((year, count) => count == resultCount ? years.add(year): {});
  var list = years.toString();
  print (list.substring(1, list.length - 1));
}
