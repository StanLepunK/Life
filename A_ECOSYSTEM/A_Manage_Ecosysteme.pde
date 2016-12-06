/**
MANAGE ECO-SYSTEM BUILT 0.2.0
*/

/**
ECOS_SYSTEM setting

*/

// LIST
ArrayList<Agent> FLORA_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> BACTERIUM_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> OMNIVORE_CHILD_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> OMNIVORE_FEMALE_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> OMNIVORE_MALE_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> HERBIVORE_CHILD_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> HERBIVORE_FEMALE_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> HERBIVORE_MALE_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> CARNIVORE_CHILD_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> CARNIVORE_FEMALE_LIST = new ArrayList<Agent>() ;
ArrayList<Agent> CARNIVORE_MALE_LIST = new ArrayList<Agent>() ;

ArrayList<Agent> DEAD_LIST = new ArrayList<Agent>() ;

// QUANTITY
int num_flora = 80 ;
int num_herbivore = 50 ; 
int num_omnivore = 0 ; 
int num_carnivore = 0 ; 
int num_bacterium = 6 ;
int num_dead = 0 ;

// Colour
Info_obj style_carnivore, style_herbivore, style_omnivore ;
Info_obj style_flora ;
Info_obj style_dead ;
Info_obj style_bacterium ;


Info_dict flora_carac = new Info_dict() ;
Info_dict herbivore_carac = new Info_dict() ;
Info_dict omnivore_carac = new Info_dict() ;
Info_dict carnivore_carac = new Info_dict() ;
Info_dict bacterium_carac = new Info_dict() ;
Info_dict dead_carac = new Info_dict() ;





// main method
void ecosystem_setting(Biomass b) {
  clear_agent() ;
  set_caracteristic_agent() ;
  b.set_humus(BOX.x *BOX.y *.01) ;
  

  // FLORA
  // int costume = ELLIPSE_ROPE ;
  int costume = VIRUS_3_4_64_ROPE ;
  float thickness = 1. ;

  Vec4 fill_flora = Vec4(color_flora) ;
  Vec4 stroke_flora = Vec4(color_flora) ;
  Vec3 alpha_behavior_flora = Vec3(pos_final_dna.z, -.4, .8) ;
  style_flora = new Info_obj("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora) ;  

  // HERBIVORE
  costume = POINT_ROPE ;
  Vec4 fill_herbivore = Vec4(color_herbivore) ;
  Vec4 stroke_herbivore = Vec4(color_herbivore) ;
  Vec3 alpha_behavior_herbivore = Vec3(0, -1, 1) ;
  style_herbivore = new Info_obj("Herbivore Aspect", costume, fill_herbivore, stroke_herbivore, thickness, alpha_behavior_herbivore) ;
  
  // OMNIVORE
  costume = PENTAGON_ROPE ;
  Vec4 fill_omnivore = Vec4(150, 100, 80, 100) ;
  Vec4 stroke_omnivore = Vec4(150, 100, 80, 100) ;
  style_omnivore = new Info_obj("Omnivore Aspect", costume, fill_omnivore, stroke_omnivore, thickness) ;

  // CARNIVORE
  costume = HEPTAGON_ROPE ;
  Vec4 fill_carnivore = Vec4(0, 100, 100, 100) ;
  Vec4 stroke_carnivore = Vec4(0, 100, 100, 100) ;
  style_carnivore = new Info_obj("Carnivore Aspect", costume, fill_carnivore, stroke_carnivore, thickness) ;
  
  // BACTERIUM
  costume = ELLIPSE_ROPE ;
  Vec4 fill_bacterium = Vec4(30, 0, 30, 100) ;
  Vec4 stroke_bacterium = Vec4(30, 0, 30, 100) ;
  style_bacterium = new Info_obj("Bacterium Aspect", costume, fill_bacterium, stroke_bacterium, thickness) ;
  

  // DEAD
  costume = CROSS_2_ROPE ;
  Vec4 fill_dead = Vec4(0, 0, 30, 100) ;
  Vec4 stroke_dead = Vec4(0, 0, 30, 100) ;
  style_dead = new Info_obj("Dead Aspect", costume, fill_dead, stroke_dead, thickness) ;
  




  // classic radom drop zone
  // build_flora(FLORA_LIST, flora_carac, style_flora, num_flora) ;

  //drop zone from list of point
  build_flora(FLORA_LIST, flora_carac, style_flora, num_flora, drop_zone_flora_list) ;

  build_herbivore(HERBIVORE_CHILD_LIST, herbivore_carac, style_herbivore, num_herbivore) ;
  build_omnivore(OMNIVORE_CHILD_LIST, omnivore_carac, style_omnivore, num_omnivore) ;
  build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore, num_carnivore) ;
  build_bacterium(BACTERIUM_LIST, bacterium_carac, style_bacterium, num_bacterium) ;
  build_dead(DEAD_LIST, dead_carac, style_dead, num_dead) ;
}









