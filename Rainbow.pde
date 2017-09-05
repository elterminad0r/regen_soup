class Rainbow {
  PVector pos, vel;
  float lth, rth, lvel, rvel, min_lr, max_lr, lr_delta, lr_speed,
        min_r, max_r, r_delta, r_speed, colour_offset, colour_speed;

  Rainbow() {
    min_r = random(40, 75);
    max_r = random(min_r + 5, 120);
    max_lr = random(30, min_r - 5);
    min_lr = random(10, max_lr - 5);
    colour_offset = random(255);
    colour_speed = random(5);
    r_delta = random(TWO_PI);
    lr_delta = random(TWO_PI);
    r_speed = random(0.05, 0.1);
    lr_speed = random(0.05, 0.1);
    lth = random(TWO_PI);
    rth = random(TWO_PI);
    lvel = random(-0.05, 0.05);
    rvel = random(-0.05, 0.05);
    pos = new PVector(random(min_r, width - min_r), random(min_r, height - min_r));
    vel = new PVector(random(-3, 3), random(-3, 3));
  }

  void draw_rainbow() {
    float r = map(sin(r_delta), -1, 1, min_r, max_r);
    float lr = map(sin(lr_delta), -1, 1, min_lr, max_lr);
    for (int x = (int) (pos.x - r - 1); x < pos.x + r + 1; x++) {
      for (int y = (int) (pos.y - r - 1); y < pos.y + r + 1; y++) {
        int loc = y * width + x;
        float mag = (dist(pos.x, pos.y, x, y));
        float head = new PVector(x, y).sub(pos).heading() + PI;
        boolean orient; 
        
        if (lth < rth) {
          orient = head > lth && head < rth;
        } else {
          orient = head > lth || head < rth;
        }

        if (mag < r && mag > lr && orient && loc < pixels.length && loc >= 0) {
          float h = map(mag, lr, r, 0, 255);
          pixels[loc] = color((h + colour_offset) % 255, 255, 255);
        }
      }
    }
  }
  
  void move() {
    pos.add(vel);
    r_delta += r_speed;
    lr_delta += lr_speed;
    colour_offset += colour_speed;
    float r = map(sin(r_delta), -1, 1, min_r, max_r);
    if (pos.x - r < 0) {
      vel.x = abs(vel.x);
      pos.x = r;
    }
    if (pos.x + r > width) {
      vel.x = -abs(vel.x);
      pos.x = width - r;
    }
    if (pos.y - r < 0) {
      vel.y = abs(vel.y);
      pos.y = r;
    }
    if (pos.y + r > height) {
      vel.y = -abs(vel.y);
      pos.y = height - r;
    }
    boolean swap = (lth < rth) ^ ((lth + lvel) < (rth + rvel));
    lth = mod(lth + lvel, TWO_PI);
    rth = mod(rth + rvel, TWO_PI);
    if (swap) {
      float tmp = lth;
      lth = rth;
      rth = tmp;
      
      tmp = lvel;
      lvel = rvel;
      rvel = tmp;
    }
  }
}


