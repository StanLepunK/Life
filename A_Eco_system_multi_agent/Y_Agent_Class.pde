/**
CLASS AGENT 0.1.1
*/
/**


INTERFACE AGENT 0.0.2


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

  int get_alpha_cursor() ;
  float get_alpha_back() ;
  float get_alpha_front() ;


  /**
  METHOD
  */
  void growth() ;
  /**
  aspect
  */
  void costume(int which) ;
  void costume() ;
  void set_costume(int which) ;
  
  void aspect(Vec4 f, Vec4 s, float t) ;

  int get_costume() ;
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
  void set_alpha(Vec3 alpha_behavior) ;
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

END INTERFACE AGENT

*/

















/**



Agent_model ABSTRACT CLASS 0.1.0

*/
abstract class Agent_model implements Agent {
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

  int costume = 0 ; // costume 0 is point in Z_costume_rope library

  int alpha_cursor = 0 ;
  float alpha_back = 1. ;
  float alpha_front = 1. ;
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
  short get_ID() { 
    return ID ; 
  }
  int get_life() { 
    return life ; 
  }
  Genome get_genome() { 
    return genome ;
  }
  boolean get_alive() { 
    return alive ;
  }
  int get_size() { 
    return size ; 
  }
  int get_stamina() { 
    return stamina ; 
  }

  int get_costume() { 
    return costume ; 
  }
  Vec4 get_fill() { 
    return colour_fill ; 
  }
  Vec4 get_stroke() { 
    return colour_stroke ; 
  }
  float get_thickness() { 
    return thickness ; 
  }

  Vec3 get_pos() { 
    return pos ;
  }

  int get_alpha_cursor() {
    return alpha_cursor ;
  }
  float get_alpha_back() {
    return alpha_back ;
  }
  float get_alpha_front() {
    return alpha_front ;
  }


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


