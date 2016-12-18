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
  set_frameRate_log(600) ;

  set_host() ;
  init_symbiosis() ;

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
  // control_population_via_frameRate(level_frameRate_limit, num_carnivore_must_spawn) ;


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

  


  // display
  if(agent_display) {
    show_agent() ;
  }
  if(host_display) {
    show_host(info_agent) ;
  }

  if(host_display && agent_display) {
    sync_symbiosis() ;
    update_symbiosis() ;
  }



}





boolean info_agent = false ;

boolean host_display = true ;
boolean agent_display = true ;

boolean bg_refresh = true ;
int direction_host = 1 ;
boolean motion_bool_host ;
float speed_host = .01 ;
void keyPressed() {
  if(key == 'i' ) {
    if(info_agent) info_agent = false ; else info_agent = true ;
  }


  if(key == 'b' ) {
    if(bg_refresh) bg_refresh = false ; else bg_refresh = true ;
  }




  if(key == 'x') init_ecosystem = true  ;

  if(key == 'n') {
    random_flora_costume_and_colour() ;
  }

  // rotation
  if(key == 'm' ) {
    if(motion_bool_host) motion_bool_host = false ; else motion_bool_host = true ;
  }
  if(key == 'r' ) {
    if(direction_host == 1) direction_host = -1 ; else direction_host = 1 ;
  }

  if(key == 'a' ) {
    if(speed_host > 0) speed_host -= .001 ;
  }

  if(key == 'z' ) {
    speed_host += .001 ;
  }
  
  /**
  display
  */
  if(key == 'f') {
    if(host_display) host_display = false ; else host_display = true ;
  }

  if(key == 'd') {
    if(agent_display) agent_display = false ; else agent_display = true ;
  }
}


