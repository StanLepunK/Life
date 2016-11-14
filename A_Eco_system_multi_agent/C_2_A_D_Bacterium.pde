/**
METHOD BACTERIUM


*/

/**
BUILD BACTERIUM 0.1.0
*/
void build_bacterium(ArrayList<Agent> list, Info_dict carac, Vec4 colour, int num) {
  for(int i = 0 ; i < num ; i++) {
    String name = "bacterium" ;
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_bacterium(list, pos, carac, colour) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_bacterium(list, pos, carac, colour) ;
    }
  }
}

void add_bacterium(ArrayList<Agent> list, Vec2 pos, Info_dict carac, Vec4 colour) {
  Vec3 final_pos = Vec3(pos) ; // in case 2D world
  add_bacterium(list, final_pos, carac, colour) ;
}

void add_bacterium(ArrayList<Agent> list, Vec3 pos, Info_dict carac, Vec4 colour) {
  int gender = 0 ;
  Agent b = new Bacterium(carac, gender) ;
  list.add(b) ;
  set_bacterium(b, pos, carac, colour) ;
}




void set_bacterium(Agent c, Vec3 pos, Info_dict carac, Vec4 colour) {
  float digestion = (float) carac.get("digestion")[0].catch_a() ;
  int starving = (int) carac.get("starving")[0].catch_a() ;
  c.set_pos(pos) ;
  c.set_fill(colour) ;
  c.set_stroke(colour) ;

  if(c instanceof Agent_dynamic) {
    Agent_dynamic a_d = (Agent_dynamic) c ;
    a_d.set_digestion(digestion) ;
    a_d.set_starving(starving) ;
  }
}



/**
set colour bacterium
*/
boolean original_bacterium_aspect = true ;
Vec4 fill_colour_bacterium, stroke_colour_bacterium ;
float thickness_bacterium ; 
void set_aspect_bacterium(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_bacterium_aspect = false ;
  if(fill_colour_bacterium == null) fill_colour_bacterium = Vec4(fill_colour) ; else fill_colour_bacterium.set(fill_colour) ;
  if(stroke_colour_bacterium == null) stroke_colour_bacterium = Vec4(stroke_colour) ; else stroke_colour_bacterium.set(stroke_colour) ;
  thickness_bacterium = thickness ;
}




  /**
Bacterium update 0.1.1
*/
void bacterium_update(ArrayList<Agent> list, ArrayList<Agent> list_dead_body, Biomass biomass, boolean info) {
  update_die(list) ;
  update_motion(list) ;
  update_statement(list) ;
  bacterium_update_feed(list, list_dead_body, biomass, info) ;
  if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
}

/**
show bacterium specific method
*/
void show_bacterium(Biomass biomass, boolean info, ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    if(!info) update_aspect(list, original_bacterium_aspect, fill_colour_bacterium, stroke_colour_bacterium, thickness_bacterium) ;
    if(info) {
      info_agent(list) ;
      info_agent_track_line(list) ;
    }
  }
}



/**
scale
*/
/*
void scale_bacterium(ArrayList<Bacterium> list_b, float scale) {
  for(Bacterium b : list_b) {
    b.size = b.size_ref ;
    b.size *= scale ;
  }
}
*/

/**
Bacterium update

*/
void bacterium_update_feed(ArrayList<Agent> list_b, ArrayList<Agent> list_dead_body, Biomass biomass, boolean info) {
  for(Agent a : list_b) {
    if(a instanceof Bacterium) {
      Bacterium b = (Bacterium) a ;
      if(!b.satiate && list_dead_body.size() >= 0) {
        hunt_dead_agent(b, list_dead_body, info) ;
      }
      if(list_dead_body.size() >= 0 ) {
        eat_corpse(b, list_dead_body, biomass, info) ; 
      } else { 
        b.eating = false ;
      }
      b.hunger() ;
    }
  }
}


