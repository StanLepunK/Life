  /**
  MANAGE ECOSYSTEM BUILT 0.0.6
  */
  /**
  LIST
  */
  ArrayList<Flora> FLORA_LIST = new ArrayList<Flora>() ;
  ArrayList<Bacterium> BACTERIUM_LIST = new ArrayList<Bacterium>() ;
  ArrayList<Herbivore> HERBIVORE_LIST = new ArrayList<Herbivore>() ;
  ArrayList<Carnivore> CARNIVORE_LIST = new ArrayList<Carnivore>() ;
  ArrayList<Agent_dynamic> CORPSE_LIST = new ArrayList<Agent_dynamic>() ;


  /**
  Clear ecosysteme
  */
  void clear_ecosystem() {
    FLORA_LIST.clear() ;
    BACTERIUM_LIST.clear() ;
    HERBIVORE_LIST.clear() ;
    CARNIVORE_LIST.clear() ;
    CORPSE_LIST.clear() ;
  }


  /**
  ENVIRONMENT
  */
  Vec3 BOX = Vec3(100,100,100) ;
  Vec3 BOX_POS = Vec3() ;
  Vec6 LIMIT = Vec6(0,BOX.x,0,BOX.y,0,BOX.z) ;
  boolean REBOUND ;
  int SIZE_TEXT_INFO ;
  float HUMUS, HUMUS_MAX ;
  int ENVIRONMENT = 3 ; // 2 is for 2D, 3 for 3D
  boolean DISPLAY_INFO = false ;
  /**
  * Create enviromnent where the ecosystem will be live
  */
  void build_environment(Vec2 pos, Vec2 size) {
    Vec3 pos_3D = Vec3(pos.x, pos.y,0) ;
    Vec3 size_3D = Vec3(size.x, size.y,0) ;
    build_environment(pos_3D, size_3D) ;
    // write here to be sure the Environment have a good info
    ENVIRONMENT = 2 ; 
  }

  void build_environment(Vec3 pos, Vec3 size) {
    BOX_POS.set(pos) ;
    BOX.set(size) ;

    float left = BOX_POS.x - (BOX.x *.5) ;
    float right = BOX_POS.x + (BOX.x *.5) ;
    float top = BOX_POS.y - (BOX.y *.5) ;
    float bottom = BOX_POS.y + (BOX.y *.5) ;
    float front = BOX_POS.z - (BOX.z *.5) ;
    float back = BOX_POS.z + (BOX.z *.5) ;
    LIMIT.set(left,right, top, bottom, front, back) ;

    REBOUND = false ;
    SIZE_TEXT_INFO = 18 ;
    HUMUS_MAX = HUMUS = BOX.x *BOX.y *.01 ;
  }








  /**
  FLORA
  */
  /**
  * build the plant of the ecosystem
  */
  void build_flora(int size_template, Vec4 colour, int num) {
    for(int i = 0 ; i < num ; i++) {
      int size = int(random(ceil(size_template *.5), ceil(size_template*3))) ;
      String name = "salad" ;
      if(ENVIRONMENT == 2 ) {
        Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
        add_flora(pos, size, name, colour) ;
      } else if (ENVIRONMENT == 3 ) {
        Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
        add_flora(pos, size, name, colour) ;
      }
    }
  }

  void add_flora(Vec2 pos, int size, String name, Vec4 colour) {
     Vec3 final_pos =  Vec3(pos.x,pos.y,0) ;
     add_flora(final_pos, size, name, colour) ;
  }
  void add_flora(Vec3 pos, int size, String name, Vec4 colour) {
     Flora f = new Flora(pos, size, name) ;
     FLORA_LIST.add(f) ;
     f.set_fill(colour) ;
     f.set_stroke(colour) ;
     f.set_growth(2) ;
     f.set_need(.5) ;
  }


  /**
  // AGENT
  */
  /**
  // BACTERIUM
  */
  void build_bacterium(int size, int life, int velocity, float sense_view, Vec4 colour, int num) {
    for(int i = 0 ; i < num ; i++) {
      String name = "bacterium" ;
      if(ENVIRONMENT == 2 ) {
        Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
        add_bacterium(pos, size, life, velocity, sense_view, name, colour) ;
      } else {
        Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
        add_bacterium(pos, size, life, velocity, sense_view, name, colour) ;

      }
    }
  }

  void add_bacterium(Vec2 pos, int size, int life, int velocity, float sense_view, String name, Vec4 colour) {
    Vec3 final_pos = Vec3(pos) ;
    add_bacterium(final_pos, size, life, velocity, sense_view, name, colour) ;
  }

  void add_bacterium(Vec3 pos, int size, int life, int velocity, float sense_view, String name, Vec4 colour) {
    Bacterium b = new Bacterium(pos, size, life, velocity, sense_view, name) ;
    BACTERIUM_LIST.add(b) ;
    b.set_fill(colour) ;
    b.set_stroke(colour) ;
  }




  /**
  // HERBIVORE
  */

  void build_herbivore(int size, int life, int velocity, float sense_view, Vec4 colour, int num) {
    for(int i = 0 ; i < num ; i++) {
      String name = "human" ;
      if(ENVIRONMENT == 2 ) {
        Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
        add_herbivore(pos, size, life, velocity, sense_view, name, colour) ;
      } else {
        Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
        add_herbivore(pos, size, life, velocity, sense_view, name, colour) ;
      }
    }
  }

  void add_herbivore(Vec2 pos, int size, int life, int velocity, float sense_view, String name, Vec4 colour) {
     Vec3 final_pos = Vec3(pos) ;
     add_herbivore(final_pos, size, life, velocity, sense_view, name, colour) ;
  }

  void add_herbivore(Vec3 pos, int size, int life, int velocity, float sense_view, String name, Vec4 colour) {
     Herbivore h = new Herbivore(pos, size, life, velocity, sense_view, name) ;
     HERBIVORE_LIST.add(h) ;
     h.set_meat_quality(4) ;
     h.set_fill(colour) ;
     h.set_stroke(colour) ;
     h.set_gourmet(3.5) ;
  }



  /**
  // CARNIVORE
  */

  void build_carnivore(int size, int life, int velocity, float sense_view, Vec4 colour, int num) {
    for(int i = 0 ; i < num ; i++) {
      String name = "ALIEN" ;
      if(ENVIRONMENT == 2 ) {
        Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
        add_carnivore(pos, size, life, velocity, sense_view, name, colour) ;
      } else {
        Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
        add_carnivore(pos, size, life, velocity, sense_view, name, colour) ;
      }
    }
  }

  void add_carnivore(Vec2 pos, int size, int life, int velocity, float sense_view, String name, Vec4 colour) {
     Vec3 final_pos = Vec3(pos) ;
     add_carnivore(final_pos, size, life, velocity, sense_view, name, colour) ;
  }
  void add_carnivore(Vec3 pos, int size, int life, int velocity, float sense_view, String name, Vec4 colour) {
     Carnivore c = new Carnivore(pos, size, life, velocity, sense_view, name) ;
     CARNIVORE_LIST.add(c) ;
     c.set_attack(10) ;
     c.set_fill(colour) ;
     c.set_stroke(colour) ;
     c.set_gourmet(2.5) ;
  }
  /**
  END MANAGE ECOSYSTEM BUILT 
  */