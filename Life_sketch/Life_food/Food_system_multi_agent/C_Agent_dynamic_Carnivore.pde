  /**
  SUB CLASS CARNIVORE 0.0.3
  */
  class Carnivore extends Agent_dynamic {
    boolean killing   ;
    int attack = 1 ;
    int kill_zone ;
    int time_track ;
    int max_time_track = int(360 *CLOCK) ;

    Carnivore(Vec3 pos, int size, int life, int velocity, float sense_view, String name) {
      super(pos, size, life, velocity, name) ;
      this.sense_view = int(size *sense_view) ;
      kill_zone = int(size *2) +size ;
      eat_zone = int(size *1.2) ;
    }


    void set_kill_zone(int radius) {
      this.kill_zone = radius ;
    }

    void set_attack(int attack) {
      this.attack = attack ;
    }

    void set_max_time_track(int max) {
      this.max_time_track = int(max *frameRate *CLOCK) ;
    }






    // hunt
    void hunt(Agent_dynamic a, boolean info) {
      if(a.alive) {
        hunt_in_progress() ;
        follow(a, info) ;
      } else {
        hunt_stop() ;
      } 
    }

    void kill(Agent_dynamic a, boolean info) {
      if(dist(a.pos,pos) < kill_zone && a.alive ) {
        if(info) {
          stroke(colour_stroke) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
        a.life -= 1 *attack ;
        // a.size -= 1 ;
      }
    }

    void follow(Agent_dynamic a, boolean info) {
      if(info) {
        stroke(colour_stroke) ;
        strokeWeight(1) ;
        line(a.pos, pos) ;
      }
      dir.set(target_direction(a.pos, pos)) ;
    }

    float dist_to_target(Agent_dynamic a, boolean info) {
      float dist = dist(a.pos,pos) ;
      if(dist < sense_view) {
        if(info) {
          stroke(colour_stroke) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
      }
      return dist ;
    }

    void hunt_in_progress() {
      time_track += 1 ;
      tracking = true ; 
      watching = false ;
    }

    void hunt_stop() {
      time_track = 0 ;
      tracking = false ; 
      watching = true ;
    }







    // heat
    void eat(Agent_dynamic a, boolean info) {
      if(dist(a.pos,pos) < eat_zone && !a.alive && threshold_quality_meat(a, gourmet)) {
        if(info) {
          stroke(colour_stroke) ;
          strokeWeight(1) ;
          line(a.pos, pos) ;
        }
        float calories = a.meat_quality *speed_eating ;
        a.size -= speed_eating ;
        hunger += (calories *digestion) ;
        life += calories ;
        eating = true ;
      } else eating = false ;
    }



    boolean threshold_quality_meat(Agent_dynamic a, float step) {
      if(a.size > a.size_ref / step ) return true ; else return false ;
    }

    

    


    
    // info
    void info(Vec4 colour, int text_size) {
      info_visual_carnivore(colour) ;
      info_text(colour, SIZE_TEXT_INFO) ;
    }

    void info_visual_carnivore(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(), colour, 1) ;
      matrix_start() ;
      translate(pos) ;
      // info feed
      ellipse(pos_temp.x, pos_temp.y, sense_view*2, sense_view*2) ;
      ellipse(pos_temp.x, pos_temp.y, kill_zone *2, kill_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      // info reproduction
      matrix_end() ;
    }

    // print
    void info_print_carnivore() {
      println("INFO",this.name) ;
      println("time track", int((float)time_track / frameRate));
    }
  }
  /**
  END SUB CLASS CARNIVORE
*/