/**
local method
*/
void eat_corpse(Bacterium b, ArrayList<Agent> list_target, Biomass biomass, boolean info) {
// first eat the agent who eat just before without look in the list
  if(b.eating) {
    int pointer = (int)b.ID_target.x ;
    int ID_target = (int)b.ID_target.y ;
    /* here we point directly in a specific point of the list, 
    if the pointer is superior of the list, 
    because if it's inferior a corpse can be eat by an other Agent */
    if(pointer < list_target.size() ) {
      Agent target = list_target.get((int)b.ID_target.x) ;
      /* if the entry point of the list return an agent 
      with a same ID than a ID_target corpse eat just before, 
      the Carnivore can continue the lunch */
      if (target instanceof Agent_static && target.get_ID() == ID_target) {
        Agent_static target_meat = (Agent_static) target ;
        b.eat(target_meat, info) ;
        biomass.humus_update(b.get_humus_production()) ;
        //biomass.humus += b.get_humus_production() ;
      } else {
        /* If the ID returned is different, a corpse was leave from the list, 
        and it's necessary to check in the full ist to find if any corpse have a seme ID */
        for(Agent target_in_list : list_target) {
          if (target_in_list instanceof Agent_static && target_in_list.get_ID() == ID_target ) {
            Agent_static target_meat = (Agent_static) target_in_list ;
            b.eat(target_meat, info) ; 
          } else b.eating = false ;
        }
      }
    }
  /* If the last research don't find the corpse, may be this one is return to dust ! */
  } else {
    for(Agent target : list_target) {
      if(target instanceof Agent_static) {
        Agent_static target_meat = (Agent_static) target ;
        b.eat(target_meat, info) ;
      }

      if(b.eating) {
        b.ID_target.set(list_target.indexOf(target),target.get_ID()) ;
        break ;
      }
    }
  }
}


void hunt_dead_agent(Bacterium b, ArrayList<Agent> list_target, boolean info) {
  for(Agent target : list_target) {
    if(target instanceof Agent_static) {
      Agent_static target_dead = (Agent_static) target ;
      b.watch(target_dead, info) ;
      b.pick(target_dead) ;
      if(b.picking()) break ;
    }
  }
}
/**
End bacterium
*/




















/**
  SUB CLASS BACTERIUM 0.2.0




  */
  class Bacterium extends Agent_dynamic {
    float humus_prod_ratio = .25 ;
    float humus_production  ;
     Vec2 sex_appeal = Vec2() ;

    /*
    Bacterium(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, int gender) {
      super(size, stamina, life_expectancy, velocity, sense_range, name, Vec2(), gender) ;
      */
    Bacterium(Info_dict carac, int gender) {
      super(carac, gender) ;
      set_kill_skill(size) ;
    }
    
    // intern
    void set_kill_skill(int size) {
      eat_zone = int(size *2) ;
    }
    
    // extern
    void set_humus_prod(float prod) {
      this.humus_prod_ratio = prod ;
    }



    void watch(Agent_static a, boolean info) {
      if(dist(a.pos,pos) < sense_range && !a.alive ) {
        pos_target.set(a.pos) ;
        watching = false ; 
      } else {
        watching = true ;
      }
    }




     // Method
    void eat(Agent_static target, boolean info) {
      humus_production = 0 ;
      if(dist(target.pos,pos) < eat_zone ) {
        pos_target.set(target.pos) ;
        float calories = speed_feeding *humus_prod_ratio ;

        target.size -= speed_feeding ;
        hunger += (calories *digestion) ;
        humus_production = calories *humus_prod_ratio ;
        stamina += (calories *.75) ;
        eating = true ;
      } else {
        eating = false ;
      }
    }

    float get_humus_production() {
      return humus_production ;
    }


    void pick(Agent_static a) {
      if (!watching) dir.set(target_direction(a.pos,pos)) ; 
    }

    boolean picking() {
      if (watching) return false ; else return true ;
    }
    

    /**
    info
    */
    void info_visual(Vec4 colour) {
      aspect(Vec4(), colour_info(colour, satiate, pregnant, fertility), 1) ;
      Vec3 pos_temp = Vec3 (0) ;
      start_matrix() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, sense_range*2, sense_range*2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      stop_matrix() ;
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