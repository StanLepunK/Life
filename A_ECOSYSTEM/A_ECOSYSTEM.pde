/**
ECOSYSTEME 0.1.0
System multi-agent
First release 0.0.1 for 2016_01 for l'École multimédia / Workshop 2016 february

*/
/**
2016-09 11.000 lignes de codes
*/


void setup() {
  // fullScreen(P3D, 2) ;
  size(1400, 800,P3D) ;


  load_nucleotide_table("code.csv") ;

  colorMode(HSB, 360,100,100,100) ;
  set_environment() ;
  set_horizon(true) ;
  
  create_decorum() ; 

}





// float rot = 0 ;
void draw() {
  if(init_ecosystem) {
    ecosystem_setting(biomass) ;
    init_ecosystem = false ;
    first_save = true ;
    init_log() ;
  }

  if (bg_refresh) background_rope(0, 10) ;

  
  update_list() ;
  // spawn_carnivore() ;
  int num_carnivore_must_spawn = 3 ;
  int level_frameRate_limit = 45 ;
  control_population_via_frameRate(level_frameRate_limit, num_carnivore_must_spawn) ;


  info_agent(info_agent) ;
  int tempo_info = 300 ;
  log_ecosystem(tempo_info) ;
  if(info_agent) info_ecosystem(tempo_info) ;

  set_log_ecosystem(false) ;
  set_log_agents(false) ;

  set_log_herbivore(false) ;
  set_log_omnivore(false) ;
  set_log_carnivore(false) ;
  set_log_bacterium(false) ;
  set_log_flora(false) ;
  set_log_dead(false) ;
  
  /**
  special update for the flora from list
  */
  update_flora_position_from_adn() ;


  // display
  if(agent_display) show_agent() ;
  if(decorum_display) show_decorum() ;

}





boolean info_agent = false ;

boolean decorum_display = true ;
boolean agent_display = true ;

boolean bg_refresh = true ;
int direction_dna = 1 ;
float speed_rotation_dna = .01 ;
void keyPressed() {
  if(key == 'i' ) {
    if(info_agent) info_agent = false ; else info_agent = true ;
  }


  if(key == 'b' ) {
    if(bg_refresh) bg_refresh = false ; else bg_refresh = true ;
  }




  if(key == 'x') init_ecosystem = true  ;

  if(key == 'n') set_virus_costume() ;

  // rotation
  if(key == 'r' ) {
    if(rotation_bool_dna) rotation_bool_dna = false ; else rotation_bool_dna = true ;
  }
  if(key == 'e' ) {
    if(direction_dna == 1) direction_dna = -1 ; else direction_dna = 1 ;
  }

  if(key == 'a' ) {
    if(speed_rotation_dna > 0) speed_rotation_dna -= .001 ;
  }

  if(key == 'z' ) {
    speed_rotation_dna += .001 ;
  }
  

  if(key == 'l') {
    if(decorum_display) decorum_display = false ; else decorum_display = true ;
  }

  if(key == 'm') {
    if(agent_display) agent_display = false ; else agent_display = true ;
  }
}


