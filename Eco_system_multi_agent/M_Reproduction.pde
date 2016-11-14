/**
REPRODUCTION AGENT DYNAMIC

*/
boolean check_male_reproducer(Agent female, ArrayList<Agent> list_target) {
  boolean result = false ;
  if(list_target.size() > 0) {
    for (Agent male : list_target) {
      if(male instanceof Agent_dynamic && female instanceof Agent_dynamic) {
        Agent_dynamic m = (Agent_dynamic) male ;
        Agent_dynamic f = (Agent_dynamic) female ;
        if(dist(f.pos, m.pos) < f.reproduction_area) {
          result = true ;
          // must be create method copy but smell very complexe thing to do
          f.genome_father = m.genome ;
          break ; 
        } else result = false ;
      } else result = false ;
    }
  } else result = false ;
  return result ;
}


/**
Male Reproduction
*/
void reproduction_male(ArrayList<Agent> list_f, ArrayList<Agent> list_m) {
  for (Agent f : list_f) {
    if(f instanceof Agent_dynamic) {
      Agent_dynamic f_a_d = (Agent_dynamic) f ;
      if(f_a_d.fertility && check_female_reproducer(f, list_m)) ;
    }
  }
}

boolean check_female_reproducer(Agent female, ArrayList<Agent> list_target_male) {
  boolean result = false ;
  if(list_target_male.size() > 0) {
    for (Agent male : list_target_male) {
      if(male instanceof Agent_dynamic && female instanceof Agent_dynamic) {
        Agent_dynamic m = (Agent_dynamic) male ;
        Agent_dynamic f = (Agent_dynamic) female ;
        if(dist(female.get_pos(), male.get_pos()) < f.sex_appeal) {
          f.pos_target.set(male.get_pos()) ;
          m.tracking_partner = true ;
          // float ratio_acceleration_to_see_female = 1.3 ;
          // m.velocity = m.velocity_ref *ratio_acceleration_to_see_female ;
          m.dir.set(target_direction(f.pos, m.pos)) ;
          result = true ; 
        } else {
          result = false ;
          m.tracking_partner = false ;
        }
      } else {
        result = false ;
      }
    }
  } else result = false ;
  return result ;
}




/**
DELIVERY
*/
int num_by_pregnancy = 1 ;

void delivery(Agent_dynamic deliver, Genome mother, Genome father, ArrayList<Agent> list_child, Info_dict carac) {
  // check for heterozygote
  num_babies(deliver.multiple_pregnancy) ;
  Agent [] babies = new Agent [num_by_pregnancy] ;
  babies = babies(deliver, num_by_pregnancy, mother, father) ;
  for(int i = 0 ; i < num_by_pregnancy ; i++) {
    set_baby(deliver, babies[i], list_child, carac) ;
    if(PRINT_BORN_AGENT_DYNAMIC) print_born_agent_dynamic (babies[i]) ;
  }
  deliver.num_pregnancy ++ ;
  num_by_pregnancy = 1 ;
}

// local
void set_baby(Agent_dynamic deliver, Agent baby, ArrayList<Agent> list_child, Info_dict carac) {
  if(baby instanceof Agent_dynamic) {
    Agent_dynamic n = (Agent_dynamic) baby ;
    // clean the uterus of mother
    deliver.genome_father = null ;
    // set motion of the baby
    n.set_pos(deliver.pos) ;
    n.dir = Vec3("RANDOM",1) ;
    // here we change velocity to don't have a same from parent, can be change that in the future
    float new_velocity = deliver.velocity +random(-1,1) ;
    if(new_velocity < .1) new_velocity = .1 ;
    n.set_velocity(new_velocity) ;

    // all data from mother
    // Must add this part in the genome for the future,
    if(baby instanceof Carnivore) set_carnivore(n, deliver.pos, carac, deliver.colour_fill) ;
    if(baby instanceof Herbivore) set_herbivore(n, deliver.pos, carac, deliver.colour_fill) ;
    if(baby instanceof Omnivore) set_omnivore(n, deliver.pos, carac, deliver.colour_fill) ; 

    n.set_ID( (short) Math.round(random(Short.MAX_VALUE))) ;
    list_child.add(n) ;
  }
}


Agent [] babies(Agent_dynamic deliver, int num, Genome mother, Genome father) {
  Agent [] b = new Agent [num] ;
  // re-init for the pregnancy
  String monster_message = "The mother deliver a genetic monster, and the 'Nature of Code' kill it because is not a baby from a Authorized Class" ;

  for(int i = 0 ; i < b.length ; i++) {
    // check for homozygous
    if(b.length > 1 && i <  b.length -1 && random(3) < 1) {
      deliver.num_children += 2 ;
      deliver.num_homozygous += 2 ;
      if(deliver instanceof Herbivore ) b[i] = new Herbivore(mother, father) ;
      else if(deliver instanceof Omnivore ) b[i] = new Omnivore(mother, father) ;
      else if(deliver instanceof Carnivore ) b[i] = new Carnivore(mother, father) ;
      else println(monster_message) ;
      i++ ;
      if(deliver instanceof Herbivore ) b[i] = b[i -1] ;
      else if(deliver instanceof Omnivore ) b[i] = b[i -1] ;
      else if(deliver instanceof Carnivore ) b[i] = b[i -1] ;
      else println(monster_message) ;
    } else {
      deliver.num_children++ ;
      if(b.length > 1) deliver.num_heterozygous++ ;
      if(deliver instanceof Herbivore ) b[i] = new Herbivore(mother, father) ;
      else if(deliver instanceof Omnivore ) b[i] = new Omnivore(mother, father) ;
      else if(deliver instanceof Carnivore ) b[i] = new Carnivore(mother, father) ;
      else println(monster_message) ;
    }
  }
  return b ;
}



void num_babies(float ratio_multi) {
  int max = 100 ;    
  float draw = random(max) ;
  // security
  int max_babies = 100 ;

  if(draw < ratio_multi && num_by_pregnancy < max_babies) {
    num_by_pregnancy++ ;
    num_babies(ratio_multi) ;
  }
}






/**
FAMILY
*/
void manage_child(ArrayList<Agent> list_f, ArrayList<Agent> list_m, ArrayList<Agent> list_child) {
  if(list_child.size() > 0) {
    for (Agent child : list_child) {
      if(child instanceof Agent_dynamic) {
        Agent_dynamic c = (Agent_dynamic) child ;
        if(c.maturity <= 0 ) {
          if(c.gender == 0 ) {
            // we don't add 'c' because it's an 'Agent_dynamic' we need to a pure 'Agent'
            list_f.add(child) ;
            break ;
          }
          if(c.gender == 1 ) {
            // we don't add 'c' because it's an 'Agent_dynamic' we need to a pure 'Agent'
            list_m.add(child) ;
            break ;
          }
        }
      }
    }

    // remove child when this one to be added to the adult pool
    for (Agent child : list_child) {
      if(child instanceof Agent_dynamic) {
        Agent_dynamic c = (Agent_dynamic) child ;
        if(c.maturity <= 0 ) {
          list_child.remove(child) ;
          break ;
        }
      }
    }
  }
}