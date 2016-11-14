/**
METHOD



*/

/**
CARNIVORE build 0.1.0
*/

void build_carnivore(ArrayList<Agent> list, Info_dict carac, Vec4 colour, int num) {
  int gender = 0 ;
  for(int i = 0 ; i < num ; i++) {
    if(gender > 1) gender = 0 ;
    String name = "ALIEN" ;
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_carnivore(list, pos, carac, gender, colour) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_carnivore(list, pos, carac, gender, colour) ;
    }
    gender++ ;
  }
}

void add_carnivore(ArrayList<Agent> list, Vec2 pos, Info_dict carac, int gender, Vec4 colour) {
   Vec3 final_pos = Vec3(pos) ;
   add_carnivore(list, final_pos, carac, gender, colour) ;
}
void add_carnivore(ArrayList<Agent> list, Vec3 pos, Info_dict carac, int gender, Vec4 colour) {
    // recover data
    /*
  String name = (String) carac.get("name")[0].catch_a() ;
  int size = (int) carac.get("size")[0].catch_a() ;
  int stamina = (int)carac.get("stamina")[0].catch_a() ;
  int velocity = (int)carac.get("velocity")[0].catch_a() ;
  int sense_range = (int) carac.get("sense_range")[0].catch_a() ;
  int life_expectancy =(int) carac.get("life_expectancy")[0].catch_a() ;
  Vec2 sex_appeal = (Vec2)carac.get("sex_appeal")[0].catch_a() ;
  */
  // send data to constructor
  // Agent c = new Carnivore(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
  Agent c = new Carnivore(carac, gender) ;
  list.add(c) ;
  set_carnivore(c, pos, carac, colour) ;

}

void set_carnivore(Agent c, Vec3 pos, Info_dict carac, Vec4 colour) {
  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_a() ;
  int attack = (int) carac.get("attack")[0].catch_a() ;
  float gourmet = (float) carac.get("gourmet")[0].catch_a() ;
  int starving = (int) carac.get("starving")[0].catch_a() ;
  float digestion = (float) carac.get("digestion")[0].catch_a() ;
  c.set_pos(pos) ;
  c.set_nutrient_quality(nutrient_quality) ;
  c.set_fill(colour) ;
  c.set_stroke(colour) ;

  if(c instanceof Agent_dynamic) {
    Agent_dynamic a_d = (Agent_dynamic) c ;
    a_d.set_attack(attack) ;
    a_d.set_gourmet(gourmet) ;
    a_d.set_starving(starving) ;
    a_d.set_digestion(digestion) ;
  }
}


/**
set colour carnivore
*/
boolean original_carnivore_aspect = true ;
Vec4 fill_colour_carnivore, stroke_colour_carnivore ;
float thickness_carnivore ; 
void set_aspect_carnivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_carnivore_aspect = false ;
  if(fill_colour_carnivore == null) fill_colour_carnivore = Vec4(fill_colour) ; else fill_colour_carnivore.set(fill_colour) ;
  if(stroke_colour_carnivore == null) stroke_colour_carnivore = Vec4(stroke_colour) ; else stroke_colour_carnivore.set(stroke_colour) ;
  thickness_carnivore = thickness ;
}

/**
scale
*/
/*
void scale_carnivore(ArrayList<Carnivore> list_c, float scale) {
  for(Carnivore c : list_c) {
    c.size = c.size_ref ;
    c.size *= scale ;
  }
}
*/


/**
Female Reproduction
*/
void reproduction_female_carnivore(ArrayList<Agent> list_female, ArrayList<Agent> list_male, ArrayList<Agent> list_child, Info_dict carac) {
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
        delivery(f, f.genome, f.genome_father, list_child, carac) ;
      }
    }
  }
}









  /**
CARNIVORE update 0.2.0
*/
void carnivore_update(ArrayList<Agent>... all_list) {
  for(ArrayList list : all_list) {
    update_die(list) ;
    update_growth(list) ;
    update_motion(list) ;
    update_statement(list) ;
    if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
  }
}



/**
End carnivore update
*/

















/**
SUB CLASS CARNIVORE 0.2.1




*/
class Carnivore extends Agent_dynamic {


/*
  Carnivore(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, Vec2 sex_appeal, int gender) {
    super(size, stamina, life_expectancy, velocity, sense_range, name, sex_appeal, gender) ;
    */
      Carnivore(Info_dict carac, int gender) {
    super(carac, gender) ;
    // not in the genome
    set_kill_skill(size) ;

  }

  Carnivore(Genome mother, Genome father) {
    super(mother,father) ;
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
    Vec3 pos_temp = Vec3(0) ;
    aspect(Vec4(), colour_info(colour, satiate, pregnant, fertility), 1) ;
    matrix_start() ;
    translate(pos) ;
    // info feed
    ellipse(pos_temp.x, pos_temp.y, sense_range*2, sense_range*2) ;
    ellipse(pos_temp.x, pos_temp.y, kill_zone *2, kill_zone *2) ;
    ellipse(pos_temp.x, pos_temp.y, eat_zone *2, eat_zone *2) ;
    ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
    // info reproduction
    matrix_end() ;
  }

  // print
  void info_print_carnivore() {
    println("INFO",this.name) ;
    println("time track", int(time_track));
  }
}
/**
END SUB CLASS CARNIVORE
*/
