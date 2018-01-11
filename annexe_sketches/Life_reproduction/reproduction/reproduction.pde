/**
REPRODUCTION-SYSTEM 0.0.2

June 2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Digital-Life-Processing/tree/master/REPRODUCTION_SYSTEM

*/
ArrayList<Creature> list_female = new ArrayList<Creature>() ;
ArrayList<Creature> list_male = new ArrayList<Creature>() ;
ArrayList<Creature> list_child = new ArrayList<Creature>() ;
boolean RUT_CREATURE ;
int TOTAL_CREATURES ;
//int SPEED_REPRODUCTION = 2 ;



void setup() {
  size(1200,800) ;
  // fullScreen() ;
  colorMode(HSB,360,100,100,100) ;
  load_nucleotide_table("code.csv") ;

  int num = 50 ;
  int gender = 0 ;
  for(int i = 0 ; i < num ; i++) {
    int size = (int)random(10,50) ;
    int life_expectancy_in_sec = (int)random(1500,1800) ;
    if(gender > 1) gender = 0 ;
    Creature c = new Creature(size,life_expectancy_in_sec, gender) ;
    gender++ ;
    c.set_pos(Vec2(random(width),random(height))) ;
    c.set_dir(Vec2("RANDOM",1)) ;
    c.set_velocity(random(5)) ;
    TOTAL_CREATURES++ ;
    c.set_ID(int(random(INT_MAX))) ;
    list_child.add(c) ;
    /*
    if(c.gender == 0 ) list_female.add(c) ;
    if(c.gender == 1 ) list_male.add(c) ;
    */
   // c.set_speed_reproduction(SPEED_REPRODUCTION) ;
  }
}

void draw() {
  background(0) ;

  // creature
  // display
  display_creature(list_female) ;
  display_creature(list_male) ;
  display_creature(list_child) ;

  motion_creature(list_female) ;
  motion_creature(list_male) ;
  motion_creature(list_child) ;
 

  // reproduction
  reproduction_female(list_female, list_male, list_child) ;
  // println(RUT_CREATURE) ;
  // if(RUT_CREATURE)reproduction_male(list_female, list_male) ;
  reproduction_male(list_female, list_male) ;

  //life
  update_growth(list_female) ;
  update_growth(list_male) ;
  update_growth(list_child) ;
  
  

  // manage child to be adult
  manage_child(list_female, list_male, list_child) ;

  // info
  if(mousePressed) {
    info_population_female(list_female, false);
    info_population_male(list_male, false);
    info_population_child(list_child, false);
    info_population() ;
    println("Frame rate", frameRate) ;
  }
}


// methode
void update_growth(ArrayList<Creature> list) {
  for (Creature c : list) {
    c.growth() ;
  }
  // death
  for (Creature c : list) {
    if(c.life < 0 ) {
      list.remove(c) ;
      break ;
    }
  }
}


void motion_creature(ArrayList<Creature> list) {
  for (Creature c : list) {
    Vec2 dir_ref = Vec2(c.dir) ;
    c.pos.add(dir_ref.mult(c.velocity));
    if(c.pos.x > width || c.pos.x < 0) c.dir.x *= -1 ;
    if(c.pos.y > height || c.pos.y < 0) c.dir.y *= -1 ;
  }
}

void display_creature(ArrayList<Creature> list) {
  for (Creature c : list) {
    // to see the death
    float alpha  = g.colorModeA ;
    if(c.life *.1 < g.colorModeA ) alpha = c.life *.1 ;
    fill(0,0,100,alpha) ;
    stroke(0,0,100,alpha) ;
    noStroke() ;
    //strokeWeight(3) ;
    if(c.puberty <= 0) {
      if(c.gender == 0) {
        if(c.fertility) {
          fill(120,100,100,alpha) ;
        }
        if(c.pregnant) {
          fill(50,100,100,alpha) ;
        }
        costume(c.pos, c.size, TRIANGLE_RPE) ; 
      } else if (c.gender == 1) {
        costume(c.pos, c.size, SQUARE_RPE) ;
      }
    } else {
      //costume(c.pos, c.size, POINT_RPE) ;
      costume(c.pos, c.size, ELLIPSE_RPE) ;
    }
  }
}




