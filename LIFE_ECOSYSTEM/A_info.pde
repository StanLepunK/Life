/**

INFO & LOG 0.1.0

*/

void info_agent(boolean info) {
  INFO_DISPLAY_AGENT = info ;
}
/**
INFO
*/
void info_ecosystem(int tempo) {
    if(frameCount%tempo == 0) {
    if (PRINT_POPULATION) {
      print_population() ;
    }
    // print_info_environment(biomass) ;
    //print_list() ;
    // print_info_carnivore(CARNIVORE_CHILD_LIST) ;
    print_info_herbivore("Child", HERBIVORE_CHILD_LIST) ;
    print_info_herbivore("Female", HERBIVORE_FEMALE_LIST) ;
    print_info_herbivore("Male", HERBIVORE_MALE_LIST) ;
    // print_info_bacterium(BACTERIUM_LIST) ;
  }
}

void print_population() {
  println(frameCount) ;
  print_pop_agent_dynamic("Population Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
  print_pop_agent_dynamic("Population Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
  print_pop_agent_dynamic("Population Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
  print_pop_agent_dynamic("Population Bacterium", BACTERIUM_LIST) ;
  print_pop_agent_dynamic("Population Dead Bodies", DEAD_LIST) ;
}


void print_list() {
  println("Flora", FLORA_LIST.size()) ;

  println("Bacterium",BACTERIUM_LIST.size()) ;

  println("Herbivore child",HERBIVORE_CHILD_LIST.size()) ;
  println("Herbivore female",HERBIVORE_FEMALE_LIST.size()) ;
  println("Herbivore male",HERBIVORE_MALE_LIST.size()) ;

  println("Carnivore",CARNIVORE_CHILD_LIST.size()) ;
  
  println("Corpse",DEAD_LIST.size()) ;
}
/**
LOG
*/




void log_ecosystem(int tempo) {

  /**
  log population
  */
  if(frameCount%tempo == 0 && LOG_ECOSYSTEM) {
    // log eco agent
    int num_log_eco_agent = 6 ;
    if(!log_is()) {
      build_log(num_log_eco_agent) ;
    }

    log_eco_agent() ;
    log_eocsystem_resume() ;
    log_agent_global() ;

    log_save() ;
  }
}


// local log method
void log_eocsystem_resume() {
      log_eco_resume(   biomass.humus, biomass.humus_max, 
                      HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST,
                      OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST,
                      CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST,
                      BACTERIUM_LIST,
                      FLORA_LIST,
                      DEAD_LIST) ;

}

void log_eco_agent() {
  if(LOG_ALL_AGENTS) {
      log_eco_agent(0, "Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
      log_eco_agent(1, "Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
      log_eco_agent(2, "Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
      log_eco_agent(3, "Bacterium", BACTERIUM_LIST) ;
      log_eco_agent(4,  "Flora", FLORA_LIST) ;
      log_eco_agent(5,  "Dead", DEAD_LIST) ;
    } else {
      if(LOG_HERBIVORE) log_eco_agent(0, "Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
      if(LOG_OMNIVORE)  log_eco_agent(1, "Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
      if(LOG_CARNIVORE)  log_eco_agent(2, "Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
      if(LOG_BACTERIUM) log_eco_agent(3, "Bacterium", BACTERIUM_LIST) ;
      if(LOG_FLORA) log_eco_agent(4,  "Flora", FLORA_LIST) ;
      if(LOG_DEAD) log_eco_agent(5,  "Dead", DEAD_LIST) ;
    }

}

void log_agent_global() {
  if(LOG_ALL_AGENTS) {
    log_agent_global("Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    log_agent_global("Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    log_agent_global("Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    log_agent_global("Bacterium", BACTERIUM_LIST) ;
    log_agent_global("Flora", FLORA_LIST) ;
    log_agent_global("Dead", DEAD_LIST) ;
  } else {
    if(LOG_HERBIVORE) log_agent_global("Herbivore", HERBIVORE_CHILD_LIST, HERBIVORE_FEMALE_LIST, HERBIVORE_MALE_LIST) ;
    if(LOG_OMNIVORE) log_agent_global("Omnivore", OMNIVORE_CHILD_LIST, OMNIVORE_FEMALE_LIST, OMNIVORE_MALE_LIST) ;
    if(LOG_CARNIVORE) log_agent_global("Carnivore", CARNIVORE_CHILD_LIST, CARNIVORE_FEMALE_LIST, CARNIVORE_MALE_LIST) ;
    if(LOG_BACTERIUM) log_agent_global("Bacterium", BACTERIUM_LIST) ;
    if(LOG_BACTERIUM) log_agent_global("Flora", FLORA_LIST) ;
    if(LOG_DEAD) log_agent_global("Dead", DEAD_LIST) ;
  }
}
/**
END LOG & PRINT
*/