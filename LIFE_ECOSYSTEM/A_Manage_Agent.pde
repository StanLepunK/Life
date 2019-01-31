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

ArrayList<Dead> DEAD_LIST = new ArrayList<Dead>() ;

// QUANTITY
int num_flora = 50 ;
int num_herbivore = 100 ; 
int num_omnivore = 0 ; 
int num_carnivore = 10 ; 
int num_bacterium = 10 ;
int num_dead = 50 ;

// Colour
Info_Object style_carnivore, style_herbivore, style_omnivore ;
Info_Object style_flora ;
Info_Object style_dead ;
Info_Object style_bacterium ;


Info_dict flora_carac = new Info_dict() ;
Info_dict herbivore_carac = new Info_dict() ;
Info_dict omnivore_carac = new Info_dict() ;
Info_dict carnivore_carac = new Info_dict() ;
Info_dict bacterium_carac = new Info_dict() ;
Info_dict dead_carac = new Info_dict() ;


  vec4 color_flora = vec4(0, 100, 80, 100) ;


// main method
void ecosystem_setting(Biomass b) {
  clear_agent() ;
  set_caracteristic_agent() ;
  b.set_humus(ECO_BOX_SIZE.x *ECO_BOX_SIZE.y *.01) ;
  

  // FLORA
  // int costume = ELLIPSE_ROPE ;
  Costume costume = new Costume(VIRUS_ROPE);
  costume.set_num(2);
  costume.set_node(3);
  costume.set_mutation(64);
  float thickness = 1. ;

  vec4 fill_flora = vec4(color_flora) ;
  vec4 stroke_flora = vec4(color_flora) ;

  vec3 alpha_behavior_flora = vec3(0, -1, 1) ; // it's like 100% all the time
  if(get_pos_host()  != null) {
    alpha_behavior_flora = vec3(get_pos_host().z, -.4, .8) ;
  }
  
  style_flora = new Info_Object("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora) ;  

  // HERBIVORE
  costume = new Costume(POINT_ROPE);
  vec4 color_herbivore = vec4(110, 100, 70, 100) ;
  vec4 fill_herbivore = vec4(color_herbivore) ;
  vec4 stroke_herbivore = vec4(color_herbivore) ;
  vec3 alpha_behavior_herbivore = vec3(0, -1, 1) ;
  style_herbivore = new Info_Object("Herbivore Aspect", costume, fill_herbivore, stroke_herbivore, thickness, alpha_behavior_herbivore) ;
  
  // OMNIVORE
  costume = new Costume(PENTAGON_ROPE);
  vec4 fill_omnivore = vec4(150, 100, 80, 100) ;
  vec4 stroke_omnivore = vec4(150, 100, 80, 100) ;
  vec3 alpha_behavior_omnivore = vec3(0, -1, 1) ;
  style_omnivore = new Info_Object("Omnivore Aspect", costume, fill_omnivore, stroke_omnivore, thickness, alpha_behavior_omnivore) ;

  // CARNIVORE
  costume = new Costume(HEPTAGON_ROPE);
  vec4 fill_carnivore = vec4(0, 100, 100, 100) ;
  vec4 stroke_carnivore = vec4(0, 100, 100, 100) ;
  vec3 alpha_behavior_carnivore = vec3(0, -1, 1) ;
  style_carnivore = new Info_Object("Carnivore Aspect", costume, fill_carnivore, stroke_carnivore, thickness, alpha_behavior_carnivore) ;
  
  // BACTERIUM
  costume = new Costume(ELLIPSE_ROPE);
  vec4 fill_bacterium = vec4(30, 0, 30, 100) ;
  vec4 stroke_bacterium = vec4(30, 0, 30, 100) ;
  vec3 alpha_behavior_bacterium = vec3(0, -1, 1) ;
  style_bacterium = new Info_Object("Bacterium Aspect", costume, fill_bacterium, stroke_bacterium, thickness, alpha_behavior_bacterium) ;
  

  // DEAD
  costume = new Costume(CROSS_RECT_ROPE);
  vec4 fill_dead = vec4(0, 0, 30, 100) ;
  vec4 stroke_dead = vec4(0, 0, 30, 100) ;
  vec3 alpha_behavior_dead = vec3(0, -1, 1) ;
  style_dead = new Info_Object("Dead Aspect", costume, fill_dead, stroke_dead, thickness, alpha_behavior_dead) ;
  


  if(get_symbiosis_area().length > 0 ) {
    build_flora(FLORA_LIST, flora_carac, style_flora, num_flora, get_symbiosis_area_pos()) ;
    symbiosis(FLORA_LIST, get_symbiosis_area_pos(), get_host_address()) ;
  } else {
    build_flora(FLORA_LIST, flora_carac, style_flora, num_flora) ;
  }

  build_herbivore(HERBIVORE_CHILD_LIST, herbivore_carac, style_herbivore, num_herbivore) ;
  build_omnivore(OMNIVORE_CHILD_LIST, omnivore_carac, style_omnivore, num_omnivore) ;
  build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, style_carnivore, num_carnivore) ;
  build_bacterium(BACTERIUM_LIST, bacterium_carac, style_bacterium, num_bacterium) ;
  build_dead(DEAD_LIST, dead_carac, style_dead, num_dead) ;
}