/**
REPRODUCTION
All method for the reproduction
*/






/**
Add chid
@return add child to the adult list male or female, and remove this one from the child list
*/
void manage_child(ArrayList<Creature> list_f, ArrayList<Creature> list_m, ArrayList<Creature> list_c) {
  if(list_c.size() > 0) {
    for (Creature child : list_c) {
      if(child.puberty <= 0 ) {
        if(child.gender == 0 ) {
          list_f.add(child) ;
          break ;
        }
        if(child.gender == 1 ) {
          list_m.add(child) ;
          break ;
        }
      }
    }

    // remove child when this one to be added to the adult pool
    for (Creature child : list_c) {
      if(child.puberty <= 0 ) {
        list_c.remove(child) ;
        break ;
      }
    }
  }
}







/**
Male Reproduction
*/
void reproduction_male(ArrayList<Creature> list_f, ArrayList<Creature> list_m) {
  for (Creature f : list_f) {
    if(f.fertility && check_female_reproducer(f, list_m)) ;
  }
}

boolean check_female_reproducer(Creature female, ArrayList<Creature> list_target) {
  boolean result = false ;
  if(list_target.size() > 0) {
    for (Creature male : list_target) {
      if(dist(female.pos, male.pos) < male.reproduction_area) {
        male.dir.set(target_direction(female.pos, male.pos)) ;
        result = true ; 
      } else result = false ;
    }
  } else result = false ;
  return result ;
}








/**
Female Reproduction
*/
int count_female_fertile ;
void reproduction_female(ArrayList<Creature> list_f, ArrayList<Creature> list_m, ArrayList<Creature> list_c) {
  count_female_fertile = 0 ;
  for (Creature f : list_f) {
    f.fertility(frameCount) ;
    if(f.fertility) {
      count_female_fertile++ ;
      if (check_male_reproducer(f, list_m)) {
        f.reproduction() ;
      }
    } 
    f.pregnant() ;

    if(f.birth()) {
      int size = (int)random(f.size -3, f.size +3) ;
      // int gender = floor(random(2)) ;
      Creature n = new Creature(f.genome, f.genome_father) ;
      f.genome_father = null ;
      n.set_pos(f.pos) ;
      n.dir = Vec2("RANDOM",1) ;
      float new_velocity = f.velocity +random(-1,1) ;
      if(new_velocity < .1) new_velocity = .1 ;
      n.set_velocity(new_velocity) ;
      TOTAL_CREATURES++ ;
      n.set_ID((int)random(INT_MAX)) ;
  //    n.set_speed_reproduction(SPEED_REPRODUCTION) ;
      list_c.add(n) ;
    }
  }
  if(count_female_fertile > 0) RUT_CREATURE = true ; else RUT_CREATURE = false ;
}

boolean check_male_reproducer(Creature female, ArrayList<Creature> list_target) {
  boolean result = false ;
  if(list_target.size() > 0) {
    for (Creature male : list_target) {
      if(dist(female.pos, male.pos) < female.reproduction_area) {
        result = true ;
        // must be create method copy but smell very complexe thing to do
        female.genome_father = male.genome ;
        break ; 
      } else result = false ;
    }
  } else result = false ;
  return result ;
}









/**
info
*/
void info_population_female(ArrayList<Creature> list_female, boolean info_plus) {
  // info plus
  if(info_plus) {
    for (Creature f : list_female) {
      println("female", f.genome.get_gene("1")) ;
      println("pregnant", f.pregnant) ;
      println("pregnant time", f.pregnant_time) ;
    }
  }
  // count
  println("female ", list_female.size()) ;
}

void info_population_male(ArrayList<Creature> list_male, boolean info_plus) {
  // info plus
  if(info_plus) {
    for (Creature m : list_male) {
      println("male", m.genome.get_gene("1")) ;
    }
  }
  // count
  println("male ", list_male.size()) ;
}

void info_population_child(ArrayList<Creature> list_child, boolean info_plus) {
  // info plus
  if(info_plus) {
    for (Creature c : list_child) {
      // nothing 
    }
  }
  // count
  println("child", list_child.size()) ;
}

void info_population() {
  println("population",list_child.size() + list_female.size() + list_male.size(), " / "  ,TOTAL_CREATURES) ;
}