// control
void control_population_via_frameRate(int level, int num) {
  if(frameRate < level) {
    spawn_carnivore(num) ;
    DEAD_LIST.clear() ;

  } else {
    if (HERBIVORE_CHILD_LIST.size() + HERBIVORE_FEMALE_LIST.size() +HERBIVORE_MALE_LIST.size() < num_herbivore ) {
      CARNIVORE_CHILD_LIST.clear() ;
      CARNIVORE_FEMALE_LIST.clear() ;
      CARNIVORE_MALE_LIST.clear() ;
    }
  }
}













// local
void clear_agent() {
  flora_carac.clear() ;
  herbivore_carac.clear() ;
  carnivore_carac.clear() ;
  omnivore_carac.clear() ;
  bacterium_carac.clear() ;
  dead_carac.clear() ;

  FLORA_LIST.clear() ;

  BACTERIUM_LIST.clear() ;

  HERBIVORE_CHILD_LIST.clear() ;
  HERBIVORE_FEMALE_LIST.clear() ;
  HERBIVORE_MALE_LIST.clear() ;

  OMNIVORE_CHILD_LIST.clear() ;
  OMNIVORE_FEMALE_LIST.clear() ;
  OMNIVORE_MALE_LIST.clear() ;

  CARNIVORE_CHILD_LIST.clear() ;
  CARNIVORE_FEMALE_LIST.clear() ;
  CARNIVORE_MALE_LIST.clear() ;

  DEAD_LIST.clear() ;
}


void set_caracteristic_agent() {
  flora_carac.add("name", "Salad") ;
  flora_carac.add("size", 50) ;
  flora_carac.add("life_expectancy", 1000000 *60) ;
  flora_carac.add("nutrient_quality", 15) ;
  flora_carac.add("speed_growth", 2) ; // size point per cycle
  flora_carac.add("need", .3) ;

  herbivore_carac.add("name", "Sheep") ;
  herbivore_carac.add("size", 20) ;
  herbivore_carac.add("stamina", 100) ;
  herbivore_carac.add("life_expectancy", 1000 *60) ;
  herbivore_carac.add("velocity", 6) ;
  herbivore_carac.add("nutrient_quality", 40) ;
  herbivore_carac.add("sense_range", 4000) ;
  herbivore_carac.add("gourmet", 3.5) ;
  herbivore_carac.add("starving", 4) ;
  herbivore_carac.add("digestion", 2.5) ;
  herbivore_carac.add("sex_appeal", Vec2(40, 5)) ;
  herbivore_carac.add("multiple_pregnancy", 50.) ;

  omnivore_carac.add("name", "Human") ;
  omnivore_carac.add("size", 25) ; // in pixel
  omnivore_carac.add("stamina", 200) ; // point of life
  omnivore_carac.add("life_expectancy", 800 *60) ; // frame of live before die
  omnivore_carac.add("velocity", 8) ; // in pixel
  omnivore_carac.add("nutrient_quality", 20) ; // multi the stamina point to give the calories
  omnivore_carac.add("sense_range", 1000) ; // range in pixel
  omnivore_carac.add("gourmet", 2.5) ; 
  omnivore_carac.add("attack", 5) ; // attack point
  omnivore_carac.add("starving", 3) ; 
  omnivore_carac.add("digestion", 6.5) ; // calorie multiplicator, hight is good.
  omnivore_carac.add("sex_appeal", Vec2(45, 4)) ; // multe the size to give the range in pixel
  omnivore_carac.add("multiple_pregnancy", 10.5) ; // chance to have twin or better in pourcent

  carnivore_carac.add("name", "Alien") ;
  carnivore_carac.add("size", 40) ;
  carnivore_carac.add("stamina", 400) ;
  carnivore_carac.add("life_expectancy", 1200 *60) ;
  carnivore_carac.add("velocity", 10) ;
  carnivore_carac.add("nutrient_quality", 20) ;
  carnivore_carac.add("sense_range", 1200) ;
  carnivore_carac.add("gourmet", 2.5) ;
  carnivore_carac.add("attack", 10) ;
  carnivore_carac.add("starving", 4) ;
  carnivore_carac.add("digestion", 4.5) ;
  carnivore_carac.add("sex_appeal", Vec2(30, 10)) ;
  carnivore_carac.add("multiple_pregnancy", 5.5) ;


  bacterium_carac.add("name", "Gnak Gnak") ;
  bacterium_carac.add("size", 2) ;
  bacterium_carac.add("stamina", 200) ;
  bacterium_carac.add("life_expectancy", 800 *60) ;
  bacterium_carac.add("velocity", 5) ;
  bacterium_carac.add("nutrient_quality", 1) ;
  bacterium_carac.add("sense_range", 2000) ;
  bacterium_carac.add("starving", 2) ;
  bacterium_carac.add("digestion", 12.5) ;


  dead_carac.add("name", "UNDEAD") ;
  dead_carac.add("size", 25) ;
  dead_carac.add("nutrient_quality", 40) ;
}



