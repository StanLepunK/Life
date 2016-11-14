/**
INTERFACE AGENT 0.0.2
give a generic method for all classes
*/
interface Agent {
  float CLOCK = 1.5 ;
  int TIME_TO_BE_CARRION = 600 ;
  /**
  GET

  */
  short get_ID() ;
  int get_life() ;
  int get_stamina() ;
  Genome get_genome() ;
  boolean get_alive() ;
  Vec3 get_pos() ;
  int get_size() ;
  /**
  METHOD

  */
  void growth() ;
  /**
  aspect
  */
  void costume_agent(int which) ;
  void aspect(Vec4 f, Vec4 s, float t) ;
  Vec4 get_fill() ;
  Vec4 get_stroke() ;
  float get_thickness() ;
  /**
  SET

  */

  /**
  set aspect
  */
  void set_aspect(Vec4 colour_fill, Vec4 colour_stroke, float thickness) ;
  void set_fill(Vec4 colour_fill) ;
  void set_stroke(Vec4 colour_stroke) ;
  void set_thickness(float thickness) ;
  /**
  set coor, motion...
  */
  void set_pos(Vec pos) ; 
  /**
  set caracterictic
  */
  void set_nutrient_quality(int nutrient_quality) ;
  /**
  INFO
  */
  void info(Vec4 colour, int size_text)  ;
}

























/**
AGENT_METHOD ABSTRACT CLASS 0.0.1

*/
abstract class Agent_method implements Agent {
  String name ;
  short ID = 0 ; 
  int gender = 0 ; // 0 for female, 1 for male, 2 for ermaphrodite
  int generation = 0 ;
  int num_children = 0 ;
  int num_heterozygous = 0 ;
  int num_homozygous = 0 ;
  int num_pregnancy = 0 ;


  /**
  feed
  */
  boolean satiate ;
  float gourmet = 2. ;
  float speed_feeding = .2 ;

  boolean hunger_bool, starving_bool ;


  /**
  life param
  */
  int age = 0 ;
  int dead_since = 0 ;

  boolean alive = true ;
  boolean carrion = false ;

  int life ;
  int life_expectancy = 1  ;

  int stamina, stamina_ref ;
  int nutrient_quality = 1 ;
  // size
  int size, size_ref, size_max ;
    /**
  aspect
  */
  Vec4 colour_fill = Vec4(0,0,0,g.colorModeA) ;
  Vec4 colour_stroke = Vec4(0,0,0,g.colorModeA) ;
  float thickness = 1 ;
  /**
  pos
  */
  Vec3 pos = Vec3() ;

  /**
  reproduction
  */
  Genome genome ;
  Genome genome_father ;

  int maturity ;
  int fertility_cycle ;
  int fertility_time_ref  ;
  int pregnant_term   ;
  
  int fertility_time ;

  boolean fertility = false ;
  int fertility_rate = 1 ;
  int pregnant_time = 0  ;
  boolean pregnant = false ;
  
  // only use for female
  int reproduction_area ;
  int sex_appeal ;
  // int factor_reproduction_area_female = 2 ;
  // int factor_reproduction_area_male = 20 ;
  /**
  GET
  */
  short get_ID() { return ID ; }
  int get_life() { return life ; }
  Genome get_genome() { return genome ;}
  boolean get_alive() { return alive ;}
  int get_size() { return size ; }
  int get_stamina() { return stamina ; }
  Vec4 get_fill() { return colour_fill ; }
  Vec4 get_stroke() { return colour_stroke ; }
  float get_thickness() { return thickness ; }

  Vec3 get_pos() { return pos ;}

  /**
  set reproduction
  */
  void set_maturity(int maturity) {
    this.maturity = int(maturity) ;
  }

  void set_fertility_cycle(int fertility_cycle) {
    this.fertility_cycle = int(fertility_cycle) ;
  }

  void set_fertility_time(int fertility_time) {
    this.fertility_time_ref = int(fertility_time) ;
  }

  void set_pregnant_term(int pregnant_term) {
    this.pregnant_term = int(pregnant_term) ;
  }
  
  void set_fertility_rate(int rate) {
    this.fertility_rate = rate ;
  }

  void set_reproduction_area(int reproduction_area) {
    this.reproduction_area = reproduction_area ;
  }


  /**
  set feeding
  */
  void set_gourmet(float gourmet) {
    this.gourmet = abs(gourmet) +1.1 ;
  }

  void set_nutrient_quality(int nutrient_quality) {
    this.nutrient_quality = nutrient_quality ;
  }

  void set_speed_feeding(int speed_feeding) {
    this.speed_feeding = 1 ;
  }