/**
WHATTTTTTT


*/

/**
Manage AGENT STYLE / ASPECT / COSTUME
*/

boolean new_costume_virus = false ;
void random_flora_costume_and_colour() {
  vec4 fill_flora = vec4(color_flora) ;
  vec4 stroke_flora = vec4(color_flora) ;
  float change_hue = random(50) ;
  float change_alpha = random(100) ;
  fill_flora.x += change_hue ;
  stroke_flora.x += change_hue ;
  fill_flora.a -= change_alpha ;
  stroke_flora.a -= change_alpha ;

  Costume costume = new Costume(VIRUS_ROPE);
  costume.set_num(3);
  costume.set_node(4);
  costume.set_mutation(64);

  int new_costume = floor(random(8)) ;
  if(new_costume == 0 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(3);
    costume.set_node(4);
    costume.set_mutation(32);
  } else if(new_costume == 1 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(3);
    costume.set_node(4);
    costume.set_mutation(64);
  } else if(new_costume == 2 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(3);
    costume.set_node(4);
    costume.set_mutation(128);
  } else if(new_costume == 3 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(2);
    costume.set_node(2);
    costume.set_mutation(16);
  } else if(new_costume == 4 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(3);
    costume.set_node(8);
    costume.set_mutation(16);
  } else if(new_costume == 5 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(2);
    costume.set_node(2);
    costume.set_mutation(32);
  } else if(new_costume == 6 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(3);
    costume.set_node(8);
    costume.set_mutation(64);
  } else if(new_costume == 7 ) {
    costume = new Costume(VIRUS_ROPE);
    costume.set_num(3);
    costume.set_node(8);
    costume.set_mutation(16);
  }
  float thickness = 1. ;

  vec3 alpha_behavior_flora = vec3(get_pos_host().z, -.4, .8) ;
  style_flora = new Info_Object("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora) ;  
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
  flora_carac.add("size", vec3(50)) ;
  flora_carac.add("life_expectancy", 1000000 *60) ;
  flora_carac.add("nutrient_quality", 15) ;
  flora_carac.add("speed_growth", 2) ; // size point per cycle
  flora_carac.add("need", .3) ;

  herbivore_carac.add("name", "Sheep") ;
  herbivore_carac.add("size", vec3(20)) ;
  herbivore_carac.add("stamina", 100) ;
  herbivore_carac.add("life_expectancy", 1000 *60) ;
  herbivore_carac.add("velocity", 6) ;
  herbivore_carac.add("nutrient_quality", 40) ;
  herbivore_carac.add("sense_range", 4000) ;
  herbivore_carac.add("gourmet", 3.5) ;
  herbivore_carac.add("starving", 4) ;
  herbivore_carac.add("digestion", 2.5) ;
  herbivore_carac.add("sex_appeal", vec2(40, 5)) ;
  herbivore_carac.add("multiple_pregnancy", 50.) ;

  omnivore_carac.add("name", "Human") ;
  omnivore_carac.add("size", vec3(25)) ; // in pixel
  omnivore_carac.add("stamina", 200) ; // point of life
  omnivore_carac.add("life_expectancy", 800 *60) ; // frame of live before die
  omnivore_carac.add("velocity", 8) ; // in pixel
  omnivore_carac.add("nutrient_quality", 20) ; // multi the stamina point to give the calories
  omnivore_carac.add("sense_range", 1000) ; // range in pixel
  omnivore_carac.add("gourmet", 2.5) ; 
  omnivore_carac.add("attack", 5) ; // attack point
  omnivore_carac.add("starving", 3) ; 
  omnivore_carac.add("digestion", 6.5) ; // calorie multiplicator, hight is good.
  omnivore_carac.add("sex_appeal", vec2(45, 4)) ; // multe the size to give the range in pixel
  omnivore_carac.add("multiple_pregnancy", 10.5) ; // chance to have twin or better in pourcent

  carnivore_carac.add("name", "Alien") ;
  carnivore_carac.add("size", vec3(40)) ;
  carnivore_carac.add("stamina", 400) ;
  carnivore_carac.add("life_expectancy", 1200 *60) ;
  carnivore_carac.add("velocity", 10) ;
  carnivore_carac.add("nutrient_quality", 20) ;
  carnivore_carac.add("sense_range", 1200) ;
  carnivore_carac.add("gourmet", 2.5) ;
  carnivore_carac.add("attack", 10) ;
  carnivore_carac.add("starving", 4) ;
  carnivore_carac.add("digestion", 4.5) ;
  carnivore_carac.add("sex_appeal", vec2(30, 10)) ;
  carnivore_carac.add("multiple_pregnancy", 5.5) ;

  bacterium_carac.add("name", "Gnak Gnak") ;
  bacterium_carac.add("size", vec3(2)) ;
  bacterium_carac.add("stamina", 200) ;
  bacterium_carac.add("life_expectancy", 800 *60) ;
  bacterium_carac.add("velocity", 5) ;
  bacterium_carac.add("nutrient_quality", 1) ;
  bacterium_carac.add("sense_range", 500) ;
  bacterium_carac.add("starving", 2) ;
  bacterium_carac.add("digestion", 12.5) ;

  dead_carac.add("name", "UNDEAD") ;
  dead_carac.add("size",  vec3(25)) ;
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








/**
* Create enviromnent where the ecosystem will be live
*/
void build_environment(vec2 pos, vec2 size) {
  vec3 pos_3D = vec3(pos.x, pos.y,0) ;
  vec3 size_3D = vec3(size.x, size.y,0) ;
  build_environment(pos_3D, size_3D) ;
  // write here to be sure the Environment have a good info
}

void build_environment(vec3 pos, vec3 size) {
  build_box(pos, size) ;

  float front = box_front() ;
  float back = box_back() ;

  set_limit_box(box_left() , box_right(), box_top(),  box_bottom(), front, back) ;
  int dist_to_horizon = int(abs(back) +abs(front)) ;
  set_horizon(dist_to_horizon) ;
  use_rebound(true) ;
  set_textSize_info(18) ; 
  // b.set_humus(BOX.x *BOX.y *.01) ;
  // b.humus_max = b.humus = BOX.x *BOX.y *.01 ;
}

float box_left() {
  return get_box_pos().x - (get_box_size().x *.5) ;
}

float box_right() {
  return get_box_pos().x + (get_box_size().x *.5) ;
}

float box_top() {
  return get_box_pos().y - (get_box_size().y *.5) ;
}

float box_bottom() {
  return get_box_pos().y + (get_box_size().y *.5) ;
}

float box_front() {
  return get_box_pos().z - (get_box_size().z *.5) ;
}

float box_back() {
  return get_box_pos().z + (get_box_size().z *.5) ;
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
    vec3 pos_box = vec3(width/2,height/2,0) ;
    float scale_box = .5 ;
    vec3 size_box = vec3(width *scale_box,height *scale_box,width *scale_box) ;
    build_environment(pos_box, size_box) ;
  } else {
    vec2 pos_box = vec2(width/2,height/2) ;
    vec2 size_box = vec2(width,height) ;
    build_environment(pos_box, size_box) ;
  }
}



/**
BIOTOPE 
*/
vec4 biotope_colour(Biomass b) {
  float normal_humus_level = 1 - b.humus / b.humus_max ;
  float var_colour_ground = 90 *normal_humus_level ;
  return vec4(40,90, 5 +var_colour_ground,100) ;
}































/**
UPDATE LIST
*/
void update_list() {

  // flora update
  flora_update(FLORA_LIST, biomass) ;
  // bacterium update
  bacterium_update(DEAD_LIST, BACTERIUM_LIST, biomass, INFO_DISPLAY_AGENT) ;
  // dead corpse update
  
  dead_update(DEAD_LIST) ;
 
  // dynamic agent update
  herbivore_update(DEAD_LIST, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  omnivore_update(DEAD_LIST, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  carnivore_update(DEAD_LIST, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;






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









































