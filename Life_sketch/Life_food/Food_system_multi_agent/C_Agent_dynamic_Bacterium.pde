  /**
  SUB CLASS BACTERIUM 0.0.3
  */
  class Bacterium extends Agent_dynamic {
    float humus_prod = .25 ;
    // boolean eating   ;
    Bacterium(Vec3 pos, int size, int life, int velocity, float sense_view, String name) {
      super(pos, size, life, velocity, name) ;
      this.sense_view = int(size *sense_view) ;
      eat_zone = int(size *2) + size ;
    }

    void set_humus_prod(float prod) {
      this.humus_prod = prod ;
    }



    void watch(Agent_dynamic a, boolean info) {
      // Vec3 pos_target = a.pos.copy() ;
      if(dist(a.pos,pos) < sense_view && !a.alive ) {
        if(info) {
          stroke(colour_stroke) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
        watching = false ; 
      } else watching = true ;
    }




     // Method
    void eat(Agent_dynamic a, boolean info) {
      if(dist(a.pos,pos) < eat_zone ) {
        if(info) line(a.pos, pos) ;
        float calories = speed_eating *humus_prod ;
        a.size -= speed_eating ;
        hunger += (calories *digestion) ;
        HUMUS += (calories *humus_prod) ;
        life += (calories *.75) ;
        eating = true ;
      } else eating = false ;
    }


    void pick(Agent_dynamic a) {
      if (!watching) dir.set(target_direction(a.pos,pos)) ; 
    }

    boolean picking() {
      if (watching) return false ; else return true ;
    }

    // info
    void info(Vec4 colour, int size_text) {
      info_visual_bacterium(colour) ;
      info_text(colour, size_text) ;
    }

    void info_visual_bacterium(Vec4 colour) {
      aspect(Vec4(), colour, 1) ;
      Vec3 pos_temp = Vec3 (0) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, sense_view*2, sense_view*2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }


    // print
    void info_print_bacterium() {
      println("INFO",this.name) ;
      println("No particular info for the moment") ;
    }
  }
  /**
  END SUB CLASS BACTERIUM
  */