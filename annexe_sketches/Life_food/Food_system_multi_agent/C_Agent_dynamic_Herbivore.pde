  /**
  SUB CLASS HERBIVORE 0.0.3
  */
  class Herbivore extends Agent_dynamic {
    // boolean eating   ;
    Herbivore(Vec3 pos, int size, int life, int velocity, float sense_view, String name) {
      super(pos, size, life, velocity, name) ;
      this.sense_view = int(size *sense_view) ;
      eat_zone = int(size *1.2) ;
    }


    // watch
    void watch(Flora f, boolean info) {
      if(time_watching < max_watching) {
        if(dist(f.pos,pos) < sense_view && threshold_quality_food(f, gourmet) && f.size >= size_target) {
          if(info) {
            stroke(colour_stroke) ;
            strokeWeight(1) ;
            line(f.pos, pos) ;
          }
          size_target = f.size ;
          time_watching ++ ;
          watching = false ; 
        } else {
          watching = true ;
        } 
      } else {
        time_watching = 0 ;
        size_target = 0 ;
      }
    }


    // eat
    void eat(Flora f, boolean info) {
      if(dist(f.pos,pos) < eat_zone && threshold_quality_food(f, gourmet) ) {
        if(info) line(f.pos, pos) ;
        float calories = f.nutrient_quality *speed_eating ;
        f.life -= speed_eating ;
        f.size -= speed_eating ;
        hunger += (calories *digestion) ;
        life += calories ;
        eating = true ;
        //calm = true ;
        size_target = 0 ;
      } else {
        eating = false ;
      }
    }
    // local method
    boolean threshold_quality_food(Flora f, float step) {
      if(f.size > f.size_ref / step ) return true ; else return false ;
    }


    // pick
    void pick(Flora f) {
      if (!watching) {
        Vec3 pos_target = f.pos.copy() ;
        dir.set(target_direction(pos_target, pos)) ; 
      }
    }

    boolean picking() {
      if (watching) return false ; else return true ;
    }


    // info
    void info(Vec4 colour, int size_text) {
      info_visual_herbivore(colour) ;
      info_text(colour, size_text) ;
    }

    void info_visual_herbivore(Vec4 colour) {
      aspect(Vec4(),colour, 1) ;
      Vec3 pos_temp = Vec3(0) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, sense_view*2, sense_view*2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }
    
    // print
    void info_print_herbivore() {
      println("INFO",this.name) ;
      println("No particular info for the moment") ;
    }
  }
  /**
  SUB CLASS HERBIVORE
  */


