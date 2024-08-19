int hue = 0;

class TowerBlock {
  float x;
  float y;
  float w;
  float h;

  float vx = 1;

  int hu;

  TowerBlock(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    hue += 3;
    this.hu = hue;
  }

  void update() {
    if (x <= 0 || x + w >= width) vx = vx * -1;

    x += vx;
  }

  void show() {
    fill(this.hu, 220, 255);
    rect(x, y, w, h);
  }
}

float BLOCK_H = 30;
float INITIAL_BLOCK_W = 800;

class Tower {
  ArrayList<TowerBlock> blocks = new ArrayList<>();
  TowerBlock current;

  Tower() {
    TowerBlock base = new TowerBlock(0, height - BLOCK_H, width, BLOCK_H);
    blocks.add(base);
    current = new TowerBlock(random(0, width - INITIAL_BLOCK_W), base.y - BLOCK_H, INITIAL_BLOCK_W, BLOCK_H);
  }

  void action() {
    if (current.x + current.w <= last().x) return;
    if (current.x >= last().x + last().w) return;

    if (current.x < last().x) {
      float diff = last().x - current.x;
      current.x = last().x;
      current.w = current.w - diff;
    }

    if (current.x + current.w > last().x + last().w) {
      float diff = (current.x + current.w) - (last().x + last().w);
      current.w = current.w - diff;
    }

    blocks.add(current);

    current = new TowerBlock(random(0, width - last().w), last().y - BLOCK_H, last().w, BLOCK_H);
  }

  void update() {
    current.update();
  }

  void show() {
    current.show();
    for (TowerBlock block : blocks) block.show();
  }

  TowerBlock last() {
    return blocks.get(blocks.size() - 1);
  }
}

Tower tower;

void setup() {
  size(900, 900);
  background(33);
  colorMode(HSB);
  tower = new Tower();
}

void draw() {
  background(33);
  tower.update();
  tower.show();
}

void mousePressed() {
  tower.action();
}
