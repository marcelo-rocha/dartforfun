import "dart:html";
import "dart:math";

void main() {
  CanvasElement canvas = querySelector("#area");
  var clock = new Clock(canvas);
  clock.setTime(0, 10); // initial values
}

class Clock {
  CanvasElement canvas;
  int clockHours;
  int clockMinutes;
  int clockSeconds;
  num width;
  num height;
  num hourAngle;
  num minuteAngle;

  static const double degreesForHour = 360 / 12;
  static const double degreesForMinute = 360 / 60;

  Clock(canvas) {
    this.canvas = canvas;

    InputElement sliderh = querySelector("#sliderh");
    sliderh.onChange.listen((Event e) {
      clockHours = int.parse(sliderh.value);
      InputElement hoursLabel = querySelector("#selh");
      hoursLabel.text = clockHours.toString();
      show();
    });

    InputElement sliderm = querySelector("#sliderm");
    sliderm.onChange.listen((Event e) {
      clockMinutes = int.parse(sliderm.value);
      InputElement minutesLabel = querySelector("#selm");
      minutesLabel.text = clockMinutes.toString();
      show();
    });
  }

  void setTime(int hours, int minutes) {
    clockHours = hours;
    clockMinutes = minutes;
    clockSeconds = 0;
    show();
  }

  void show() {
    // Measure the canvas element.
    Rectangle rect = canvas.parent.client;
    width = rect.width;
    height = rect.height;
    canvas.width = width;
    hourAngle = degreesForHour * (clockHours + clockMinutes / 60);
    minuteAngle = degreesForMinute * clockMinutes;

    InputElement anglediff = querySelector("#anglediff");
    anglediff.text = (minuteAngle - hourAngle).abs().toString();

    draw();
  }

  void draw([_]) {
    var context = canvas.context2D;
    drawClock(context);
  }

  void drawClock(CanvasRenderingContext2D context) {
    // based on the sample code from http://neilwallis.com/projects/html5/clock/index.php
    // Outer bezel
    context.clearRect(0, 0, 300, 300);
    var g1 = context.createLinearGradient(0, 0, 300, 300);
    g1.addColorStop(0, "#D83040");
    g1.addColorStop(1, "#801020");
    context
      ..strokeStyle = g1
      ..lineWidth = 10
      ..beginPath()
      ..arc(150, 150, 138, 0, PI * 2, true)
      ..shadowOffsetX = 4
      ..shadowOffsetY = 4
      ..shadowColor = "rgba(0, 0, 0, 0.6)"
      ..shadowBlur = 6
      ..stroke();

    // Inner bezel
    var g2 = context.createLinearGradient(0, 0, 300, 300);
    g2.addColorStop(0, "#801020");
    g2.addColorStop(1, "#D83040");
    context
      ..strokeStyle = g2
      ..lineWidth = 10
      ..fillStyle = "white"
      ..beginPath()
      ..arc(150, 150, 129, 0, PI * 2, true)
      ..stroke();

    context
      ..strokeStyle = "#FFFFFF"
      ..save()
      ..translate(150, 150);

    //Markings/Numerals
    for (var i = 1; i <= 60; i++) {
      var ang = PI / 30 * i;
      var sang = sin(ang);
      var cang = cos(ang);
      var sx, sy, ex, ey;
      //If modulus of divide by 5 is zero then draw an hour marker/numeral
      if (i % 5 == 0) {
        context.lineWidth = 8;
        sx = sang * 95;
        sy = cang * -95;
        ex = sang * 120;
        ey = cang * -120;
        var nx = sang * 80;
        var ny = cang * -80;
        context.fillText((i ~/ 5).toString(), nx, ny);
        //Else this is a minute marker
      } else {
        context.lineWidth = 2;
        sx = sang * 110;
        sy = cang * 110;
        ex = sang * 120;
        ey = cang * 120;
      }
      context
        ..beginPath()
        ..moveTo(sx, sy)
        ..lineTo(ex, ey)
        ..strokeStyle = "#FFFFFF"
        ..stroke();
    } //for
    context.restore(); // pop 1

    //Draw hour hand
    context
      ..save()
      ..translate(150, 150)
      ..lineWidth = 6
      ..rotate(PI / 180 * hourAngle)
      ..beginPath()
      ..moveTo(0, 10)
      ..lineTo(0, -50)
      ..stroke()
      ..restore();

    //Draw minute hand
    context
      ..save()
      ..lineWidth = 3
      ..translate(150, 150)
      ..rotate(PI / 180 * minuteAngle)
      ..beginPath()
      ..moveTo(0, 20)
      ..lineTo(0, -100)
      ..stroke()
      ..restore();
  }

  double calculateAngle(int hours, int minutes) {
    var h = (hours + minutes / 60) * degreesForHour;
    var m = minutes * degreesForMinute;
    var r = (h - m).abs();
    return r;
  }

  void requestRedraw() {
    var f = window.animationFrame;
    f.then(draw);
  }
}