  /**
  set aspect
  */
  void set_aspect(Vec4 colour_fill, Vec4 colour_stroke, float thickness) {
    this.colour_fill.set(colour_fill) ;
    this.colour_stroke.set(colour_stroke) ;
    this.thickness = thickness ;
  }

  void set_fill(Vec4 colour_fill) {
    this.colour_fill.set(colour_fill) ;
  }

  void set_stroke(Vec4 colour_stroke) {
    this.colour_stroke.set(colour_stroke) ;
  }

  void set_thickness(float thickness) {
    this.thickness = thickness ;
  }

  /**
  set caracteristic
  */
  void set_size(int size) {
    this.size = size ;
  }

  void set_life(int life_expectancy) {
    this.life_expectancy = life_expectancy ;
  }

  /**
  set misc
  */
  void set_ID(short ID) {
    this.ID = ID ;
  }

  void set_alive(boolean alive) {
    this.alive = alive ;
  }





  /**
  METHOD
  */
    /**
  reproduction method

  */
  void fertility(int time) {
    if(time%fertility_cycle == 0 && !pregnant) {
      fertility = fertility?false:true ;
    }
    if(fertility && fertility_time > 0 ) fertility_time-- ;
    if(fertility_time <= 0) {
      fertility_time = fertility_time_ref ;
      fertility = false ;
    }
  }

  void reproduction() {
    pregnant = true ;
    fertility = false ;
    pregnant_time = pregnant_term ;
  }
  
  
  void pregnant() {
    if(pregnant_time > 0 && pregnant) pregnant_time-- ;
  }
  
  boolean birth() {
    if(pregnant_time <= 0 && pregnant) {
      pregnant = false ;
      return true ;
    } else return false ;
  }


  /**
  growth

  */
  void growth() {
    age() ;
    life() ;
    if(life < 0 || stamina <= 0) {
      alive = false ;
    }
    
    if(stamina <= 0) {
      stamina = 0 ;
    }
    if(stamina > stamina_ref) {
      stamina = stamina_ref ;
    }
  }

  
  /**
  life statement
  */
  void life() {
    life-- ;
  }

  void age() {
    age++ ;
  }

  /**
  maturity
  */

  void maturity() {
    if(maturity > 0) maturity-- ;
  }


  /**
  Aspect

  */
  void aspect(float thickness) {
    if(thickness <= 0) { 
      noStroke() ;
      fill(colour_fill) ;
    } else { 
      strokeWeight(thickness) ;
      stroke(colour_stroke) ;
      fill(colour_fill) ;
    }
  }
  
  void aspect(Vec4 c_fill, Vec4 c_stroke, float thickness) {
    if(thickness <= 0) { 
      noStroke() ;
      fill(c_fill) ;
    } else { 
      strokeWeight(thickness) ;
      stroke(c_stroke) ;
      fill(c_fill) ;
    }
  }


  /**
  COSTUME

  */
  void costume_agent(int ID_costume) {
    costume(pos, size, ID_costume) ;
  }



















  /**
  INFO


  */
  /**
  info print
  */
  void info(Vec4 colour, int size_text) {
    if(starving_bool) {
      Vec4 colour_starving = Vec4() ;
      float ratio_speed_warning = .05 ;
      float alpha = abs(sin(frameCount *ratio_speed_warning)) ;
      colour_starving.set(colour.r, colour.g, colour.b, colour.a *alpha) ;
      info_visual(colour_info(colour_starving, satiate, pregnant, fertility)) ;
      info_text(colour_info(colour_starving, satiate, pregnant, fertility), size_text) ;
    } else {
      info_visual(colour_info(colour, satiate, pregnant, fertility)) ;
      info_text(colour_info(colour, satiate, pregnant, fertility), size_text) ;
    }

  }
  /**
  fake
  */
  void info_visual(Vec4 colour) {

  }

  void info_text(Vec4 colour, int size) {

  }
  



  void info_print_caracteristic() {
    println("CARACTERISTIC",this.name) ;
    println(this.name, "size", this.size) ;
    println(this.name, "life expectancy", this.life_expectancy) ;
    println(this.name, "stamina max", this.stamina_ref) ;
    println(this.name, "nutrient quality", this.nutrient_quality) ;
    println(this.name, "food exigency", this.gourmet) ;

  }

  Vec4 colour_info(Vec4 original_colour) {
    return colour_info(original_colour, true, false, false) ;
  }

  Vec4 colour_info(Vec4 original_colour, boolean satiate, boolean pregnant, boolean fertility) {
    Vec4 colour = Vec4(original_colour) ;
    if(!satiate) colour.z = g.colorModeZ *.5 ;
    if(pregnant) colour.y = g.colorModeY *.1 ;
    if(fertility) colour.y = g.colorModeY *.45 ;
    return colour ;
  }
}