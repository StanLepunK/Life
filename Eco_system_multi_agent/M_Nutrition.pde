/**
NUTRITION


*/

void picking_update(ArrayList<Agent> list_picker, ArrayList<Agent> list_target, boolean info) {
  for(Agent a : list_picker) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic picker = (Agent_dynamic) a ;
      if(!picker.satiate) {
        search_flora(picker, list_target, info) ;
      }
      eat_flora(picker, list_target, info) ;
    }
  }
}

void hunting_update(ArrayList<Agent> list_hunter, boolean info, ArrayList<Agent>... all_list) {
  for( ArrayList list_target : all_list) {
    for(Agent a : list_hunter) {
      if(a instanceof Agent_dynamic) {
        Agent_dynamic hunter = (Agent_dynamic) a ;
        if(!hunter.satiate && !hunter.eating) hunt(hunter, list_target, info) ;   
      }
    }
  }
}

void eating_update(ArrayList<Agent> list_hunter, ArrayList<Agent> list_dead, boolean info) {
  for(Agent a : list_hunter) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic hunter = (Agent_dynamic) a ;
      // eat
      if(list_dead.size() >= 0 ) {
        eat_meat(hunter, list_dead, info) ; 
      } else {
        hunter.eating = false ;
      }
    }
  }
}










/**
SEARCH


*/
/**
search flora
*/
void search_flora(Agent_dynamic grazer, ArrayList<Agent> list_target_food, boolean info) {
  for(Agent a : list_target_food) {
    if(a instanceof Flora) {
      Flora target = (Flora) a ;
      grazer.watch(target, list_target_food, info) ;
      grazer.pick(target) ;
      if(grazer.picking()) break ;
    }
  }
}


/**
search creature
*/
void hunt(Agent_dynamic hunter, ArrayList<Agent> list_target, boolean info) {
  // first watch the agent who watch just before without look in the list
  if(hunter.watching) find_target_hunter(hunter, list_target, info) ;

  if(hunter.tracking && hunter.max_time_track > hunter.time_track) {
    track_target(hunter, list_target, info) ; 
  } else {
    hunter.hunt_stop() ;
  }
}



// Local method : The hunt is launching !
void track_target(Agent_dynamic hunter, ArrayList<Agent> list_target, boolean info) {
   if (hunter.focus_target(list_target)) {
    hunt_and_kill_target(hunter, hunter.target, info) ;
   } else {
    hunter.hunt_stop() ;
  }
}
// super local method
void hunt_and_kill_target(Agent_dynamic hunter, Agent target, boolean info) {
  if(target instanceof Agent_dynamic) {
    Agent_dynamic target_d = (Agent_dynamic) target ;
    if(hunter.dist_to_target(target_d, info) < hunter.sense_range) {
      hunter.hunt(target_d, info) ; 
      hunter.kill(target_d, info) ;
    } else hunter.hunt_stop() ;
  }
}

/**
Find new target, Big Brother is hunting you !
*/
void find_target_hunter(Agent_dynamic hunter, ArrayList<Agent> list_target, boolean info) {
  // float [] dist_list = new float[0] ;
  ArrayList <Vec3> closest_target = new ArrayList<Vec3>() ;
  // find the closest target 
  for(Agent a : list_target) {
    if(a instanceof Agent_dynamic) {
      Agent_dynamic target_d = (Agent_dynamic) a ;
      if(hunter.dist_to_target(target_d, info) < hunter.sense_range) {
        float dist = hunter.dist_to_target(target_d, info) ;
        // catch distance to compare with the last one
        // plus catch index in the list and the ID target
        // and add in the nice target list

        Vec3 new_target = Vec3(dist, list_target.indexOf(target_d), target_d.get_ID()) ;
        closest_target.add(new_target) ;
        // compare the target to see which one is the closest.
        if(closest_target.size() > 1) if (closest_target.get(1).x <= closest_target.get(0).x ) closest_target.remove(0) ; else closest_target.remove(1) ;
      } 
    }
  }

  // Start the hunt party with the selected target
  if(closest_target.size() > 0 ) {
    Agent a = list_target.get((int)closest_target.get(0).y) ;
    if(a instanceof Agent_dynamic) {
      Agent_dynamic target_d = (Agent_dynamic) a ;
      hunter.hunt(target_d, info) ;
      hunter.kill(target_d, info) ;
      if(hunter.tracking) hunter.ID_target.set(list_target.indexOf(target_d),target_d.get_ID()) ;
    }
  }
}











/**
EAT


*/
/**
eating flora
*/
void eat_flora(Agent_dynamic grazer, ArrayList<Agent> list_target, boolean info) {
  if(grazer.eating) {
    Agent a ;
    if((int)grazer.ID_target.x < list_target.size()) {
      a = list_target.get((int)grazer.ID_target.x) ;
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.eat_veg(target, info) ;
      }
    }
  } else if (!grazer.eating) {
    for(Agent a : list_target) {
      if(a instanceof Flora) {
        Flora target = (Flora) a ;
        grazer.eat_veg(target, info) ;
        if(grazer.eating) {
          if((int)grazer.ID_target.x < list_target.size()) {
            grazer.ID_target.set(list_target.indexOf(a),target.ID) ;
            break ;
          }
        }
      }
    }
  }
}

/**
eat meat
*/
void eat_meat(Agent_dynamic hunter, ArrayList<Agent> list_dead, boolean info) {
  // first eat the agent who eat just before without look in the list
  if(hunter.eating) {
    int pointer = (int)hunter.ID_target.x ;
    int ID_target = (int)hunter.ID_target.y ;
    /* here we point directly in a specific point of the list, 
    if the pointer is superior of the list, 
    because if it's inferior a corpse can be eat by an other Agent */
    if(pointer < list_dead.size() ) {
      Agent target = list_dead.get((int)hunter.ID_target.x) ;
      /* if the entry point of the list return an agent 
      with a same ID than a ID_target corpse eat just before, 
      the Carnivore can continue the lunch */
      if (target instanceof Agent_static && target.get_ID() == ID_target ) {
        Agent_static agent_meat = (Agent_static) target ;
        hunter.eat_flesh(agent_meat, info) ; 
      }
      else {
        /* If the ID returned is different, a corpse was leave from the list, 
        and it's necessary to check in the full ist to find if any corpse have a seme ID */
        for(Agent target_in_list : list_dead) {
          if (target_in_list instanceof Agent_static && target_in_list.get_ID() == ID_target) {
            Agent_static agent_meat = (Agent_static) target_in_list ;
            hunter.eat_flesh(agent_meat, info) ; 
          } else {
            hunter.eating = false ;
          }
        }
      }
    }
  /* If the last research don't find the corpse, may be this one is return to dust ! */
  } else {
    for(Agent a : list_dead) {
      if(a instanceof Agent_static) {
        Agent_static target = (Agent_static) a ;
        hunter.eat_flesh(target, info) ;
        if(hunter.eating) {
          hunter.ID_target.set(list_dead.indexOf(target),target.get_ID()) ;
          break ;
        }
      }
    }
  }
}











