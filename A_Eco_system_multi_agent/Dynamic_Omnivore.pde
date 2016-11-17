/**
Build Omnivore 0.0.1
*/
void build_omnivore(ArrayList<Agent> list, Info_dict carac, Info_obj style, int num) {
  int gender = 0 ;
  for(int i = 0 ; i < num ; i++) {
    if(gender > 1) gender = 0 ;
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      // add_omnivore(list_h, pos, carac.get("size"), carac.get("stamina"), carac.get("life"), carac.get("velocity"), carac.get("sense_range"), name, gender, carac.get("nutrient_quality"), colour) ;
      add_omnivore(list, pos, carac, gender, style) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_omnivore(list, pos, carac, gender, style) ;
    }
    gender++ ;
  }
}

void add_omnivore(ArrayList<Agent> list, Vec2 pos, Info_dict carac, int gender, Info_obj style) {
   Vec3 final_pos = Vec3(pos) ;
   add_omnivore(list, final_pos, carac, gender, style) ;
}

void add_omnivore(ArrayList<Agent> list, Vec3 pos, Info_dict carac, int gender, Info_obj style) {
  // send data to constructor
  // Agent o = new Omnivore(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
  Agent o = new Omnivore(carac, style, gender) ;

  list.add(o) ;
  set_omnivore(o, pos, carac, style) ;
}

/**
local method
*/
/**
set
*/
void set_omnivore(Agent a, Vec3 pos, Info_dict carac, Info_obj style) {
  int attack = (int) carac.get("attack")[0].catch_obj(0) ;
  float gourmet = (float) carac.get("gourmet")[0].catch_obj(0) ;
  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;
  int starving = (int) carac.get("starving")[0].catch_obj(0) ;
  float digestion = (float) carac.get("digestion")[0].catch_obj(0) ;

  a.set_costume((int)style.catch_obj(0)) ;
  a.set_fill((Vec4)style.catch_obj(1)) ;
  a.set_stroke((Vec4)style.catch_obj(2)) ;
  a.set_thickness((float)style.catch_obj(3)) ;
  a.set_pos(pos) ;
  a.set_nutrient_quality(nutrient_quality) ;

  if(a instanceof Agent_dynamic) {
    Agent_dynamic a_d = (Agent_dynamic) a ;
    a_d.set_attack(attack) ;
    a_d.set_gourmet(gourmet) ;
    a_d.set_starving(starving) ;
    a_d.set_digestion(digestion) ;
    // set_omnivore(n_a, pos, nutrient_quality, colour) ;
  }
}


/**
Female Reproduction
*/
void reproduction_female_omnivore(ArrayList<Agent> list_female, ArrayList<Agent> list_male, ArrayList<Agent> list_child, Info_dict carac, Info_obj style) {
  // int count_female_fertile = 0 ;
  for (Agent female : list_female) {
    if(female instanceof Agent_dynamic) {
      Agent_dynamic f = (Agent_dynamic) female ;
      f.fertility(frameCount) ;
      if(f.fertility) {
        // count_female_fertile++ ;
        if (check_male_reproducer(female, list_male)) {
          f.reproduction() ;
        }
      } 
      f.pregnant() ;

      if(f.birth()) {
        delivery(f, f.genome, f.genome_father, list_child, carac, style) ;
      }
    }
  }
}







/**
Omnivore update 0.0.1
*/

void omnivore_update(ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    update_die(list) ;
    update_growth(list) ;
    update_motion(list) ;
    update_statement(list) ;
    if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
  }
}









/**
SCALE 0.0.1
*/
/*
void scale_herbivore(ArrayList<Herbivore> list_h, float scale) {
  for(Herbivore h : list_h) {
    h.size = h.size_ref ;
    h.size *= scale ;
  }
}
*/





















/**
  SUB CLASS HERBIVORE 0.2.1



  */
  class Omnivore extends Agent_dynamic {
    /*
    Omnivore(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, Vec2 sex_appeal, int gender) {
      super(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
      */
    Omnivore(Info_dict carac, Info_obj style, int gender) {
      super(carac, style, gender) ;
      // not in the genome
      set_kill_skill(size) ;
    }


    Omnivore(Genome mother, Genome father, Info_obj style) {
      super(mother,father, style) ;
      // not in the genome
      set_kill_skill(size) ;
    }

    void set_kill_skill(int size) {
    	kill_zone = int(size *2) +size ;
    	eat_zone = int(size *1.2) ;
    }




    /**
    info
    */
    void info_visual(Vec4 colour) {
      aspect(Vec4(),colour_info(colour, satiate, pregnant, fertility), 1) ;
      Vec3 pos_temp = Vec3(0) ;
      start_matrix() ;
      translate(pos) ;
      ellipse(pos_temp.x, pos_temp.y, sense_range*2, sense_range*2) ;
      ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
      ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
      stop_matrix() ;
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


