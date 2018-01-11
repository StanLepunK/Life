  /**
  CLASS AGENT DYNAMIC 0.1.0
  @author Stan le Punk
  @version 0.1.0
  */
  class Agent_dynamic implements RULES_ECOSYSTEME {
    String name ;
    int gender = 0 ; // 0 for female, 1 for male
    int ID = 0 ;
    Vec2 ID_target = Vec2(-1) ;

    // CARATERISTIC
    // physical 
    int age = 0 ;
    int life_expectancy = 1 ;
    int life, life_max ;
    int meat_quality ;
    // size
    int size, size_ref, size_max ;
    // sense
    int sense_view ;
    // motion
    Vec3 velocity_xyz ;
    int velocity, velocity_ref ;
    // Feed
    int step_hunger ;
    int hunger  ;
    int starving = 1 ;
    int speed_eating = 1 ;
    int eat_zone ;
    int greed = int(180 *CLOCK) ; // num of frame before stop to eat :)
    float gourmet = 2. ;
    int digestion = 2 ;
    // aspect
    Vec4 colour_fill = Vec4(0,0,0,g.colorModeA) ;
    Vec4 colour_stroke = Vec4(0,0,0,g.colorModeA) ;
    float thickness = 1 ;
    //behavior
    int max_watching = 600 ;


    // STATEMENT
    boolean watching = true   ;
    boolean alive = true ;
    boolean carrion ;
    boolean calm ;
    boolean eating ;
    boolean tracking ;
    // motion
    Vec3 pos, motion, dir ;
    // watching variable
    int size_target ;
    int time_watching = 0 ;
    // MISC
    int dead_since = 0 ;

    /**
    Constructor Dynamic Agent
    @param Vec3 pos, git the x,y,z coord of the agent
    @param int size, give a data to give size to the agent
    @param int life, give the life and and use to give the maximum life of the agent
    @param int velocity, give the maximum of motion speed of your agent.
    @param String name... no comment !
    */
    Agent_dynamic(Vec3 pos, int size, int life, int velocity, String name) {
      this.name = name ;
      this.ID = int(random(INT_MAX)) ;

      this.size = this.size_ref = this.size_max = size ;
      this.life_max = this.life = life ;

      this.pos = Vec3(pos) ;
      this.velocity = this.velocity_ref = velocity ;
      motion = Vec3(pos) ; ;
      dir = Vec3("RANDOM",1) ;
      velocity_xyz = Vec3() ;

      // statement
      step_hunger = (size + life)/2 *((life_expectancy -age)/life_expectancy) ;
      hunger = 0 ;
      meat_quality = 1 ;
    }



    /**
    //SET AGENT
    */
    /**
    set food
    */
    void set_greed(int greed) {
      this.greed = int(greed *CLOCK) ;
    }

    void set_starving(int starving) {
      this.starving = starving ;
    }

    void set_gourmet(float gourmet) {
      this.gourmet = abs(gourmet) +1.1 ;
    }

    void set_meat_quality(int meat_quality) {
      this.meat_quality = meat_quality ;
    }

    void set_step_hunger(float step_hunger) {
      this.step_hunger = int(size *step_hunger) ;
    }

    void set_hunger(int hunger) {
      this.hunger = hunger ;
    }

    void set_speed_eating(int speed_eating) {
      this.speed_eating = 1 ;
    }

    void set_digestion(int digestion) {
      if(digestion <= 0) {
        println("Please use a positive value !") ;
        this.digestion = 1 ;
      } else {
        this.digestion = digestion ;
      }
    }

   
    // set misc behavior
    void set_aspect(Vec4 colour_fill, Vec4 colour_stroke, float thickness) {
      this.colour_fill.set(colour_fill) ;
      this.colour_stroke.set(colour_stroke) ;
      this.thickness = thickness ;
    }

    void set_fill(Vec4 colour_fill) {
      this.colour_fill.set(colour_fill) ;
    }

    void set_stroke(Vec4 colour_stroke) {
      this.colour_stroke.set(colour_stroke) ;
    }

    void set_thickness(float thickness) {
      this.thickness = thickness ;
    }



    // set caracteristic

    void set_size(int size) {
      this.size = size ;
    }

    void set_alive(boolean alive) {
      this.alive = alive ;
    }

    void set_watching(int  max_watching) {
      this.max_watching = max_watching ;
    }






    
    /**
    // MOTION
    */
    void rebound(Vec6 l, boolean rebound_on_limit) {
      if(ENVIRONMENT == 2 ) rebound(l.a, l.b, l.c, l.d, 0, 0, rebound_on_limit) ;
      else if(ENVIRONMENT == 3) rebound(l.a, l.b, l.c, l.d, l.e, l.f,  rebound_on_limit) ;
    }
    
    void rebound(float left, float right, float top, float bottom, float front, float back, boolean rebound_on_limit) {
      Vec3 pos_temp = Vec3(pos.x, pos.y,pos.z);
      Vec3 dir_temp = Vec3(dir.x, dir.y, dir.z);
      
      if(rebound_on_limit) {
        dir_temp.set(rebound(left, right, top, bottom, front, back, pos_temp, dir_temp)) ;
        dir.set(dir_temp) ;
      } else {
        Vec3 motion_temp = Vec3(motion.x, motion.y,motion.z) ;
        motion_temp.set(jump(left, right, top, bottom, front, back, motion_temp)) ;
        motion.set(motion_temp) ;
      }
    }


    // local method
    Vec3 rebound(float left, float right, float top, float bottom, float front, float back, Vec3 pos, Vec3 dir) {
      // here we use size to have a physical rebound
      int effect = size ;
      left -=effect ;
      right +=effect ;
      top -=effect ;
      bottom +=effect ;
      front -=effect;
      back +=effect;

      // detection x
      if(pos.x > right ) dir.x *= -1 ;
      else if (pos.x < left ) dir.x *= -1 ;
      // detection y
      if(pos.y > bottom) dir.y *= -1 ;
      else if (pos.y < top ) dir.y *= -1 ;
      // detection z
      if(pos.z > front) dir.z *= -1 ;
      else if (pos.z < back ) dir.z *= -1 ;
      return Vec3(dir) ;
    }


    Vec3 jump(float left, float right, float top, float bottom, float front, float back, Vec3 motion) {
      // here we use sense_view to find a good jump
      int effect = sense_view ;
      left -=effect ;
      right +=effect ;
      top -=effect ;
      bottom +=effect ;
      front -=effect;
      back +=effect;

      if(motion.x > right ) motion.x = left ;
      else if (motion.x < left ) motion.x = right ;
      // detection y
      if(motion.y > bottom) motion.y = top ;
      else if (motion.y < top ) motion.y = bottom  ;
      // detection z
      if(motion.z > back) motion.z = front ;
      else if (motion.z < front ) motion.z = back ;
      return Vec3(motion) ;
    }



    void motion() {
      velocity_xyz.set(velocity) ;
      velocity_xyz.mult(dir) ;
      motion.add(velocity_xyz) ;
    }
    
    void set_position() {
      if(ENVIRONMENT == 2 ) pos.set(motion.x, motion.y, 0) ; else if(ENVIRONMENT == 3 ) pos.set(motion.x, motion.y, motion.z) ;
    }








    /**
    // STATEMENT
    */
    void statement() {
      time_to_eat() ;
      if(calm) velocity = 0 ; else velocity = velocity_ref ;

      // corpse
      if(life <= 0) {
        alive = false ;
        life = 0 ;
      }
      if(!alive) dir.set(Vec3(0)) ;

      // health
      if(life > life_max) {
        life = life_max ;
      }

      
    }

    // local method
    int start_eating ;
    void time_to_eat() {
      if(hunger < step_hunger) {
        calm = false ;
        start_eating = frameCount ; 
      } else {
        int time_to_stop_eating = start_eating +greed ;
        if (time_to_stop_eating > frameCount) calm = true ; 
      }

    }
    

    void carrion() {
      int threshold = 2 ;
      if(!alive) {
        dead_since += int(1. *CLOCK) ;
        if(size < size_ref / threshold || dead_since > (TIME_TO_BE_CARRION *frameRate)) carrion = true ; 
        else carrion = false ;
      } 
    }



    void hunger() {
      if(frameCount%(1 +int(frameRate *CLOCK)) == 0) {
        hunger -= starving ;
        if(hunger <= 0) life -= starving ;
      }
    }














    /**
    // ASPECT
    */
    void aspect(float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(colour_fill) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(colour_stroke) ;
        fill(colour_fill) ;
      }
    }
    void aspect(Vec4 c_fill, Vec4 c_stroke, float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(c_fill) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(c_stroke) ;
        fill(c_fill) ;
      }
    }
   
    /**
    // costume
    */
    void costume_agent(int ID_costume) {
      costume(pos, size, ID_costume) ;
    }
    
    



    /**
    // void info
    */
    void info_visual(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(0), colour, 1) ;
      matrix_start() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      matrix_end() ;
    }

    void info_text(Vec4 colour, int size_text) {
      aspect(colour, colour, 1) ;
      Vec2 pos_text = Vec2(0) ;
      matrix_start() ;
      translate(pos) ;
      textSize(size_text) ;
      textAlign(CENTER) ;
      text(name, pos_text.x, pos_text.y) ;
      text(life + " " + size + " " + size_ref, pos_text.x, pos_text.y +(size_text *1.2) ) ;
      textSize(16) ;
      if(alive) {
        if (eating) {
          text("I'm eating", pos_text.x, pos_text.y +(size_text *2.4) ) ;
        } else {
          if(calm) text("I'm cool", pos_text.x, pos_text.y +(size_text *2.4) ) ; 
          if(!calm) text("I'm hungry", pos_text.x, pos_text.y +(size_text *2.4) ) ;
        }
      } else {
        if(!carrion) text("I'm dead", pos_text.x, pos_text.y +(size_text *2.4) ) ; else text("I'm carrion", pos_text.x, pos_text.y +(size_text *2.4) ) ;
      }
      matrix_end() ;
    }

    void info_print_agent() {
      // basic Agent info
      println(this.name + " " +this.getClass().getSimpleName()) ;
      info_print_agent_structure() ;
      info_print_agent_motion() ;
      info_print_agent_statement() ;
    }
    void info_print_agent_structure() {
      println("CARACTERISTIC",this.name) ;
      println(this.name, "size", this.size) ;
      println(this.name, "life", this.life) ;
      println(this.name, "meat quality", this.meat_quality) ;
      println(this.name, "Food exigency", this.gourmet) ;

    }

    void info_print_agent_motion() {
      println("MOTION",this.name) ;
      println(this.name, "velocity", this.velocity_ref) ;
      println(this.name, "current velocity", this.velocity) ;
      println(this.name, "position", this.pos) ;
      println(this.name, "direction", this.dir) ;
      println(this.name, "motion", this.motion) ;
    }


    void info_print_agent_statement() {
      println("STATEMENT",this.name) ;
      println(this.name, "alive", this.alive) ;
      println(this.name, "carrion", this.carrion) ;
      println(this.name, "calm", this.calm) ;
      println(this.name, "eating", this.eating) ;
      println(this.name, "hunger", this.hunger) ;
      println(this.name, "watching", this.watching) ;
      println(this.name, "tracking", this.tracking) ;

    }
  }
  /**
  END AGENT DYNAMIC
  */