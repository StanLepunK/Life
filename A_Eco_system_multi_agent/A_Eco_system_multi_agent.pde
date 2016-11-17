/**
ECOSYSTEME 0.1.0
System multi-agent
First release 0.0.1 for 2016_01 for l'École multimédia / Workshop 2016 february
*/
/**
2016-09 11.000 lignes de codes
*/
void setup() {
  // fullScreen(P3D) ;
  size(1600,1000,P3D) ;
  load_costume_pic("pirate.svg") ;
 //  load_costume_pic("pirate.png") ;

  load_nucleotide_table("code.csv") ;

  colorMode(HSB, 360,100,100,100) ;
  set_environment() ;
}



void draw() {
  if(init_ecosystem) {
    ecosystem_setting(biomass) ;
    init_ecosystem = false ;
    first_save = true ;
    init_log() ;
  }

  background_rope(biotope_colour(biomass).r,biotope_colour(biomass).g,biotope_colour(biomass).b, 20) ;

  
  update_list() ;
  // spawn_carnivore() ;
  info_agent(info_agent) ;
  int tempo_info = 300 ;
  log_ecosystem(tempo_info) ;
  if(info_agent) info_ecosystem(tempo_info) ;


}





boolean info_agent = false ;
void keyPressed() {
  if(key == 'i' ) {
    if(info_agent)  { 
      info_agent = false ; 
    } else  info_agent = true ;
  } 
}



void mousePressed() {
  init_ecosystem = true  ;
}