  // void set_alpha(int alpha_cursor, float alpha_back, float alpha_front) {
  void set_alpha(Vec3 alpha_behavior) {
    this.alpha_cursor = (int)alpha_behavior.x ;
    this.alpha_back = abs(alpha_behavior.y) ;
    this.alpha_front = alpha_behavior.z ;
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
  ASPECT
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
  void costume() {
    costume_rope(pos, size, costume) ;
  }

  void costume(int costume) {
    costume_rope(pos, size, costume) ;
  }

  void set_costume(int costume) {
    this.costume = costume ;
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
/** 

END CLASS AGENT METHOD

*/

























/**

CLASS AGENT DYNAMIC 0.2.0

@author Stan le Punk
@version 0.1.1
*/
abstract class Agent_dynamic extends Agent_model {
  /**
  target
  */
  Vec2 ID_target = Vec2(-1) ;
  Vec3 pos_target = Vec3(0) ;
  Agent target ;

  /**
  carnivore
  */
  boolean killing   ;
  int attack = 1 ;
  int kill_zone ;
  int time_track ;
  int max_time_track = int(360 *CLOCK) ;

  /**
  sense
  */
  int sense_range ;

  /**
  reproduction
  */
  int sex_appeal ;
  float multiple_pregnancy = 0 ;

  /**
  satisfaction
  */
  // int threshold_migration ;
  int level_satisfaction, level_dissatisfaction ;
  int threshold_satisfation  ;
  int threshold_dissatisfaction  ;

  /**
  Feed
  */
  int step_hunger ;
  int leptin ; // step satiating peptid coded on OB gene chromosome 7
  int hunger  ;
  int starving = 1 ;
  int eat_zone ;
 // int greed  ;
 //  int greed = int(180 *CLOCK) ; // num of frame before stop to eat :)

  float digestion = 2 ;

  //behavior
  int max_watching = 600 ;


  // STATEMENT
  boolean watching = true ;
  boolean eating ;
  boolean tracking ;
  boolean tracking_partner ;
  /**
  motion, pos, coord
  */
  Vec3 motion = Vec3() ;
  Vec3 dir = Vec3() ;
  Vec3 velocity_xyz = Vec3() ;
  float velocity, velocity_ref ;

  float vel_slow_4 = .1 ;
  float vel_slow_3 = .25 ;
  float vel_slow_2 = .5 ;
  float vel_slow_1 = .75 ;
  float vel_normal = 1. ;
  float vel_fast_1 = 1.25 ;
  float vel_fast_2 = 1.5 ;
  float vel_fast_3 = 2. ;
  float vel_fast_4 = 3. ;

  /**
  misc or out or real caracteristic...
  */
  // watching variable
//  int size_target_flora ;
  int time_watching = 0 ;
  // MISC
  Info_obj style ;


  /**
  CONSTRUCTOR 
  Dynamic Agent from caracteristic

  @param Vec3 pos, give the x,y,z coord of the agent
  @param int size, give a data to give size to the agent
  @param int life, give the life and and use to give the maximum life of the agent
  @param int stamina, give the stamina and and use to give the maximum stamina of the agent
  @param int velocity, give the maximum of motion speed of your agent.
  @param String name... no comment !
  */
  Agent_dynamic(Info_dict carac, Info_obj style, int gender) {
  // Agent_dynamic(int size, int stamina, int life_expectancy, int velocity, int sense_range, String name, Vec2 sex_appeal, int gender) {
    // set aspect
    this.style = style ;
    set_aspect((Vec4)style.catch_obj(1), (Vec4)style.catch_obj(2), (float)style.catch_obj(3)) ;

    // catch caracteristic
    String temp_name = "Nobody" ;
    int temp_size = 1 ;
    int temp_stamina = 1 ;
    int temp_velocity = 0 ;
    int temp_sense_range = 1 ;
    int temp_life_expectancy = MAX_INT ;
    int species_life_cycle = MAX_INT ;
    Vec2 temp_sex_appeal = Vec2(1) ;
    float temp_multiple_pregnancy = 0 ;

    if (carac.get("name") != null) temp_name = (String) carac.get("name")[0].catch_obj(0) ;
    if (carac.get("size") != null) temp_size = (int) random_gaussian((int)carac.get("size")[0].catch_obj(0)) ;
    if (carac.get("stamina") != null) temp_stamina = (int) random_gaussian((int)carac.get("stamina")[0].catch_obj(0)) ;
    if (carac.get("velocity") != null) temp_velocity = (int) random_gaussian((int)carac.get("velocity")[0].catch_obj(0)) ;
    if (carac.get("sense_range") != null) temp_sense_range = (int) random_gaussian((int)carac.get("sense_range")[0].catch_obj(0)) ;
    // agent
    if (carac.get("life_expectancy") != null) temp_life_expectancy = (int) random_gaussian((int)carac.get("life_expectancy")[0].catch_obj(0)) ;
    // species
    if (carac.get("life_expectancy") != null) species_life_cycle = (int) random_gaussian((int)carac.get("life_expectancy")[0].catch_obj(0)) ;
    if (carac.get("sex_appeal") != null) {
      Object obj = carac.get("sex_appeal")[0].catch_obj(0) ;
      if(obj instanceof Vec2) { 
        Vec2 temp = (Vec2) obj ;
        temp_sex_appeal.x = random_gaussian(temp.x);
        temp_sex_appeal.y = random_gaussian(temp.y);
      }
    }




    if(carac.get("multiple_pregnancy") != null) temp_multiple_pregnancy = random_gaussian((Float)carac.get("multiple_pregnancy")[0].catch_obj(0)) ;

    init_var_life_cycle(temp_life_expectancy, species_life_cycle) ;

    // genome info
    this.size = this.size_ref = this.size_max = temp_size ;
    this.stamina_ref = this.stamina = temp_stamina ;
    this.velocity = this.velocity_ref = temp_velocity ;
    this.name = temp_name ;
    this.sense_range = this.size + temp_sense_range ;
    this.multiple_pregnancy = temp_multiple_pregnancy ;

    this.gender = gender ;
    /**




    use 
    StringDict and floatDict





    */


    
    init_ID() ;
    init_dir() ;
    up_generation() ;

    int female_area_ratio = (int)temp_sex_appeal.x ;
    int male_area_ratio = (int)temp_sex_appeal.y ;
    set_reproduction(temp_sex_appeal) ;

    set_hunger_cycle() ;
    
    build_archetype_genome( temp_size, 
                            temp_life_expectancy,
                            temp_velocity, 
                            temp_sense_range, 
                            temp_name, 
                            temp_sex_appeal,
                            temp_multiple_pregnancy,
                            species_life_cycle,
                            generation,  
                            gender) ;

  }




  /**
  CONSTRUCTOR 
  Dynamic Agent from mother and father Genome
  */
  Agent_dynamic(Genome mother, Genome father, Info_obj style) {
    // aspect
    this.style = style ;
    set_aspect((Vec4)style.catch_obj(1), (Vec4)style.catch_obj(2), (float)style.catch_obj(3)) ;

    init_ID() ;
    init_dir() ;
    // update gene generation from mother line
    this.generation = (int)(Float.parseFloat(mother.get_gene("1").data_left_arm)) ;



    // create child genome
    genome = genotype(mother, father) ;
    // write mutation info in the genome

    

   
    
    // setting
    // chromosome Float
    this.size = int((Float)genome.get_gene_product(0,0).catch_obj(0)) ;
    this.stamina_ref = this.stamina = int((Float)genome.get_gene_product(0,2).catch_obj(0));
    int life_expectancy_temp = int((Float)genome.get_gene_product(0,3).catch_obj(0)) ;

    this.velocity = this.velocity_ref = int((Float)genome.get_gene_product(0,4).catch_obj(0)) ;
    this.sense_range = int(size +int((Float)genome.get_gene_product(0,5).catch_obj(0))) ;
    // chromosome String
    this.name = (String) genome.get_gene_product(1,0).catch_obj(0) ;
    // sex appeal
    Vec2 sex_appeal = Vec2((Float)genome.get_gene_product(0,6).catch_obj(0), (Float)genome.get_gene_product(0,7).catch_obj(0)) ;
    // multi_pregnancy
    this.multiple_pregnancy = (Float)genome.get_gene_product(0,8).catch_obj(0) ;

    // cycle life
    int species_life_cycle = int((Float)genome.get_gene_product(0,9).catch_obj(0)) ;


    
    up_generation() ;
    genome.mutation_data(0, 1, String.valueOf(generation), true, true);


    init_var_life_cycle(life_expectancy_temp, species_life_cycle) ;
    set_reproduction(sex_appeal) ;

    set_hunger_cycle() ;

    if((String) genome.get_gene_product("XX").catch_obj(0) == "X") {
      this.gender = 0  ; 
    } else { 
      this.gender = 1 ;
    }
  }




  /**
  GENOME
  */
  void build_archetype_genome(int size, int life_expectancy, int velocity, int sense_range, String name, Vec2 sex_appeal, float multiple_pregnancy, int species_life_cycle, int generation, int gender) {
    float [] data_float = new float[10] ;
    data_float[0] = size ;
    data_float[1] = generation ;
    data_float[2] = stamina ;
    data_float[3] = life_expectancy ;
    data_float[4] = velocity ;
    data_float[5] = sense_range ;
    data_float[6] = sex_appeal.x ;
    data_float[7] = sex_appeal.y ;
    data_float[8] = multiple_pregnancy ;
    data_float[9] = species_life_cycle ;
    String [] data_string = new String[1] ;
    data_string[0] = name ;
    genome = archetype(data_float, data_string, gender) ;
  }

  /**
  INIT
  */
  /**
  internal setting for constructor
  based on arbitrary life cycle model
  */
  void init_var_life_cycle(int life_expectancy, int species_life_expectancy) {

    this.life_expectancy = life_expectancy ;
    this.life = life_expectancy ;
    maturity = this.life_expectancy / 15 ;
    // we use species life expectancy to don't hava variation between the agent of same species
    fertility_cycle = species_life_expectancy / 45 ;
    fertility_time_ref = fertility_cycle / 5 ;
    pregnant_term = fertility_cycle *10  ;

    this.threshold_satisfation = this.life_expectancy /10 ;
    this.threshold_dissatisfaction = this.life_expectancy /10  ;

  }
  void init_ID() {
    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
  }

  void up_generation() {
    this.generation++ ;
  }

  void init_dir() {
    this.dir = Vec3("RANDOM",1) ;
  }















  /**
  SET
   
  */
  /**
  internal set
  */
  void set_hunger_cycle() {
    set_step_hunger(this.size +this.stamina)  ;
    set_leptin(2.5) ;
    set_hunger(this.step_hunger *2.) ;
    if(hunger > step_hunger) satiate = true ;
  }


  void set_reproduction(Vec2 sex_appeal_ratio) {
    if(this.gender == 0) {
      this.reproduction_area = size *2 ; 
      this.sex_appeal = int(size *sex_appeal_ratio.x) ; 
    } else if (this.gender == 1) { 
      this.reproduction_area = size *2 ; 
      this.sex_appeal = int(size *sex_appeal_ratio.y) ; 
    }
  }








  /**
  set food
 */


  void set_starving(int starving) {
    if(starving <= 0) starving = abs(starving) ;
    this.starving = starving ;
  }

  void set_step_hunger(float step_hunger) {
    if(step_hunger <= 0) step_hunger = abs(step_hunger) ;
    this.step_hunger = (int)step_hunger ;
  }

  void set_leptin(float level) {
    if(level <= 0) level = abs(level) ;
    this.leptin = int(this.step_hunger *level) ;
  }

  void set_hunger(float hunger) {
    if(hunger <= 0) hunger = abs(hunger) ;
    this.hunger = (int)hunger ;
  }





  void set_digestion(float digestion) {
    if(digestion <= 0) {
      println("Negative value, we use the absolute value.") ;
      this.digestion = abs(digestion) ;
    } else {
      this.digestion = digestion ;
    }
  }



  /**
  set motion
  */
  void set_dir(Vec3 dir) {
    this.dir.set(dir) ;
  }

  void set_velocity(float velocity) {
    this.velocity = velocity ;
  }

  void set_pos(Vec pos) {
    if(pos instanceof Vec3) {
      Vec3 temp_pos = (Vec3) pos ;
      this.pos.set(temp_pos) ;
      this.motion.set(temp_pos) ;
    }
    if(pos instanceof Vec2) {
      Vec2 temp_pos = (Vec2) pos ;
      this.pos.set(temp_pos.x, temp_pos.y,0) ;
      this.motion.set(this.pos) ;
    }
  }



  /**
  set hunting and picking
  */
  void set_watching(int  max_watching) {
    this.max_watching = max_watching ;
  }

  /**
  set carnivore
  */
  void set_kill_zone(int radius) {
    this.kill_zone = radius ;
  }

  void set_attack(int attack) {
    this.attack = attack ;
  }

  void set_max_time_track(int max) {
    this.max_time_track = int(max *CLOCK) ;
  }










  /**
  GET pos
  */
  Vec3 get_pos_target() {
    return pos_target ;
  }
  Vec3 get_pos() {
    return pos ;
  }










  /**
  PICKING METHOD – for the herbivore by the way :)


  */
  // dist_ref_watch_flora value is used to compare the distace with the other flora in the range sens and avoid to change target if the target is before in the list
  float dist_ref_watch_flora = MAX_INT ;
  float ratio_food_ref = 0 ;

  void watch(Flora f, ArrayList<Agent> list_target, boolean info) {
    // if(time_watching < max_watching && !starving_bool) {
    if(time_watching < max_watching && !eating) {
      // change target
      // if(starving_bool && ID_target.x >= 0 && ID_target.x < list_target.size()) {
      if(starving_bool && focus_target(list_target)) {
        // check the previous target if there is one
        Agent target = list_target.get((int)ID_target.x) ;
        if(target instanceof Flora) {
          Flora target_flora = (Flora) target ;
         // if(frameCount%90 == 0) println("same target") ;
          targeting(target_flora, list_target, true) ;
        }
      } else if (!starving_bool) {
        // search for target
        boolean ratio_food = false ;
        if(ratio_food_ref < ratio_food (f.size, f.size_ref, f.nutrient_quality, gourmet)) {
          ratio_food = true ;
        }
        targeting(f, list_target, ratio_food) ;
      } else {
        time_watching = 0 ;
//        size_target_flora = 0 ;
      }
    }
  }



  // local method
  void targeting(Flora target, ArrayList<Agent> list_target, boolean ratio_food) {
    float dist = dist(target.pos,pos) ;
    boolean threshold_quantity = threshold_food_quantity(target.size, target.size_ref, gourmet) ;
    if(dist < sense_range && dist < dist_ref_watch_flora && threshold_quantity && ratio_food) {
      /*
      printTempo(90, "ID target", target.ID, dist, sense_range) ;
      printTempo(90, "ID target", target.ID, dist, dist_ref_watch_flora) ;
      printTempo(90, "ID target", target.ID, threshold_quantity, ratio_food) ;
      */
      ID_target.set(list_target.indexOf(target), target.ID) ;
      set_target(target) ;
    } else {
      watching = true ;
    }
  }

  void reset_watching_var() {
    dist_ref_watch_flora = MAX_INT ;
    ratio_food_ref = 0 ;
  }

  // set target
  void set_target(Flora f) {
    // make ref of the best target / pray
    ratio_food_ref =  ratio_food (f.size, f.size_ref, f.nutrient_quality, gourmet) ;
    dist_ref_watch_flora = dist(f.pos,pos) ;
    // 
    pos_target.set(f.pos) ;
    time_watching ++ ;
    watching = false ; 
  }

  // pick
  void pick(Flora f) {
    if (!watching) {
      Vec3 pos_target = f.pos.copy() ;
      dir.set(target_direction(pos_target, pos)) ; 
    }
  }

  boolean picking() {
    if (watching) return false ; else return true ;
  }











  /**
  HUNTING METHOD – for the carnivore by the way

  */
  // WHY INFO boolean info ??????
  void hunt(Agent_dynamic target, boolean info) {
    if(target.alive) {
      hunt_in_progress() ;
      follow(target, info) ;
    } else {
      hunt_stop() ;
    } 
  }
 // WHY INFO boolean info ??????
  void kill(Agent_dynamic target, boolean info) {
    if(dist(target.pos,pos) < kill_zone && target.alive ) {
      pos_target.set(target.pos) ;
      target.stamina -= 1 *attack ;
    } else {
      //
    }
  }


  // WHY INFO boolean info ??????
  void follow(Agent_dynamic target, boolean info) {
    pos_target.set(target.pos) ;
    dir.set(target_direction(target.pos, pos)) ;
  }

  // WHY INFO boolean info ??????
  float dist_to_target(Agent_dynamic target, boolean info) {
    float dist = dist(target.pos,pos) ;
    if(dist < sense_range) {
      pos_target.set(target.pos) ;
    } else {
      //
    }
    return dist ;
  }

  void hunt_in_progress() {
    time_track += 1 ;
    tracking = true ; 
    watching = false ;
  }

  void hunt_stop() {
    time_track = 0 ;
    tracking = false ; 
    watching = true ;
  }


  /**
SEARCHING for PICK of HUNT
*/
  boolean focus_target(ArrayList<Agent> list_target) {
    boolean check = false ;
    int pointer = (int)ID_target.x ;
    int ID = (int)ID_target.y ;
    if(pointer >= 0 && pointer < list_target.size()) {
      target = list_target.get((int)ID_target.x) ;
      if(target.get_ID() == ID) { 
        check = true ; 
      } else {
        for(Agent target_in_list : list_target) {
          if (target_in_list.get_ID() == ID ) {
            target = target_in_list ;
            check = true ;
            break ;
          } else check = false ;
        }
      }
    } else check = false ;
    return check ;
  }














  /**
   FOODING, EATING, STARVING & Co

  */
  /**
  add stamina
  */
  void eat_flesh(Agent_static a, boolean info) {
    if(dist(a.pos,pos) < eat_zone && !a.alive && threshold_food_quantity(a.size, a.size_ref, gourmet)) {
      pos_target.set(a.pos) ;
      float calories = a.nutrient_quality *speed_feeding *digestion ;
      a.size -= speed_feeding ;
      hunger += calories ;
      stamina += calories ;
      eating = true ;
    } else {
      eating = false ;
    }
  }

  void eat_veg(Flora f, boolean info) {
    if(dist(f.pos,pos) < eat_zone && threshold_food_quantity(f.size, f.size_ref, gourmet) ) {
      pos_target.set(f.pos) ;
      float calories = f.nutrient_quality *speed_feeding *digestion ;
      f.stamina -= (speed_feeding *.01);
      f.size -= (speed_feeding *.01);
      hunger += calories ;
      stamina += calories ;
      eating = true ;
      // re init var comparator
      reset_watching_var() ;
      dir.set(0) ;
    } else {
      eating = false ;
    }
  }
  


  /**
  remove stamina
  */
  // Fint starving_count ;
  void hunger() {
    // hunger state
    if(hunger < step_hunger) {
      hunger_bool = true ; 
    } else {
      hunger_bool = false ;
    }
    // starving state
    if(hunger < (step_hunger /2)) {
      starving_bool = true ;
    } else {
      starving_bool = false ;
    }

    // hunger evolution
    if(frameCount%(1 +int(frameRate *CLOCK)) == 0) {
      if (hunger <= 0) {
        stamina -= starving ;
      } else {
        hunger -= starving ;
      }
    }
  }





//  int start_eating ;
  void time_to_eat() {
    if(hunger_bool) {
      satiate = false ;
    } else {
      if (hunger > leptin) {
        satiate = true ; 
      }
    }
  }



  boolean threshold_food_quantity(float size, float size_ref, float gourmet) {
    if(size > (size_ref / gourmet) ) return true ; else return false ;
  }

  float ratio_food (float size, float size_ref, float nutrient_quality, float step) {
    return (size -(size_ref / step )) *nutrient_quality ;
  }










  
  /**
  MOTION

  */
  void rebound(Vec6 l, boolean rebound_on_limit) {
    if(ENVIRONMENT == 2 ) rebound(l.a, l.b, l.c, l.d, 0, 0, rebound_on_limit) ;
    else if(ENVIRONMENT == 3) rebound(l.a, l.b, l.c, l.d, l.e, l.f,  rebound_on_limit) ;
  }
  
  void rebound(float left, float right, float top, float bottom, float front, float back, boolean rebound_on_limit) {
    Vec3 pos_temp = Vec3(pos.x, pos.y,pos.z);
    Vec3 dir_temp = Vec3(dir.x, dir.y, dir.z);
    
    if(rebound_on_limit) {
      dir_temp.set(rebound(left, right, top, bottom, front, back, pos_temp, dir_temp)) ;
      dir.set(dir_temp) ;
    } else {
      Vec3 motion_temp = Vec3(motion.x, motion.y,motion.z) ;
      motion_temp.set(jump(left, right, top, bottom, front, back, motion_temp)) ;
      motion.set(motion_temp) ;
    }
  }


  // local method
  Vec3 rebound(float left, float right, float top, float bottom, float front, float back, Vec3 pos, Vec3 dir) {
    // here we use size to have a physical rebound
    int effect = size ;
    left -=effect ;
    right +=effect ;
    top -=effect ;
    bottom +=effect ;
    front -=effect;
    back +=effect;

    // detection x
    if(pos.x > right ) dir.x *= -1 ;
    else if (pos.x < left ) dir.x *= -1 ;
    // detection y
    if(pos.y > bottom) dir.y *= -1 ;
    else if (pos.y < top ) dir.y *= -1 ;
    // detection z
    if(pos.z > front) dir.z *= -1 ;
    else if (pos.z < back ) dir.z *= -1 ;
    return Vec3(dir) ;
  }


  Vec3 jump(float left, float right, float top, float bottom, float front, float back, Vec3 motion) {
    // here we use sense_range to find a good jump
    int effect = sense_range ;
    left -=effect ;
    right +=effect ;
    top -=effect ;
    bottom +=effect ;
    front -=effect;
    back +=effect;

    if(motion.x > right ) motion.x = left ;
    else if (motion.x < left ) motion.x = right ;
    // detection y
    if(motion.y > bottom) motion.y = top ;
    else if (motion.y < top ) motion.y = bottom  ;
    // detection z
    if(motion.z > back) motion.z = front ;
    else if (motion.z < front ) motion.z = back ;
    return Vec3(motion) ;
  }



  void motion() {
    velocity_update() ;
    velocity_xyz.set(velocity) ;
    velocity_xyz.mult(dir) ;
    motion.add(velocity_xyz) ;
    if(ENVIRONMENT == 2 ) pos.set(motion.x, motion.y, 0) ; else if(ENVIRONMENT == 3 ) pos.set(motion.x, motion.y, motion.z) ;
  }


  void change_direction() {
    dir.set(Vec3("RANDOM", 1)) ;
  }


  void velocity_update() {
    float ratio = vel_normal ;
    if(starving_bool) {
     // printTempo(90, "Starving") ;
      // starving
      if(tracking) {
        ratio = vel_fast_2 *vel_slow_1 ;
      //  printTempo(90, "tracking", ratio) ;
      }
      if(watching) {
        ratio = vel_normal *vel_slow_1  ;
     //   printTempo(90, "watching", ratio) ;
      }
      if(tracking_partner) {
        ratio = vel_fast_1 *vel_slow_1  ;
     //   printTempo(90, "tracking_partner", ratio) ;
      }
      if(satiate) {
        ratio = vel_normal *vel_slow_1 ;
     //   printTempo(90, "satiate", ratio) ;
      }
    } else {
      // normal
      if(tracking) ratio = vel_fast_2 ;
      if(watching) ratio = vel_normal ;
      if(tracking_partner) ratio = vel_fast_1 ;
      if(satiate) ratio = vel_normal ;
    }
    this.velocity = this.velocity_ref *ratio ;
  }








  /**
  STATEMENT


  */


  boolean just_after_satiate ;

  void statement() {
    int change_activity_every_frame = 300 ;

    maturity() ;
    time_to_eat() ;
    welfare() ;

    // migration
    if(starving_bool) {
      migration(change_activity_every_frame) ;
    }
    
    // chill attitude > walk time
    if(satiate) {
      float new_ratio_velocity_normalize = .5 ;
      if(just_after_satiate) { 
        chill(1, new_ratio_velocity_normalize) ;
        just_after_satiate = false ;
      }
      chill(change_activity_every_frame, new_ratio_velocity_normalize)  ;
    } else {
      velocity = velocity_ref ;
      just_after_satiate = true ;
    }

    if(!alive) dir.set(Vec3(0)) ;
  }

  /**
  BEHAVIOR GLOBAL


  */
  /**
  welfare
  */
  void welfare() {
    // modify by satiating
    level_satisfaction(satiate) ;
   // if(frameCount%300 == 0 )println(ID, level_satisfaction, level_dissatisfaction) ;
  }

  void level_satisfaction(boolean satisfaction) {
    if(!satiate) {
      if(level_dissatisfaction < threshold_dissatisfaction) level_dissatisfaction++ ;
      if(level_satisfaction > 0) level_satisfaction-- ;
    } else {
      if(level_satisfaction < threshold_satisfation) level_satisfaction++ ;
      if(level_dissatisfaction > 0) level_dissatisfaction-- ;
    }
  }



  /**
  chill
  */
  void chill(int step, float ratio_speed_motion) {
    if(frameCount%step == 0) {
      // velocity = velocity_ref *ratio_speed_motion ;
      //dir.set(Vec3("RANDOM", 1)) ;
      change_direction() ;
    }
  }


  /**
  migration

  */
  void migration(int step) {
    if(frameCount%step == 0) {
      change_direction() ;
    }
  }






  /**
  INFO

  */
  void info_visual(Vec4 colour) {
    Vec3 pos_temp = Vec3(0) ;
    aspect(Vec4(0), colour_info(colour, satiate, pregnant, fertility), 1) ;
    start_matrix() ;
    translate(pos) ;
    ellipse(pos_temp.x, pos_temp.y, size *2, size *2) ;
    stop_matrix() ;
  }

  void info_text(Vec4 colour, int size_text) {
    aspect(colour_info(colour, satiate, pregnant, fertility), colour_info(colour, satiate, pregnant, fertility), 1) ;
    Vec2 pos_text = Vec2(0) ;
    start_matrix() ;
    translate(pos) ;
    textSize(size_text) ;
    textAlign(CENTER) ;
    float [] space = {0, 1.2, 2.4, 3.6 } ;
    text(name , pos_text.x, pos_text.y +(size_text *space[0])) ;
    text("Generation " + generation + " Gender " + gender, pos_text.x, pos_text.y +(size_text *space[1])) ;
    text(stamina + " " + size + " " + size_ref, pos_text.x, pos_text.y +(size_text *space[2])) ;
    if(alive) {
      if (eating) {
        text("I'm eating", pos_text.x, pos_text.y +(size_text *space[3])) ;
      } else {
        if(satiate) {
          text("I'm satiating", pos_text.x, pos_text.y +(size_text *space[3])) ;
        } else {
          text("I'm hungry", pos_text.x, pos_text.y +(size_text *space[3])) ;
        }
      }
    } else {
      if(!carrion) {
        text("I'm dead", pos_text.x, pos_text.y +(size_text *space[3])) ; 
      } else {
        text("I'm carrion", pos_text.x, pos_text.y +(size_text *space[3])) ; 
      }
    }
    stop_matrix() ;
  }

  /**
  Print

  */

  void info_print() {
    // basic Agent info
    println(this.name + " " +this.getClass().getSimpleName()) ;
    info_print_caracteristic() ;
    info_print_motion() ;
    info_print_life() ;
    info_print_feeding() ;
    info_print_hunting_picking() ;
  }


  void info_print_motion() {
    println("MOTION",this.name) ;
    println(this.ID, "velocity", this.velocity_ref) ;
    println(this.ID, "current velocity", this.velocity) ;
    println(this.ID, "position", this.pos) ;
    println(this.ID, "direction", this.dir) ;
    println(this.ID, "motion", this.motion) ;
  }


  void info_print_life() {
    println("LIFE",this.name) ;
    println(this.ID, "life", this.life) ;
    println(this.ID, "stamina", this.stamina) ;
    println(this.ID, "alive", this.alive) ;
    println(this.ID, "carrion", this.carrion) ;
  }

  void info_print_feeding() {
    println("FEED",this.name) ;
    println(this.ID, "satiate", this.satiate) ;
    println(this.ID, "eating", this.eating) ;
    println(this.ID, "hunger level", this.hunger) ;
    println(this.ID, "hunger", this.hunger_bool) ;
    println(this.ID, "starving", this.starving_bool) ;
  }

  void info_print_hunting_picking() {
    println("HUNT / PICK",this.name) ;
    println(this.ID, "watching", this.watching) ;
    println(this.ID, "tracking", this.tracking) ;
  }








  /**
  LOG

  */
  Table log_a_d ;
  TableRow [] tableRow_a_d ;
  Info_obj [] info_a_d  ;
  int col_num = 4 ;
  int row_num = 30 ;
  boolean log_is ;

  boolean log_is() {
    return log_is ;
  }

  // build
  void build_log() {
    log_is = true ;
    log_a_d = new Table();
    tableRow_a_d = new TableRow[row_num] ;
    info_a_d = new Info_obj [row_num] ;
    for (int i = 0 ; i < row_num ; i++) {
      tableRow_a_d[i] = log_a_d.addRow();
    }
    

    // Col
    String [] col_name = new String[col_num] ;
    col_name[0] = "Agent" ;
    col_name[1] = "value x" ;
    col_name[2] = "value y" ;
    col_name[3] = "value z" ;
    // row
    String [] row_name = new String[row_num] ;
    int rank = 0 ;
    row_name[rank++] = "Name" ;
    // row_name[rank++] = "Species" ;
    // row_name[rank++] = "ID" ;
    row_name[rank++] = "Gender" ;
    row_name[rank++] = "Generation" ;
    row_name[rank++] = "Sex appeal" ;
    row_name[rank++] = "Multiple pregnancy" ;
    row_name[rank++] = "Pregnancy" ;
    row_name[rank++] = "Children" ;
    row_name[rank++] = "Homozygous" ;
    row_name[rank++] = "Heterozygous" ;

    row_name[rank++] = "Life" ;

    row_name[rank++] = "Size" ;

    row_name[rank++] = "Stamina" ;

    row_name[rank++] = "Sense range" ;
    
    row_name[rank++] = "Velocity" ;
    row_name[rank++] = "Position" ;

    row_name[rank++] = "Satiate" ;
    row_name[rank++] = "Starving" ;
    row_name[rank++] = "Hunger" ;
    row_name[rank++] = "Leptin" ;
    row_name[rank++] = "Eating" ;

    row_name[rank++] = "Watching" ;
    row_name[rank++] = "Tracking" ;

    row_name[rank++] = "Alive" ;
    row_name[rank++] = "Carrion" ;

    row_name[rank++] = "Log sequence" ;
    buildTable(log_a_d, tableRow_a_d, col_name, row_name) ;
  } 
  
  // update
  void log(int tempo) {
    if(frameCount%tempo == 0) {
      int rank = 0 ;
      info_a_d[rank++] = new Info_obj ("Name", name, this.getClass().getSimpleName(), ID) ;
      if(gender ==0 ) info_a_d[rank++] = new Info_obj ("Gender", "Female") ; else info_a_d[rank++] = new Info_obj ("Gender", "Male") ;
      info_a_d[rank++] = new Info_obj ("Generation", generation) ;
      info_a_d[rank++] = new Info_obj ("Sex appeal", sex_appeal) ;
      info_a_d[rank++] = new Info_obj ("Multiple pregnancy", multiple_pregnancy) ;
      info_a_d[rank++] = new Info_obj ("Pregnancy", num_pregnancy) ;
      info_a_d[rank++] = new Info_obj ("Children", num_children) ;
      info_a_d[rank++] = new Info_obj ("Heterozygous", num_heterozygous) ;
      info_a_d[rank++] = new Info_obj ("Homozygous", num_homozygous) ;

      info_a_d[rank++] = new Info_obj ("Life", life, life_expectancy) ;

      info_a_d[rank++] = new Info_obj ("Size", size, size_ref) ;

      info_a_d[rank++] = new Info_obj ("Stamina", stamina, stamina_ref) ;

      info_a_d[rank++] = new Info_obj ("Sense range", sense_range) ;
      
      info_a_d[rank++] = new Info_obj ("Velocity", velocity) ;
      info_a_d[rank++] = new Info_obj ("Position", pos.x, pos.y, pos.z) ;
      // info
      info_a_d[rank++] = new Info_obj ("Satiate", satiate) ;
      info_a_d[rank++] = new Info_obj ("Starving", starving_bool) ;
      info_a_d[rank++] = new Info_obj ("Hunger", hunger) ;
      info_a_d[rank++] = new Info_obj ("Leptin", leptin) ;
      info_a_d[rank++] = new Info_obj ("Eating", eating) ;

      info_a_d[rank++] = new Info_obj ("Watching", watching) ;
      info_a_d[rank++] = new Info_obj ("Tracking", tracking) ;

      info_a_d[rank++] = new Info_obj ("Alive", alive) ;
      info_a_d[rank++] = new Info_obj ("Carrion", carrion) ;
      
      info_a_d[rank++] = new Info_obj ("Log sequence", SEQUENCE_LOG) ;
      //
      setTable(log_a_d, tableRow_a_d, info_a_d) ;
 
      //
      saveTable(log_a_d, "log/Log_"+save_date()+"/agent/agent_specific_"+name+"/Seq_"+SEQUENCE_LOG+"_Time_"+hour()+"'"+minute()+"''"+second()+"'''/log_"+name+"_"+SEQUENCE_LOG+"_"+ID+".csv");
    }
  }
}

/**

END AGENT DYNAMIC

*/






























/**


Agent Static 0.2.0


*/
abstract class Agent_static extends Agent_model {
  /**
  specific
  */ 
  int speed_growth = 1 ;
  float need = 1. ;

  /**
  Constructor

  */
  Agent_static(Vec3 pos, int size, String name) {
    this.pos.set(pos) ;
    this.name = name ;
    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
    this.size = this.size_ref = this.size_max  = size ;
  }

  Agent_static(Info_dict carac, Info_obj style, int gender) {
    String temp_name = "Nobody" ;
    int temp_size = 1 ;
    this.ID = (short) Math.round(random(Short.MAX_VALUE)) ;
    if (carac.get("name") != null) temp_name = (String) carac.get("name")[0].catch_obj(0) ;
    if (carac.get("size") != null) temp_size = (int) random_gaussian((int)carac.get("size")[0].catch_obj(0)) ;

    this.name = temp_name ;
    this.size = this.size_ref = this.size_max = temp_size ;
    this.gender = gender ;
  }
  
  /**
  set position
  * set_pos(arg) is not in the abstract class because for the dynamic agent the method is specific.
  */
  void set_pos(Vec pos) {
    if(pos instanceof Vec3) {
      Vec3 temp_pos = (Vec3) pos ;
      this.pos.set(temp_pos) ;
    }
    if(pos instanceof Vec2) {
      Vec2 temp_pos = (Vec2) pos ;

      this.pos.set(temp_pos.x, temp_pos.y,0) ;
    }
  }

  /**
  carrion
  */

  void carrion() {
    int threshold = 2 ;
    if(!alive) {
      dead_since += int(1. *CLOCK) ;
      if(size < size_ref / threshold || dead_since > TIME_TO_BE_CARRION) carrion = true ; 
      else carrion = false ;
    } 
  }

  /**
  info
  */
  void info_text(Vec4 colour, int size_text) {
    aspect(colour, colour, 1) ;
    Vec2 pos_text = Vec2(0) ;
    start_matrix() ;
    translate(pos) ;
    textSize(size_text) ;
    textAlign(CENTER) ;
    text(name, pos_text.x, pos_text.y) ;
    text(stamina + " " + size + " " + size_ref, pos_text.x, pos_text.y +(size_text *1.2) ) ;
    textSize(16) ;
    if(alive) {
      text("I'm alive", pos_text.x, pos_text.y +(size_text *2.4) ) ;
    } else {
      text("I'm dead", pos_text.x, pos_text.y +(size_text *2.4) ) ;
    }
    stop_matrix() ;
  }
}
/**
END Agent Static
*/