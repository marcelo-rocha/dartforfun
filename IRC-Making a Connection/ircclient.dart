import "dart:io";
import "dart:convert";

main() {
  var url = stdin.readLineSync(), nickName = stdin.readLineSync();
  var userName = stdin.readLineSync(), realName = stdin.readLineSync();
  connect(url, nickName, userName, realName);
}

writeMsg(Socket socket, String msg) {
  print("<< " + msg);
  socket.writeln(msg);
}

connect(String url, String nickName, String userName, String realName) {
  var urlParts = url.split(":");
  print("Connecting...");
  Socket.connect(urlParts[0], num.parse(urlParts[1])).then((socket) {
    socket.encoding = Encoding.getByName("US-ASCII");
    socket.listen((data) {
          var line = new String.fromCharCodes(data).trim();
          print(line);
          if (line.startsWith('PING ')) {
            writeMsg(socket, "PONG " + line.substring(4).trim());
          }
        },
        onDone: () {
          print("Connection closed");
          socket.destroy();
        });

    writeMsg(socket, "NICK " + nickName);
    writeMsg(socket, "USER " + userName + " 0 * :" + realName);
  });
}
