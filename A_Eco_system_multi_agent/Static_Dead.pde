/**
METHOD DEAD BODY





*/

/**
set colour corspe
*/
boolean original_corpse_aspect = true ;
Vec4 fill_colour_corpse, stroke_colour_corpse ;
float thickness_corpse ; 
void set_aspect_corpse(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_corpse_aspect = false ;
  if(fill_colour_corpse == null) fill_colour_corpse = Vec4(fill_colour) ; else fill_colour_corpse.set(fill_colour) ;
  if(stroke_colour_corpse == null) stroke_colour_corpse = Vec4(stroke_colour) ; else stroke_colour_corpse.set(stroke_colour) ;
  thickness_corpse = thickness ;
}





void build_dead(ArrayList<Agent> list, Info_dict carac, Info_obj style, int num) {
  for(int i = 0 ; i < num ; i++) {
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_dead(list, pos, carac, style) ;
    } else {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_dead(list, pos, carac, style) ;
    }
  }
}



void add_dead(ArrayList<Agent> list, Vec pos, Info_dict carac, Info_obj style) {
  int gender = (int)round(random(1));
  Agent dead = new Dead(carac, style, gender) ;
  set_dead(dead, pos, carac, style) ;
  DEAD_LIST.add(dead) ;

}


void set_dead(Agent d, Vec pos, Info_dict carac, Info_obj style) {

  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_obj(0) ;

  d.set_costume((int)style.catch_obj(0)) ;
  d.set_fill((Vec4)style.catch_obj(1)) ;
  d.set_stroke((Vec4)style.catch_obj(2)) ;
  d.set_thickness((float)style.catch_obj(3)) ;
  d.set_pos(pos) ;
  d.set_nutrient_quality(nutrient_quality) ;
   /*
  if(a instanceof Agent_static) {
    Agent_static a_s = (Agent_static) a ;
    a_s.set_pos(pos) ;
    a_s.set_nutrient_quality(nutrient_quality) ;
    a_s.set_fill(colour) ;
    a_s.set_stroke(colour) ;
  }
  */
}






/**
scale
*/
/*
void scale_corpse(ArrayList<Agent_dynamic> list_body, float scale) {
  for(Agent_dynamic body : list_body) {
    body.size = body.size_ref ;
    body.size *= scale ;
  }
}
*/





/**
CORPSE || DEAD BODY update 0.1.0
*/
void dead_update(ArrayList<Agent> list) {
  dead_remove(list) ;
  carrion_update(list) ;
  if(LOG_ECOSYSTEM) update_log(list, FRAME_RATE_LOG) ;
}

void show_dead(Info_obj style, ArrayList<Agent> list_dead) {
  if(INFO_DISPLAY_AGENT) {
    info_agent(list_dead) ;
  } else {
    // dead_aspect(list_dead) ;
    update_aspect(style, list_dead) ;
  }
}







/**
update dead body / corpse
*/
void dead_remove(ArrayList<Agent> list) {
  for(Agent dead : list) {
    if(dead.get_size() <= 0) {
      list.remove(dead) ;
      break ;
    }
  }
}





void carrion_update(ArrayList<Agent> list) {
  for(Agent dead : list) {
    if(dead instanceof Agent_static) {
      Agent_static corpse = (Agent_static) dead ;
      corpse.carrion() ;
    }
  }
}

/**
END CORPSE || DEAD BODY update
*/



























/**
sub class dead 0.1.0




*/
class Dead extends Agent_static {



   /**

   MUST BE IMPROVE

   */
	Dead(Vec3 pos, int size, int size_ref, int nutrient_quality, String name) {
      super(pos, size, name + " dead") ;

		this.nutrient_quality = nutrient_quality ;
		this.size_ref = size_ref ;
		this.alive = false ;
		Vec4 colour_of_death = Vec4(0,0,30,g.colorModeA);
		colour_fill.set(colour_of_death) ;
		colour_stroke.set(colour_of_death) ;

	}

   Dead(Info_dict carac, Info_obj style, int gender) {
      super(carac, style, gender) ;
      this.alive = false ;
   }

	/**
   // info
   */
   void info_visual(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(), colour_info(colour), 1) ;
      start_matrix() ;
      translate(pos) ;

      strokeWeight(2) ;
      point(pos_temp) ;
 
      stop_matrix() ;
   }
   
   
   void info_print_dead() {
   	println("INFO",this.name) ;
      println("No particular info for the moment") ;
   }
}