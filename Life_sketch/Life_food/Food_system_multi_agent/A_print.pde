  /**
  INFO 0.0.2
  */

  void print_info_environment() {
    println("ENVIRONMENT") ;
    println("Humus", HUMUS) ;
  }


  void print_info_herbivore(ArrayList<Herbivore> list_h) {
    for(Herbivore h : list_h) {
          // h.info_print_agent_() ;
      // h.info_print_agent_motion() ;
      //h.info_print_agent_structure() ;
      h.info_print_agent_statement() ;
      h.info_print_herbivore() ;
    }
  }

  void print_info_bacterium(ArrayList<Bacterium> list_b) {
    for(Bacterium b : list_b) {
          // b.info_print_agent_() ;
      // b.info_print_agent_motion() ;
      b.info_print_agent_structure() ;
      b.info_print_agent_statement() ;
      b.info_print_bacterium() ;
    }
  }

  void print_info_carnivore(ArrayList<Carnivore> list_c) {
    for(Carnivore c : list_c) {
      // c.info_print_agent() ;
      // c.info_print_agent_motion() ;
      c.info_print_agent_structure() ;
      c.info_print_agent_statement() ;
      c.info_print_carnivore() ;
    }
  }


  void print_list(){
    println("Flora", FLORA_LIST.size()) ;
    println("Bacterium",BACTERIUM_LIST.size()) ;
    println("Herbivore",HERBIVORE_LIST.size()) ;
    println("Carnivore",CARNIVORE_LIST.size()) ;
    println("Corpse",CORPSE_LIST.size()) ;
  }
  /**
  END INFO
  */