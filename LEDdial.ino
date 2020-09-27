#include <FastLED.h>

#define PIN_SECONDS 2
#define PIN_MINUTES 3
#define PIN_HOURS 4
#define PIN_ADJUST 5
#define RESOLUTION 24
#define RED CRGB(255,0,0)
#define GREEN CRGB(0,255,0)
#define BLUE CRGB(0, 0, 255)
#define OFF CRGB(0,0,0);

CRGB ledsSecond[RESOLUTION];
CRGB ledsMinute[RESOLUTION];
CRGB ledsHour[RESOLUTION];

int milliseconds = 0;
int second = 0;
int minute = 0;
int hour = 0;
unsigned long lastTime = 0;
unsigned long maxTime = 4294967295;

void setup() {
  FastLED.addLeds<WS2812, PIN_SECONDS, GRB>(ledsSecond, RESOLUTION);
  FastLED.addLeds<WS2812, PIN_MINUTES, GRB>(ledsMinute, RESOLUTION);
  FastLED.addLeds<WS2812, PIN_HOURS, GRB>(ledsHour, RESOLUTION);
  FastLED.show();

  pinMode(PIN_ADJUST, OUTPUT);
  lastTime = millis();
}

void loop() {
  ledsSecond[getLedSecond()] = OFF;
  ledsMinute[getLedMinute()] = OFF;
  ledsHour[getLedHour()] = OFF
  
  unsigned long currentTime = millis();
  int diff = currentTime - lastTime;
  if(lastTime > currentTime) {
    diff = maxTime - lastTime + currentTime;
  }
  milliseconds += diff;
  lastTime = currentTime;

  if(milliseconds >= 1000) {
    second++;
    milliseconds -= 1000;
  } else if(!digitalRead(PIN_ADJUST)) {
    minute++;
    second=60;
    delay(100);
    milliseconds = 0;
  }
  
  if(second == 60) {
    second = 0;
    minute++;
    if(minute == 60) {
      minute = 0;
      hour++;
      if(hour == 12) {
        hour = 0;
      }
    }
  }

  ledsSecond[getLedSecond()] = GREEN;
  ledsMinute[getLedMinute()] = BLUE;
  ledsHour[getLedHour()] = RED;
  FastLED.show();
}

int getLedSecond() {
  return ((int)round((second + milliseconds / 1000.0) / 60.0 * 24.0) + 6 + 11) % 24;
}

int getLedMinute() {
  return ((int)round((minute + second / 60.0) / 60.0 * 24.0) + 6 + 11) % 24;
}

int getLedHour() {
  return ((int)round((hour + minute / 60.0) / 12.0 * 24.0) + 6 + 11) % 24;
}
