/**
AGENT Methods 0.1.0
*/




/**
SHOW
*/
void show_agent_dynamic(ArrayList<Agent> list, boolean info, int which_costume) {
  if(info) {
    info_agent(list) ;
    info_agent_track_line(list) ;
  } else {
    update_aspect(list, original_carnivore_aspect, fill_colour_carnivore, stroke_colour_carnivore, thickness_carnivore, which_costume) ;
  }
}

void show_agent_dynamic(boolean info, int which_costume, ArrayList<Agent>... all_list ) {
  for(ArrayList list : all_list) {
    if(info) {
      info_agent(list) ;
      info_agent_track_line(list) ;
    } else {
      update_aspect(list, original_carnivore_aspect, fill_colour_carnivore, stroke_colour_carnivore, thickness_carnivore, which_costume) ;
    }
  }
}




/**
Aspect
*/
void update_aspect(ArrayList<Agent> list, boolean original_aspect, Vec4 new_fill, Vec4 new_stroke, float thickness, int which_costume) {
  for(Agent a : list) {
    if(original_aspect) a.aspect(a.get_fill(), a.get_stroke(), 1)  ; else a.aspect(new_fill, new_stroke, thickness) ;
    a.costume_agent(which_costume) ; 
  }
}


/**
info
*/
void info_agent(ArrayList<Agent> list) {
  for(Agent a : list) {
    a.info(a.get_fill(), SIZE_TEXT_INFO) ;
  }
}

void info_agent_track_line(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Carnivore) {
      Carnivore c = (Carnivore) a ;
      track_line(c.pos, c.pos_target, c.colour_info(c.get_stroke())) ;
      c.pos_target.set(MAX_INT) ;
    } else if (a instanceof Herbivore) {
      Herbivore h = (Herbivore) a ;
      track_line(h.pos, h.pos_target, h.colour_info(h.get_stroke())) ;
      h.pos_target.set(MAX_INT) ;
    } else if (a instanceof Omnivore) {
      Omnivore o = (Omnivore) a ;
      track_line(o.pos, o.pos_target, o.colour_info(o.get_stroke())) ;
      o.pos_target.set(MAX_INT) ;
    } else if (a instanceof Bacterium) {
      Bacterium b = (Bacterium) a ;
      track_line(b.pos, b.pos_target, b.colour_info(b.get_stroke())) ;
      b.pos_target.set(MAX_INT) ;
    }
  }
}

void track_line(Vec3 pos, Vec3 pos_target, Vec4 colour) {
  if(!pos_target.compare(Vec3(MAX_INT))) {
    stroke(colour) ;
    strokeWeight(1) ;
    line(pos, pos_target) ;
  }
}












/**
GROWTH, LIFE & DIE

*/
void update_growth(ArrayList<Agent> list) {
  for (Agent a : list) {
    a.growth() ;
  }
}


void update_die(ArrayList<Agent> list) {
  // dead, possible to add to the dead list
  for(Agent a : list) {
    if(!a.get_alive()) {
      if(a instanceof Agent_dynamic) {
        Agent_dynamic a_d = (Agent_dynamic) a ;
        if(PRINT_DEATH_AGENT_DYNAMIC) {
          print_death_agent(a_d) ;
        }
        Agent dead = new Dead(a_d.pos, a_d.size, a_d.size_ref, a_d.nutrient_quality, a_d.name) ;
        DEAD_LIST.add(dead) ;
        list.remove(a) ;
        break ;
      }
    }
  }

  //disapear, retrun to the oblivion no return as possible !
  for(Agent a : list) {
    if(a.get_size() < 0) {
      if(PRINT_DEATH_AGENT_DYNAMIC) {
        println("GO TO OBLIVION") ;
      }
      list.remove(a) ;
      break ;
    }
  }
}




  /**
Motion
*/
void update_motion(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      a_d.rebound(LIMIT, REBOUND) ;
      a_d.motion() ;
    }
  }
}


/**
Statement

*/
void update_statement(ArrayList<Agent> list) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      a_d.statement() ;
      a_d.hunger() ;
    }
  }
}


void update_log(ArrayList<Agent> list, int tempo) {
  for(Agent a : list) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic a_d = (Agent_dynamic) a ;
      if(!a_d.log_is()) a_d.build_log() ;
      a_d.log(tempo) ;
    }
  }
}





























































