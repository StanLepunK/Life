/**
Creature 0.1.2

*/

class Creature {
  // misc
  Vec2 pos = Vec2() ;
  Vec2 dir = Vec2() ;
  float velocity = 0  ;

  int ID = 0 ;

  // caracteristic
  int gender ;
  int size ;
  // cycle life
  int life_expectancy ;
  int life ;
  int age ;

  /**
  reproduction
  */
  int generation = 0 ;
  Genome genome ;
  Genome genome_father ;

  int puberty ;
  int fertility_cycle ;
  int fertility_time_ref  ;
  int pregnant_term   ;
  
  int fertility_time ;

  boolean fertility = false ;
  int fertility_rate = 1 ;
  int pregnant_time = 0  ;
  boolean pregnant = false ;

  int reproduction_area ;
  int factor_reproduction_area_female = 2 ;
  int factor_reproduction_area_male = 20 ;
  /**
  constructor example
  */
  Creature(int size, int life_expectancy_sec, int gender) {
    println("life_expectancy original", life_expectancy_sec) ;
    int life_expectancy_temp = int(life_expectancy_sec *frameRate) ;
    init_var_life_cycle(life_expectancy_temp) ;

    this.generation++ ;
    if(this.gender == 0) {
      reproduction_area = size *factor_reproduction_area_female ; 
    } else if (this.gender == 1) { 
      reproduction_area = size *factor_reproduction_area_male ;
    }
    build_archetype_genome(size, generation, life_expectancy_sec, gender) ;
    this.size = (int)genome.get_gene_product("0").f_a ;
    this.gender = gender ;
  }

  

  /**
  Constructor example by genetic methode
  */
  Creature(Genome mother, Genome father) {
    // update gene generation from mother line
    this.generation = (int)(Float.parseFloat(mother.get_gene("1").data_left_arm)) ;
    this.generation++ ;

    // create child genome
    genome = genotype(mother, father) ;
    // write mutation info in the genome
    genome.mutation_data(0, 1, String.valueOf(generation), true, true);
   
    
    // setting
    this.size = (int)genome.get_gene_product("0").f_a ;
    // the gene 2, is the generation of the creature
    // println("generation", String.valueOf(generation)) ;
    println("life_expectancy heritage", (int)genome.get_gene_product("2").f_a) ;
    int life_expectancy_temp = int(genome.get_gene_product("2").f_a *frameRate) ;
    init_var_life_cycle(life_expectancy_temp) ;

    if(genome.get_gene_product("XX").s_a == "X") {
      this.gender = 0  ; 
    } else { 
      this.gender = 1 ;
    }
    if(this.gender == 0) {
      reproduction_area = size *factor_reproduction_area_female ; 
    } else if (this.gender == 1) { 
      reproduction_area = size *factor_reproduction_area_male ;
    }
  }





  /**
  // build genome
  */





  void build_archetype_genome(int size, int generation, int life_expectancy_sec, int gender) {
    float [] data = new float[3] ;
    data[0] = size ;
    data[1] = generation ;
    data[2] = life_expectancy_sec ;
    genome = archetype(data, gender) ;
  }
  
  /**
  Setting
  */
  /**
  internal setting for constructor
  based on arbitrary life cycle model
  */
  void init_var_life_cycle(int life_expectancy_temp) {
    this.life_expectancy = life_expectancy_temp ;
    this.life = life_expectancy ;
    puberty = life_expectancy / 15 ;
    fertility_cycle = life_expectancy / 45 ;
    fertility_time_ref = fertility_cycle / 5 ;
    pregnant_term = fertility_cycle *10  ;
  }







  /**
  set caracteristic
  */
  void set_life(int life_expectancy_sec) {
    this.life_expectancy = int(life_expectancy_sec *frameRate) ; ;
  }



  /**
  set reproduction var
  */
  void set_puberty(int puberty) {
    this.puberty = int(puberty *frameRate) ;
  }
  void set_fertility_cycle(int fertility_cycle) {
    this.fertility_cycle = int(fertility_cycle *frameRate) ;
  }
  void set_fertility_time(int fertility_time) {
    this.fertility_time_ref = int(fertility_time *frameRate) ;
  }
  void set_pregnant_term(int pregnant_term) {
    this.pregnant_term = int(pregnant_term *frameRate) ;
  }
  
  void set_fertility_rate(int rate) {
    this.fertility_rate = rate ;
  }

  void set_reproduction_area(int reproduction_area) {
    this.reproduction_area = reproduction_area ;
  }


  /**
  set misc
  */

  void set_ID(int ID) {
    this.ID = ID ;
  }

  /**
  set motion, position...
  */

  void set_pos(Vec2 pos) {
    this.pos = Vec2(pos) ;
  }

  void set_dir(Vec2 dir) {
    this.dir = Vec2(dir) ;
  }

  void set_velocity(float velocity) {
    this.velocity = velocity ;
  }


  /**
  growth
  */

  void growth() {
    puberty() ;
    age() ;
    life() ;
  }
  
  void puberty() {
    if(puberty > 0) puberty-- ;
  }

  void life() {
    life-- ;
  }

  void age() {
    age++ ;
  }


  /**
  reproduction method
  */



  void fertility(int time) {
    if(frameCount%1000 == 0 ) {
      println("generation", generation) ;
      println("time", time / 1000) ;
      println("Fertility Cycle", fertility_cycle) ;
      println("life expectancy", life_expectancy) ;
    }
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
}