/**
SPAWN carnivore
*/
// annecdotic method
void spawn_carnivore(int num_carnivore) {
    if(CARNIVORE_CHILD_LIST.size() < num_carnivore) {
    int population_target = HERBIVORE_CHILD_LIST.size() + HERBIVORE_FEMALE_LIST.size() +  HERBIVORE_MALE_LIST.size() ;
    if(population_target > num_herbivore && frameCount%(5 *(int)frameRate) == 0 ) {
      int num = ceil(random(num_carnivore)) ;
      build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore, num) ;
    }
  }
}










/**
ENVIRONMENT 0.0.3

*/


boolean HORIZON_ALPHA = false ;
int HORIZON = 0 ;
Vec3 BOX = Vec3(100,100,100) ;
Vec3 BOX_POS = Vec3() ;
Vec6 LIMIT = Vec6(0,BOX.x,0,BOX.y,0,BOX.z) ;
boolean REBOUND ;
int SIZE_TEXT_INFO ;
int ENVIRONMENT = 3 ; // 2 is for 2D, 3 for 3D

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


  HORIZON = int(abs(back) +abs(front)) ;
  REBOUND = false ;
  SIZE_TEXT_INFO = 18 ;
  // b.set_humus(BOX.x *BOX.y *.01) ;
  // b.humus_max = b.humus = BOX.x *BOX.y *.01 ;
}

void set_horizon(boolean horizon) {
  HORIZON_ALPHA = horizon ;
}



/**
SET ENVIRONMENT
*/
Biomass biomass ;
boolean init_ecosystem = true ;

void set_environment() {
  ENVIRONMENT = 3 ;
  biomass = new Biomass() ;
  
  if (ENVIRONMENT == 3) {
    Vec3 pos_box = Vec3(width/2,height/2,0) ;
    int scale_box = 2 ;
    Vec3 size_box = Vec3(width *scale_box,height *scale_box,width *scale_box) ;
    build_environment(pos_box, size_box) ;
  } else {
    Vec2 pos_box = Vec2(width/2,height/2) ;
    Vec2 size_box = Vec2(width,height) ;
    build_environment(pos_box, size_box) ;
  }
}



/**
BIOTOPE 
*/
Vec4 biotope_colour(Biomass b) {
  float normal_humus_level = 1 - b.humus / b.humus_max ;
  float var_colour_ground = 90 *normal_humus_level ;
  return Vec4(40,90, 5 +var_colour_ground,100) ;
}



