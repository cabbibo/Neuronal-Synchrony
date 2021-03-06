class Engine {

  private Piston[] pistons;
  private int amount = 8;
  private Router router;
  private Palette.Color pigment;

  private float ox;
  private float oy;

  public float x;
  public float y;
  public float w;
  public float h;
  public float gutter;
  public float duration = .15;
  public float delay = 0;

  Engine(Router r, int d) {
    router = r;
    duration = d / (float) 1000;
    initialize();
  }

  Engine(Router r, int d, int amt) {
    router = r;
    duration = d / (float) 1000;
    amount = amt;
    initialize();
  }

  /**
   * Center mode declaration
   */
  Engine(Router r, float _x, float _y, float _w, float _h) {
    router = r;
    w = _w;
    h = _h;
    oy = _y;
    ox = _x;
    x = _x - (w / 2);
    y = _y - (h / 2);
    initialize();
  }
  
  Engine(Router r, int _x, int _y, int _w, int _h) {
    router = r;
    w = (float) _w;
    h = (float) _h;
    x = (float) _x - (w / 2);
    y = (float) _y - (h / 2);
    initialize();
  }

  /**
   * Getters
   */

  public boolean isPlaying() {
    boolean result = false;
    for (int i = 0; i < amount; i++) {
      Piston p = pistons[i];
      if (p.playing) {
        result = true;
        break;
      }
    }
    return result;
  }

  /**
   * Setters
   */

  public void setColor(Palette.Color c) {
    pigment = c;
  }

  public void setAmount(int amt) {
    amount = amt;
  }

  public void setDelay(int d) {
    delay = d;
  }

  public void setDimensions(float _w, float _h) {
    w = _w;
    h = _h;
    x = (float) ox - (w / 2);
    y = (float) oy - (h / 2);
  }

  public void initialize() {
    
    if (amount <= 1) {
      gutter = 0;
    } else {
      gutter = h / (float) (amount * 4);
    }
    
    pistons = new Piston[amount];
    float offsetH = (h / (float) amount) - gutter;
    
    for (int i = 0; i < amount; i++) {
      float offsetY = (i / (float ) amount) * h + y + gutter / 2;
      pistons[i] = new Piston(duration);
      pistons[i].initialize(x, offsetY, w, offsetH);
      pistons[i].setDelay(delay * i);
      pistons[i].setColor(pigment);
    }
  }

  public void play() {
    for (int i = 0; i < amount; i++) {
      pistons[i].play();
    }
  }

  public void render() {
    for (int i = 0; i < amount; i++) {
      pistons[i].render();
    }
  }
}

