float mod(float a, float b) {
  return (a % b + b) % b;
}

ArrayList<Rainbow> rainbows;

void setup() {
  size(800, 800);
  background(0);
  rainbows = new ArrayList<Rainbow>();
}

void draw() {
  colorMode(HSB, 255, 255, 255);
  stroke(255);
  background(0);
  loadPixels();
  
  for (Rainbow r : rainbows) {
    r.draw_rainbow();
    r.move();
  }
  
  updatePixels();
}

void keyPressed() {
  switch(keyCode) {
    case ' ':
      rainbows.add(new Rainbow());
      break;
    case 'R':
      setup();
      break;
  }
}