/**
BIOMASS
*/
class Biomass {
  float humus, humus_max ;
  Biomass() {}

  void humus_update(float var_humus) {
    humus +=var_humus ;
  }

  void set_humus(float humus) {
    this.humus = this.humus_max = humus ;
  }
}





















/**
UPDATE LIST
*/
void update_list() {

  // flora update
  flora_update(FLORA_LIST, biomass) ;
  // bacterium update
  bacterium_update(BACTERIUM_LIST, DEAD_LIST, biomass, INFO_DISPLAY_AGENT) ;
  // dead corpse update
  
  dead_update(DEAD_LIST) ;
 
  // dynamic agent update
  herbivore_update(HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  omnivore_update(OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  carnivore_update(CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;






  // Eating
  // carnivore eating
  eating_update(CARNIVORE_CHILD_LIST, DEAD_LIST) ;
  eating_update(CARNIVORE_FEMALE_LIST, DEAD_LIST) ;
  eating_update(CARNIVORE_MALE_LIST, DEAD_LIST) ;
  // omnivore eating
  eating_update(OMNIVORE_CHILD_LIST, DEAD_LIST) ;
  eating_update(OMNIVORE_FEMALE_LIST, DEAD_LIST) ;
  eating_update(OMNIVORE_MALE_LIST, DEAD_LIST) ;





  // hunting
  // carnivore hunt herbivorr and omnivore
  hunting_update(CARNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;

  hunting_update(CARNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  hunting_update(CARNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;

  // Omnivore hunt carnivore and herbivore
  hunting_update(OMNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;

  hunting_update(OMNIVORE_CHILD_LIST, INFO_DISPLAY_AGENT, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_FEMALE_LIST, INFO_DISPLAY_AGENT, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  hunting_update(OMNIVORE_MALE_LIST, INFO_DISPLAY_AGENT, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;


  // picking
  picking_update(HERBIVORE_CHILD_LIST, FLORA_LIST) ;
  picking_update(HERBIVORE_FEMALE_LIST, FLORA_LIST) ;
  picking_update(HERBIVORE_MALE_LIST, FLORA_LIST) ;

  picking_update(OMNIVORE_CHILD_LIST, FLORA_LIST) ;
  picking_update(OMNIVORE_FEMALE_LIST, FLORA_LIST) ;
  picking_update(OMNIVORE_MALE_LIST, FLORA_LIST) ;


  // manage Child
  manage_child(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST, HERBIVORE_CHILD_LIST) ;
  manage_child(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST, OMNIVORE_CHILD_LIST) ;
  manage_child(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST, CARNIVORE_CHILD_LIST) ;
  

  // reproduction
  reproduction_female_herbivore(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST, HERBIVORE_CHILD_LIST, herbivore_carac, style_herbivore) ;
  reproduction_male(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;

  reproduction_female_omnivore(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST, OMNIVORE_CHILD_LIST, omnivore_carac, style_omnivore) ;
  reproduction_male(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;

  reproduction_female_carnivore(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST, CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore) ;
  reproduction_male(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
}





















/**
  SHOW
*/
void show_agent() {
    // flora show
  flora_show(style_flora, FLORA_LIST) ;
  
  // dead / corpse show 
  show_dead(style_dead, DEAD_LIST) ;
  
  // dynamic agent show
  show_agent_dynamic(style_herbivore, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  show_agent_dynamic(style_carnivore, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  show_agent_dynamic(style_omnivore, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;

  show_bacterium(biomass, style_bacterium, BACTERIUM_LIST) ;

}



































/**

INFO & LOG 0.1.0

*/
int FRAME_RATE_LOG = 300 ;

boolean PRINT_DEATH_AGENT_DYNAMIC = true ;
boolean PRINT_BORN_AGENT_DYNAMIC = true ;
boolean PRINT_POPULATION = true ;

boolean INFO_DISPLAY_AGENT = false ;





void info_agent(boolean info) {
  INFO_DISPLAY_AGENT = info ;
}
/**
INFO
*/
void info_ecosystem(int tempo) {
    if(frameCount%tempo == 0) {
    if (PRINT_POPULATION) {
      print_population() ;
    }
    // print_info_environment() ;
    //print_list() ;
    // print_info_carnivore(CARNIVORE_CHILD_LIST) ;
    print_info_herbivore("Child", HERBIVORE_CHILD_LIST) ;
    print_info_herbivore("Female", HERBIVORE_FEMALE_LIST) ;
    print_info_herbivore("Male", HERBIVORE_MALE_LIST) ;
    // print_info_bacterium(BACTERIUM_LIST) ;
  }
}


/**
LOG
*/
boolean LOG_ECOSYSTEM = false ;
boolean LOG_ALL_AGENTS = false ;

boolean LOG_HERBIVORE = false ;
boolean LOG_OMNIVORE = false ;
boolean LOG_CARNIVORE = false ;
boolean LOG_FLORA = false ;
boolean LOG_BACTERIUM = false ;
boolean LOG_DEAD = false ;

void set_log_ecosystem(boolean b) { 
  LOG_ECOSYSTEM = b ;
}
void set_log_agents(boolean b) { 
  LOG_ALL_AGENTS = b ;
}

void set_log_herbivore(boolean b) { 
  LOG_HERBIVORE = b ;
}
void set_log_omnivore(boolean b) { 
  LOG_OMNIVORE = b ;
}
void set_log_carnivore(boolean b) { 
  LOG_CARNIVORE = b ;
}
void set_log_bacterium(boolean b) { 
  LOG_BACTERIUM = b ;
}
void set_log_flora(boolean b) { 
  LOG_FLORA = b ;
}
void set_log_dead(boolean b) { 
  LOG_DEAD = b ;
}



void log_ecosystem(int tempo) {

  /**
  log population
  */
  if(frameCount%tempo == 0 && LOG_ECOSYSTEM) {
    // log eco agent
    int num_log_eco_agent = 6 ;
    if(!log_is()) {
      build_log(num_log_eco_agent) ;
    }

    log_eco_agent() ;
    log_eocsystem_resume() ;
    log_agent_global() ;

    log_save() ;
  }
}


// local log method
void log_eocsystem_resume() {
      log_eco_resume(   biomass.humus, biomass.humus_max, 
                      HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST,
                      OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST,
                      CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST,
                      BACTERIUM_LIST,
                      FLORA_LIST,
                      DEAD_LIST) ;

}

void log_eco_agent() {
  if(LOG_ALL_AGENTS) {
      log_eco_agent(0, "Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
      log_eco_agent(1, "Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
      log_eco_agent(2, "Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
      log_eco_agent(3, "Bacterium", BACTERIUM_LIST) ;
      log_eco_agent(4,  "Flora", FLORA_LIST) ;
      log_eco_agent(5,  "Dead", DEAD_LIST) ;
    } else {
      if(LOG_HERBIVORE) log_eco_agent(0, "Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
      if(LOG_OMNIVORE)  log_eco_agent(1, "Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
      if(LOG_CARNIVORE)  log_eco_agent(2, "Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
      if(LOG_BACTERIUM) log_eco_agent(3, "Bacterium", BACTERIUM_LIST) ;
      if(LOG_FLORA) log_eco_agent(4,  "Flora", FLORA_LIST) ;
      if(LOG_DEAD) log_eco_agent(5,  "Dead", DEAD_LIST) ;
    }

}

void log_agent_global() {
  if(LOG_ALL_AGENTS) {
    log_agent_global("Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    log_agent_global("Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    log_agent_global("Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    log_agent_global("Bacterium", BACTERIUM_LIST) ;
    log_agent_global("Flora", FLORA_LIST) ;
    log_agent_global("Dead", DEAD_LIST) ;
  } else {
    if(LOG_HERBIVORE) log_agent_global("Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    if(LOG_OMNIVORE) log_agent_global("Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    if(LOG_CARNIVORE) log_agent_global("Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    if(LOG_BACTERIUM) log_agent_global("Bacterium", BACTERIUM_LIST) ;
    if(LOG_BACTERIUM) log_agent_global("Flora", FLORA_LIST) ;
    if(LOG_DEAD) log_agent_global("Dead", DEAD_LIST) ;
  }
}
/**
END LOG & PRINT
*/





