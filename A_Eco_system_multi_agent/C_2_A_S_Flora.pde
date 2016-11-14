/**
METHOD FLORA






*/





/**
FLORA
*/
/**
* build the plant of the ecosystem
*/
void build_flora(ArrayList<Agent> list_f, Info_dict carac, Vec4 colour, int num) {
  for(int i = 0 ; i < num ; i++) {
    if(ENVIRONMENT == 2 ) {
      Vec2 pos = Vec2("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d) ;
      add_flora(list_f, pos, carac, colour) ;
    } else if (ENVIRONMENT == 3 ) {
      Vec3 pos = Vec3("RANDOM RANGE",(int)LIMIT.a, (int)LIMIT.b, (int)LIMIT.c, (int)LIMIT.d, (int)LIMIT.e, (int)LIMIT.f) ;
      add_flora(list_f, pos, carac, colour) ;
    }
  }
}

void add_flora(ArrayList<Agent> list_f, Vec2 pos, Info_dict carac, Vec4 colour) {
   Vec3 final_pos =  Vec3(pos.x,pos.y,0) ;
   add_flora(list_f, final_pos, carac, colour) ;
}
void add_flora(ArrayList<Agent> list_f, Vec3 pos, Info_dict carac, Vec4 colour) {
    // recover data
  String name = (String) carac.get("name")[0].catch_a() ;
  int size_template = (int) carac.get("size")[0].catch_a() ;
  int size = int(random(ceil(size_template *.5), ceil(size_template*3))) ;
  int nutrient_quality = (int) carac.get("nutrient_quality")[0].catch_a() ;
  int speed_growth = (int) carac.get("speed_growth")[0].catch_a() ;
  float need = (Float) carac.get("need")[0].catch_a() ;

  Flora f = new Flora(pos, size, name) ;
   list_f.add(f) ;
   f.set_nutrient_quality(nutrient_quality) ;
   //f.set_pos(pos) ;
   f.set_fill(colour) ;
   f.set_stroke(colour) ;
   f.set_growth(speed_growth) ;
   f.set_need(need) ;
}


/**
 set aspect flora
 */
boolean original_flora_aspect = true ;
Vec4 fill_colour_flora, stroke_colour_flora ;
float thickness_flora ; 
void set_aspect_flora(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
  original_flora_aspect = false ;
  if(fill_colour_flora == null) fill_colour_flora = Vec4(fill_colour) ; else fill_colour_flora.set(fill_colour) ;
  if(stroke_colour_flora == null) stroke_colour_flora = Vec4(stroke_colour) ; else stroke_colour_flora.set(stroke_colour) ;
  thickness_flora = thickness ;
}
/**
 SCALE 0.0.1
 */
 /*
void scale_flora(ArrayList<Flora> list_f, float scale) {
  for(Flora f : list_f) {
    f.size = f.size_ref ;
    f.size *= scale ;
  }
}
*/

/**
Flora update 0.0.3
*/
void flora_update(ArrayList<Agent> list_f, Biomass b) {
  flora_update_kill(list_f) ;
  flora_update_growth(list_f) ;
  flora_update_feed(list_f, b) ;
  flora_update_statement(list_f) ;
  flora_update_opacity(list_f) ;
}

void flora_show(ArrayList<Agent> list_f, boolean info) {
  if(!info) flora_update_aspect(list_f) ;
  if(info) info_agent(list_f) ;
}
/**
Flora update()
*/




void flora_update_kill(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      if(f.stamina < 0 ) {
        list_f.remove(f) ;
        break ;
      }
    }
  }
}

void flora_update_feed(ArrayList<Agent> list_f, Biomass b) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      f.feeding(b) ;
    }
  }
}

void flora_update_growth(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      f.growth() ;
    }
  }
}

void flora_update_statement(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      f.statement() ;
    }
  }
}

void flora_update_opacity(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      float ratio = float(f.size) / float(f.size_ref) ;
      float alpha = g.colorModeA *ratio ;
      if(alpha <= 0) alpha = .001 ;
      f.colour_fill.set(f.colour_fill.r, f.colour_fill.g, f.colour_fill.b, alpha) ;
      f.colour_stroke.set(f.colour_stroke.r, f.colour_stroke.g, f.colour_stroke.b, alpha) ;
    }
  }
}



void flora_update_aspect(ArrayList<Agent> list_f) {
  for(Agent a : list_f) {
    if(a instanceof Flora) {
      Flora f = (Flora) a ;
      if(original_flora_aspect) {
        f.aspect(f.colour_fill, f.colour_stroke, 1) ; 
      } else {
        f.aspect(fill_colour_flora, stroke_colour_flora, thickness_flora) ;
      }
      f.costume() ; 
    }
  }
}
/**
End flora
*/
































/**
SUB CLASS FLORA 0.2.0
*/

class Flora extends Agent_static {

   Flora(Vec3 pos, int size, String name) {
      super(pos, size, name) ;
      this.stamina = this.stamina_ref = size ;
   }
   /**
   Set Flora
   */
   void set_growth(int speed) {
   	this.speed_growth = speed ;
   }

   void set_need(float need) {
   	this.need = need ;
   }


   // Statement
   void statement() {
     // if(size > size_max) size = size_max ;
     if(size > size_ref) size = size_ref ;
     if(stamina > stamina_ref) stamina = stamina_ref ;
   }


   void feeding(Biomass biomass) {
      if(biomass.humus > 0) {
         if(frameCount%(180 *CLOCK) == 0 ) {
            this.size += speed_growth ;
            this.stamina += speed_growth ;
            biomass.humus_update(-need) ;
         }
      }
   }





   /**
   // info
   */
   void info_visual(Vec4 colour) {
      Vec3 pos_temp = Vec3(0) ;
      aspect(Vec4(), colour_info(colour), 1) ;
      start_matrix() ;
      translate(pos) ;
      // info feed
      strokeWeight(2) ;
      point(pos_temp) ;
      // info reproduction
      stop_matrix() ;
   }
   
   void info_print_flora() {
   	println("INFO",this.name) ;
      println("No particular info for the moment") ;
   }
}
/**
END SUB CLASS FLORA
*/