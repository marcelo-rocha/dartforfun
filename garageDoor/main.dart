import "dart:io";

enum Door {OPEN, CLOSING, CLOSED, OPENING, STOPPED_WHILE_CLOSING,
  STOPPED_WHILE_OPENING, EMERGENCY_OPENING, OPEN_BLOCKED}
enum Event {button_clicked, cycle_complete, block_detected, block_cleared}

final DoorFSM = const {
  Door.OPEN: const {
    Event.button_clicked: Door.CLOSING,
    Event.block_detected: Door.OPEN_BLOCKED},
  Door.CLOSING: const {
    Event.cycle_complete: Door.CLOSED,
    Event.button_clicked: Door.STOPPED_WHILE_CLOSING,
    Event.block_detected: Door.EMERGENCY_OPENING},
  Door.CLOSED: const {
    Event.button_clicked: Door.OPENING},
  Door.OPENING: const {
    Event.cycle_complete: Door.OPEN,
    Event.button_clicked: Door.STOPPED_WHILE_OPENING,
    Event.block_detected: Door.EMERGENCY_OPENING},
  Door.STOPPED_WHILE_CLOSING: const {
    Event.button_clicked: Door.OPENING},
  Door.STOPPED_WHILE_OPENING: const {
    Event.button_clicked: Door.CLOSING},
  Door.EMERGENCY_OPENING: const {
    Event.cycle_complete: Door.OPEN_BLOCKED,
    Event.block_cleared: Door.OPENING},
  Door.OPEN_BLOCKED: const {
    Event.block_cleared: Door.OPEN}
};

main() {
  var currentState = Door.CLOSED;
  print("Door: CLOSED");
  var eventName;
  while((eventName = stdin.readLineSync())!= null) {
    var newEvent = Event.values.firstWhere((e) => e.toString().endsWith(eventName));
    currentState = DoorFSM[currentState][newEvent] ?? currentState;
    print("> " + eventName[0].toUpperCase() + eventName.substring(1).replaceFirst("_", " "));
    print(currentState.toString().replaceFirst(".", ": "));
  }
}


