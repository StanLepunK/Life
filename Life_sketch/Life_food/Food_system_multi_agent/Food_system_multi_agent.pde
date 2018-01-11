/**
ECOSYSTEME 0.0.5
System multi-agent
First release 0.0.1 for 2016_01 for l'École multimédia / Workshop 2016 february
*/
interface RULES_ECOSYSTEME {
  float CLOCK = 1.5 ;
  int TIME_TO_BE_CARRION = 10 ;
}





void setup() {
  fullScreen(P3D) ;
  // size(800,800, P3D) ;
  colorMode(HSB, 360,100,100,100) ;
  
  DISPLAY_INFO = true ;
  ENVIRONMENT = 3 ;
  
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

  ecosystem_setting() ;
}



void draw() {
  background_3D(biotope_colour().r,biotope_colour().g,biotope_colour().b, 20) ;

  // COSTUME
  int flora_costume = ELLIPSE_RPE ;
  int herbivore_costume = TETRAHEDRON_RPE ;
  int carnivore_costume = CROSS_3_RPE ;
  int bacterium_costume = SPHERE_RPE ;
  int corpse_costume = BOX_RPE ;

  // set colour method for each type of creature
  Vec4 fill_c = Vec4(random(360),100,100,100) ;
  Vec4 stroke_c = Vec4(random(360),100,100,100) ;
  float thickness = 2 ;
  set_aspect_flora(fill_c, stroke_c, thickness) ;
  
  flora_update(FLORA_LIST, DISPLAY_INFO, flora_costume) ;
  herbivore_update(HERBIVORE_LIST, FLORA_LIST, DISPLAY_INFO, herbivore_costume) ;
  carnivore_update(CARNIVORE_LIST, HERBIVORE_LIST, CORPSE_LIST, DISPLAY_INFO, carnivore_costume) ;
  bacterium_update(BACTERIUM_LIST, CORPSE_LIST, DISPLAY_INFO, bacterium_costume) ;
  corpse_update(CORPSE_LIST, DISPLAY_INFO, corpse_costume) ;

  
  // print_info_environment() ;
  //print_list() ;
  // println("FrameRate", int(frameRate)) ;
  print_info_carnivore(CARNIVORE_LIST) ;
  // print_info_herbivore(HERBIVORE_LIST) ;
  // print_info_bacterium(BACTERIUM_LIST) ;

}






// setting ecosysteme
void ecosystem_setting() {
  clear_ecosystem() ;
  // QUANTITY
  int num_flora = 200 ;
  int num_herbivore = 100; 
  int num_carnivore = 1 ; 
  int num_bacterium = 2 ;

  // Colour
  Vec4 colour_flora = Vec4(100,100,80,100) ;
  Vec4 colour_herbivore = Vec4(50,100,100,100) ;
  Vec4 colour_carnivore = Vec4(0,100,100,100)  ; 
  Vec4 colour_bacterium = Vec4(30,0,30,100) ;

  // Size
  int size_flora = 50 ;
  int size_herbivore = 35 ;
  int size_carnivore = 55 ;
  int size_bacterium = 10 ;

  // Life
  int life_herbivore = 100 ;
  int life_carnivore = 200 ;
  int life_bacterium = 2000 ;

  // Velocity
  int velocity_herbivore = 5 ;
  int velocity_carnivore = 8 ;
  int velocity_bacterium = 2 ;

  //Radar
  float sense_view_herbivore = 3 ;
  float sense_view_carnivore = 12 ;
  float sense_view_bacterium = 400 ;
  if(ENVIRONMENT == 3) {
    // in 3D it's necessary to give very very bigger range for the sense_view.
    int ratio_range_sense_view = 5 ;
    sense_view_herbivore *= ratio_range_sense_view ;
    sense_view_carnivore *= ratio_range_sense_view ;
    sense_view_bacterium *= ratio_range_sense_view ;
  }

  // BUILD
  build_flora(size_flora, colour_flora, num_flora) ;
  build_herbivore(size_herbivore, life_herbivore, velocity_herbivore, sense_view_herbivore, colour_herbivore, num_herbivore) ;
  build_carnivore(size_carnivore, life_carnivore, velocity_carnivore, sense_view_carnivore, colour_carnivore, num_carnivore) ;
  build_bacterium(size_bacterium, life_bacterium, velocity_bacterium, sense_view_bacterium, colour_bacterium, num_bacterium) ;
}









void mousePressed() {
  ecosystem_setting()  ;
  /*
  Vec3 pos = Vec3(mouseX,mouseY, abs(sin(frameCount) *LIMIT.f));
  int size = int(random(10,100)) ;
  String name = "OGM" ;
  Vec4 colour = Vec4(100,100,80,100) ;
  add_flora(pos, size, name, colour) ;
  */
}