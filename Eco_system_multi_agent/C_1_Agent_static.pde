/**
Agent Static 0.2.0
*/
abstract class Agent_static extends Agent_method {
  /**
  specific
  */ 
  int speed_growth = 1 ;
  float need = 1. ;

  /**
  Constructor

  */
  Agent_static(Vec3 pos, int size, String name) {
    this.pos.set(pos) ;
    this.name = name ;
    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
    this.size = this.size_ref = this.size_max  = size ;
  }

  Agent_static(Info_dict carac, int gender) {
    String temp_name = "Nobody" ;
    int temp_size = 1 ;
    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
    if (carac.get("name") != null) temp_name = (String) carac.get("name")[0].catch_a() ;
    if (carac.get("size") != null) temp_size = (int) random_gaussian((int)carac.get("size")[0].catch_a()) ;

    this.name = temp_name ;
    this.size = this.size_ref = this.size_max = temp_size ;
    this.gender = gender ;
  }
  
  /**
  set position
  * set_pos(arg) is not in the abstract class because for the dynamic agent the method is specific.
  */
  void set_pos(Vec pos) {
    if(pos instanceof Vec3) {
      Vec3 temp_pos = (Vec3) pos ;
      this.pos.set(temp_pos) ;
    }
    if(pos instanceof Vec2) {
      Vec2 temp_pos = (Vec2) pos ;

      this.pos.set(temp_pos.x, temp_pos.y,0) ;
    }
  }

  /**
  carrion
  */

  void carrion() {
    int threshold = 2 ;
    if(!alive) {
      dead_since += int(1. *CLOCK) ;
      if(size < size_ref / threshold || dead_since > TIME_TO_BE_CARRION) carrion = true ; 
      else carrion = false ;
    } 
  }

  /**
  info
  */
  void info_text(Vec4 colour, int size_text) {
    aspect(colour, colour, 1) ;
    Vec2 pos_text = Vec2(0) ;
    matrix_start() ;
    translate(pos) ;
    textSize(size_text) ;
    textAlign(CENTER) ;
    text(name, pos_text.x, pos_text.y) ;
    text(stamina + " " + size + " " + size_ref, pos_text.x, pos_text.y +(size_text *1.2) ) ;
    textSize(16) ;
    if(alive) {
      text("I'm alive", pos_text.x, pos_text.y +(size_text *2.4) ) ;
    } else {
      text("I'm dead", pos_text.x, pos_text.y +(size_text *2.4) ) ;
    }
    matrix_end() ;
  }
}
/**
END Agent Static
*/
