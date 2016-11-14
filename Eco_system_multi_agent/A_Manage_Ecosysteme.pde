/**
MANAGE ECO-SYSTEM BUILT 0.1.0
*/
/**
AGENT
*/

/**
LIST
*/
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
/**
setting ecosysteme
*/
// QUANTITY
int num_flora = 100 ;
int num_herbivore = 30 ; 
int num_omnivore = 0 ; 
int num_carnivore = 2 ; 
int num_bacterium = 0 ;
int num_dead = 0 ;

// Colour
Vec4 colour_flora = Vec4(100, 100, 80, 100) ;
Vec4 colour_herbivore = Vec4(50, 100, 100, 100) ;
Vec4 colour_omnivore = Vec4(150, 100, 80, 100) ;
Vec4 colour_carnivore = Vec4(0, 100, 100, 100)  ; 
Vec4 colour_bacterium = Vec4(30, 0, 30, 100) ;
Vec4 colour_dead = Vec4(0, 0, 30, 100) ;


Info_dict flora_carac = new Info_dict() ;
Info_dict herbivore_carac = new Info_dict() ;
Info_dict omnivore_carac = new Info_dict() ;
Info_dict carnivore_carac = new Info_dict() ;
Info_dict bacterium_carac = new Info_dict() ;
Info_dict dead_carac = new Info_dict() ;



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


int flora_costume, herbivore_costume, omnivore_costume, carnivore_costume, bacterium_costume, corpse_costume, dead_costume  ;
void costume_agent() {
  flora_costume = ELLIPSE_RPE ;
  herbivore_costume = TETRAHEDRON_RPE ;
  omnivore_costume = TETRAHEDRON_RPE ;
  carnivore_costume = CROSS_3_RPE ;
  bacterium_costume = SPHERE_RPE ;
  corpse_costume = BOX_RPE ;
  dead_costume = POINT_RPE ;
}


void set_caracteristic_agent() {
  flora_carac.add("name", "Salad") ;
  flora_carac.add("size", 50) ;
  flora_carac.add("nutrient_quality", 5) ;
  flora_carac.add("speed_growth", 2) ; // size point per cycle
  flora_carac.add("need", .3) ;

  herbivore_carac.add("name", "Sheep") ;
  herbivore_carac.add("size", 20) ;
  herbivore_carac.add("stamina", 100) ;
  herbivore_carac.add("life_expectancy", 400 *60) ;
  herbivore_carac.add("velocity", 6) ;
  herbivore_carac.add("nutrient_quality", 40) ;
  herbivore_carac.add("sense_range", 1000) ;
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
  bacterium_carac.add("sense_range", 600) ;
  bacterium_carac.add("starving", 2) ;
  bacterium_carac.add("digestion", 12.5) ;


  dead_carac.add("name", "UNDEAD") ;
  dead_carac.add("size", 25) ;
  dead_carac.add("nutrient_quality", 40) ;
}



/**
SPAWN carnivore

*/
void spawn_carnivore() {
    if(CARNIVORE_CHILD_LIST.size() < 1) {
    int population_target = HERBIVORE_CHILD_LIST.size() + HERBIVORE_FEMALE_LIST.size() +  HERBIVORE_MALE_LIST.size() ;
    if(population_target > num_herbivore && frameCount%(5 *(int)frameRate) == 0 ) {
      int num = ceil(random(10)) ;
      build_carnivore(CARNIVORE_CHILD_LIST, carnivore_carac, colour_carnivore, num) ;
    }
  }
}

/**
ENVIRONMENT
*/
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

  REBOUND = false ;
  SIZE_TEXT_INFO = 18 ;
  //b.set_humus(BOX.x *BOX.y *.01) ;
  // b.humus_max = b.humus = BOX.x *BOX.y *.01 ;
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


