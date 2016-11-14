/**
ECOSYSTEME 0.0.6
System multi-agent
First release 0.0.1 for 2016_01 for l'École multimédia / Workshop 2016 february
*/
/**
2016-09 11.000 lignes de codes
*/
boolean PRINT_DEATH_AGENT_DYNAMIC = true ;
boolean PRINT_BORN_AGENT_DYNAMIC = true ;
boolean PRINT_POPULATION = true ;

boolean INFO_DISPLAY_AGENT = true ;


/**
LOG
*/
boolean LOG_ECOSYSTEM = false ;
int FRAME_RATE_LOG = 300 ;


Biomass biomass ;
boolean init_ecosystem = true ;
void setup() {
  // fullScreen(P3D) ;
  size(1600,1000,P3D) ;
  load_nucleotide_table("code.csv") ;
  // size(800,800, P3D) ;
  colorMode(HSB, 360,100,100,100) ;
  
  ENVIRONMENT = 3 ;
  biomass = new Biomass() ;
  
  if (ENVIRONMENT == 3 ) {
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



void draw() {
  if(init_ecosystem) {
    ecosystem_setting(biomass) ;
    init_ecosystem = false ;
    first_save = true ;
    init_log() ;
            
  }
  
  background_rope(biotope_colour(biomass).r,biotope_colour(biomass).g,biotope_colour(biomass).b, 20) ;

  costume_agent() ;

  // set colour method for each type of creature
  Vec4 fill_c = Vec4(random(360),100,100,100) ;
  Vec4 stroke_c = Vec4(random(360),100,100,100) ;
  float thickness = 2 ;
  // set_aspect_flora(fill_c, stroke_c, thickness) ;
  

  /**

  UPDATE

  */
  /**
  flora update
  */
  flora_update(FLORA_LIST, biomass) ;
  /**
  dead corpse update
  */
  bacterium_update(BACTERIUM_LIST, DEAD_LIST, biomass, INFO_DISPLAY_AGENT) ;
  dead_update(DEAD_LIST) ;

  
  /**
  dynamic agent update

  */
  herbivore_update(HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  omnivore_update(OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  carnivore_update(CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;

  /**
  Eating
  */
  eating_update(CARNIVORE_CHILD_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(CARNIVORE_FEMALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(CARNIVORE_MALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;

  eating_update(CARNIVORE_CHILD_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(CARNIVORE_FEMALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(CARNIVORE_MALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;

  // Omnivore hunt carnivore and herbivore
  eating_update(OMNIVORE_CHILD_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(OMNIVORE_FEMALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(OMNIVORE_MALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;

  eating_update(OMNIVORE_CHILD_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(OMNIVORE_FEMALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  eating_update(OMNIVORE_MALE_LIST, DEAD_LIST, INFO_DISPLAY_AGENT) ;
  /**
  hunting
  */
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


  /**
  picking
  */
  picking_update(HERBIVORE_CHILD_LIST, FLORA_LIST, INFO_DISPLAY_AGENT) ;
  picking_update(HERBIVORE_FEMALE_LIST, FLORA_LIST, INFO_DISPLAY_AGENT) ;
  picking_update(HERBIVORE_MALE_LIST, FLORA_LIST, INFO_DISPLAY_AGENT) ;

  picking_update(OMNIVORE_CHILD_LIST, FLORA_LIST, INFO_DISPLAY_AGENT) ;
  picking_update(OMNIVORE_FEMALE_LIST, FLORA_LIST, INFO_DISPLAY_AGENT) ;
  picking_update(OMNIVORE_MALE_LIST, FLORA_LIST, INFO_DISPLAY_AGENT) ;

  /**
  manage Child
  */
  manage_child(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST, HERBIVORE_CHILD_LIST) ;
  manage_child(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST, OMNIVORE_CHILD_LIST) ;
  manage_child(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST, CARNIVORE_CHILD_LIST) ;
  
  /**
  reproduction
  */
  reproduction_female_herbivore(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST, HERBIVORE_CHILD_LIST, herbivore_carac) ;
  reproduction_male(HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;

  reproduction_female_omnivore(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST, OMNIVORE_CHILD_LIST, omnivore_carac) ;
  reproduction_male(OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;

  reproduction_female_carnivore(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST, CARNIVORE_CHILD_LIST, carnivore_carac) ;
  reproduction_male(CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;

  




  /**

  SHOW

  */
  /**
  flora show
  */
  flora_show(FLORA_LIST, INFO_DISPLAY_AGENT, flora_costume) ;
  
  /**
  dead / corpse show
  */
  show_dead(DEAD_LIST, INFO_DISPLAY_AGENT, dead_costume) ;
  
  /**
  dynamic agent show
  */

  show_agent_dynamic(INFO_DISPLAY_AGENT, herbivore_costume, HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  show_agent_dynamic(INFO_DISPLAY_AGENT, herbivore_costume, CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  show_agent_dynamic(INFO_DISPLAY_AGENT, herbivore_costume, OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;


  show_bacterium(biomass, INFO_DISPLAY_AGENT, bacterium_costume, BACTERIUM_LIST) ;


  

  /**
  add Carnivore in the ecosystem
  */
  // spawn_carnivore() ;
  // println("humus", biomass.humus) ;





 
 /**
 INFO
 */
 int tempo_info = 300 ;
 /**
 print info
 */ 
  if(frameCount%tempo_info == 0) {
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


  /**
  log population
  */
  if(frameCount%tempo_info == 0 && LOG_ECOSYSTEM) {
    // log eco agent
    int num_log_eco_agent = 5 ;
    if(!log_is()) build_log(num_log_eco_agent) ;
    log_eco_agent(0, "Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    log_eco_agent(1, "Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    log_eco_agent(2, "Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    log_eco_agent(3, "Bacterium", BACTERIUM_LIST) ;
    log_eco_agent(4,"Flora", FLORA_LIST) ;

    // log eco resume
    log_eco_resume(   biomass.humus, biomass.humus_max, 
                      HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST,
                      OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST,
                      CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST,
                      BACTERIUM_LIST,
                      FLORA_LIST) ;

    // log_agent_global
    log_agent_global("Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    log_agent_global("Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    log_agent_global("Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    log_agent_global("Bacterium", BACTERIUM_LIST) ;
    log_agent_global("Flora", FLORA_LIST) ;


    log_save() ;
  }
  
}







/**
ECOS_SYSTEM setting

*/




void ecosystem_setting(Biomass b) {
  clear_agent() ;
  set_caracteristic_agent() ;
  b.set_humus(BOX.x *BOX.y *.01) ;

  build_flora(FLORA_LIST, flora_carac, colour_flora, num_flora) ;
  build_herbivore(HERBIVORE_CHILD_LIST, herbivore_carac, colour_herbivore, num_herbivore) ;
  build_omnivore(OMNIVORE_CHILD_LIST, omnivore_carac, colour_omnivore, num_omnivore) ;
  build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, colour_carnivore, num_carnivore) ;
  build_bacterium(BACTERIUM_LIST, bacterium_carac, colour_bacterium, num_bacterium) ;
  build_dead(DEAD_LIST, dead_carac, colour_dead, num_dead) ;
}



/**
MOUSE PRESSED

*/
void mousePressed() {
  init_ecosystem = true  ;
}