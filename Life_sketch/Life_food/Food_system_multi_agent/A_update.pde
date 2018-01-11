  /**
  UPDATE ECOSYSTEME 0.0.6
  */

  /**
  BIOTOPE
  */
  Vec4 biotope_colour() {
    float normal_humus_level = 1 - HUMUS / HUMUS_MAX ;
    float var_colour_ground = 90 *normal_humus_level ;
    return Vec4(40,90, 5 +var_colour_ground,100) ;
  }
  /**
  End biotope
  */











  /**
  UPDATE AGENT 

  */
  /**
  Flora update 0.0.3
  */
  void flora_update(ArrayList<Flora> list_f, boolean info, int which_costume) {
    flora_update_dead(list_f) ;
    flora_update_growth(list_f) ;
    flora_update_statement(list_f) ;
    flora_update_opacity(list_f) ;
    flora_update_aspect(list_f, info, which_costume) ;
  }
  /**
  Flora update()
  */




  void flora_update_dead(ArrayList<Flora> list_f) {
    for(Flora f : list_f) {
      if(f.life < 0 ) {
        list_f.remove(f) ;
        break ;
      }
    }
  }

  void flora_update_growth(ArrayList<Flora> list_f) {
    for(Flora f : list_f) {
      f.growth() ;
    }
  }

  void flora_update_statement(ArrayList<Flora> list_f) {
    for(Flora f : list_f) {
      f.statement() ;
    }
  }

  void flora_update_opacity(ArrayList<Flora> list_f) {
    for(Flora f : list_f) {
      float ratio = float(f.size) / float(f.size_ref) ;
      float alpha = g.colorModeA *ratio ;
      if(alpha <= 0) alpha = .001 ;
      f.colour_fill.set(f.colour_fill.r, f.colour_fill.g, f.colour_fill.b, alpha) ;
      f.colour_stroke.set(f.colour_stroke.r, f.colour_stroke.g, f.colour_stroke.b, alpha) ;
    }
  }



  void flora_update_aspect(ArrayList<Flora> list_f, boolean info, int which_costume) {
    for(Flora f : list_f) {
      if(original_flora_aspect) {
        f.aspect(f.colour_fill, f.colour_stroke, 1) ; 
      } else {
        f.aspect(fill_colour_flora, stroke_colour_flora, thickness_flora) ;
      }
      if(!info) f.costume_agent(which_costume) ; 
      else f.info_visual_text(f.colour_fill, SIZE_TEXT_INFO) ; 
    }
  }
  /**
  End flora
  */








  /**
  HERBIVORE update 0.1.0
  */
  void herbivore_update(ArrayList<Herbivore> list_h, ArrayList<Flora> list_f, boolean info, int which_costume) {
    herbivore_update_dead(list_h) ;
    herbivore_update_motion(list_h) ;
    herbivore_update_feed(list_h, list_f, info) ;
    herbivore_update_statement(list_h) ;
    herbivore_update_aspect(list_h, info, which_costume) ;
  }
  /**
  local method update
  */

  void herbivore_update_dead(ArrayList<Herbivore> list_h) {
    for(Herbivore h : list_h) {
      if(!h.alive) {
        CORPSE_LIST.add(h) ;
        list_h.remove(h) ;
        break ;
      }
    }
  }

  void herbivore_update_aspect(ArrayList<Herbivore> list_h, boolean info, int which_costume) {
    for(Herbivore h : list_h) {
      if(original_herbivore_aspect) h.aspect(h.colour_fill, h.colour_stroke, 1)  ; else h.aspect(fill_colour_herbivore, stroke_colour_herbivore, thickness_herbivore) ;
      if(!info) h.costume_agent(which_costume) ; 
      else h.info(h.colour_fill, SIZE_TEXT_INFO) ;
    }
  }

  void herbivore_update_statement(ArrayList<Herbivore> list_h) {
    for(Herbivore h : list_h) {
      h.statement() ;
    }
  }

  void herbivore_update_motion(ArrayList<Herbivore> list_h) {
    for(Herbivore h : list_h) {
      h.rebound(LIMIT, REBOUND) ;
      h.motion() ;
      h.set_position() ;
    }

  }
  void herbivore_update_feed(ArrayList<Herbivore> list_h, ArrayList<Flora> list_f, boolean info) {
    for(Herbivore h : list_h) {
      h.set_starving(4) ;
      if(!h.calm) pick_static_agent(h, list_f, info) ;
      eat_flora(h, list_f, info) ;
      h.hunger() ;
    }
  }

  /**
  local method 
  */
  void eat_flora(Herbivore h, ArrayList<Flora> list_flora_target, boolean info) {
    if(h.eating) {
      Flora target ;
      if((int)h.ID_target.x < list_flora_target.size()) {
        target = list_flora_target.get((int)h.ID_target.x) ;
        h.eat(target, info) ;
      }
    } else {
      for(Flora target : list_flora_target) {
        h.eat(target, info) ;
        if(h.eating) {
          if((int)h.ID_target.x < list_flora_target.size()) {
            h.ID_target.set(list_flora_target.indexOf(target),target.ID) ;
            break ;
          }
        }
      }
    } 
  }

  void pick_static_agent(Herbivore h, ArrayList<Flora> list_flora_target, boolean info) {
    for(Flora target : list_flora_target) {
      h.watch(target, info) ;
      h.pick(target) ;
      if(h.picking()) break ;
    }
  }
  /**
  End herbivore update
  */













  /**
  CARNIVORE update 0.1.0
  */
  void carnivore_update(ArrayList<Carnivore> list_carnivore, ArrayList<Herbivore> list_herbivore, ArrayList<Agent_dynamic> list_dead_body, boolean info, int which_costume) {
    carnivore_update_dead(list_carnivore) ;
    carnivore_update_motion(list_carnivore) ;
    carnivore_update_feed(list_carnivore, list_herbivore, list_dead_body, info) ;
    carnivore_update_statement(list_carnivore) ;
    carnivore_update_aspect(list_carnivore, info, which_costume) ;
  }

  /**
  locale methode update
  */
  void carnivore_update_dead(ArrayList<Carnivore> list_c) {
    for(Carnivore c : list_c) {
      if(!c.alive) {
        CORPSE_LIST.add(c) ;
        list_c.remove(c) ;
        break ;
      }
    }
  }

  void carnivore_update_aspect(ArrayList<Carnivore> list_c, boolean info, int which_costume) {
    for(Carnivore c : list_c) {
      if(original_carnivore_aspect) c.aspect(c.colour_fill, c.colour_stroke, 1) ; else c.aspect(fill_colour_carnivore, stroke_colour_carnivore, thickness_carnivore) ;
      if(!info) c.costume_agent(which_costume) ; 
      else c.info(c.colour_fill, SIZE_TEXT_INFO) ;
    }
  }

  void carnivore_update_statement(ArrayList<Carnivore> list_c) {
    for(Carnivore c : list_c) {
      c.statement() ;
    }
  }

  void carnivore_update_motion(ArrayList<Carnivore> list_c) {
    for(Carnivore c : list_c) {
      c.rebound(LIMIT, REBOUND) ;
      c.motion() ;
      c.set_position() ;
    }
  }

  void carnivore_update_feed(ArrayList<Carnivore> list_c, ArrayList<Herbivore> list_h, ArrayList<Agent_dynamic> list_d, boolean info) {
    for(Carnivore c : list_c) {
      c.set_starving(8) ;
      if(!c.calm) hunt_carnivore(c, list_h, info) ;    
      // eat after hunt, if this order is not respect the carnivore prefere hunt to eat and finish to die :)
      if(list_d.size() >= 0 ) eat_meat(c, list_d, info) ; else c.eating = false ;
      c.hunger() ;
    }
  }


  /**
  local method eat
  */
  void eat_meat(Carnivore c, ArrayList<Agent_dynamic> list_agent_target, boolean info) {
    // first eat the agent who eat just before without look in the list
    if(c.eating) {
      int pointer = (int)c.ID_target.x ;
      int ID_target = (int)c.ID_target.y ;
      /* here we point directly in a specific point of the list, 
      if the pointer is superior of the list, 
      because if it's inferior a corpse can be eat by an other Agent */
      if(pointer < list_agent_target.size() ) {
        Agent_dynamic target = list_agent_target.get((int)c.ID_target.x) ;
        /* if the entry point of the list return an agent 
        with a same ID than a ID_target corpse eat just before, 
        the Carnivore can continue the lunch */
        if (target.ID == ID_target ) c.eat(target, info) ; 
        else {
          /* If the ID returned is different, a corpse was leave from the list, 
          and it's necessary to check in the full ist to find if any corpse have a seme ID */
          for(Agent_dynamic target_in_list : list_agent_target) {
            if (target_in_list.ID == ID_target ) c.eat(target_in_list, info) ; else c.eating = false ;
          }
        }
      }
    /* If the last research don't find the corpse, may be this one is return to dust ! */
    } else {
      for(Agent_dynamic target : list_agent_target) {
        c.eat(target, info) ;
        if(c.eating) {
          c.ID_target.set(list_agent_target.indexOf(target),target.ID) ;
          break ;
        }
      }
    }
  }




  /**
  local method hunt
  */

  void hunt_carnivore(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
    // first watch the agent who watch just before without look in the list
    if(c.watching) find_target_carnivore(c, list_herbivore_target, info) ;
    if(c.tracking && c.max_time_track > c.time_track) focus_on_target_carnivore(c, list_herbivore_target, info) ; else c.hunt_stop() ;
  }



  // Local method : The hunt is launching !
  void focus_on_target_carnivore(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
    int pointer = (int)c.ID_target.x ;
    int ID_target = (int)c.ID_target.y ;
    /* here we point directly in a specific point of the list, 
    if the pointer is superior of the list, 
    because if it's inferior a corpse can be watch by an other Agent */
    if(pointer < list_herbivore_target.size() ) {
      Herbivore target = list_herbivore_target.get((int)c.ID_target.x) ;
      /* if the entry point of the list return an agent 
      with a same ID than a ID_target agent watch just before, 
      the Carnivore can continue the track */
      if (target.ID == ID_target ) {
        hunt_and_kill_carnivore(c, target, info) ; 
      } else {
        /* If the ID returned is different, a target was leave from the list, 
        and it's necessary to check in the full ist to find if any agent have a same ID */
        for(Herbivore target_in_list : list_herbivore_target) {
          if (target_in_list.ID == ID_target ) {
            hunt_and_kill_carnivore(c, target_in_list, info) ;
          } else {
            c.hunt_stop() ;
          } 
        }
      }
    } else c.hunt_stop() ;
  }
  // super local method
  void hunt_and_kill_carnivore(Carnivore c, Agent_dynamic target, boolean info) {
    if(c.dist_to_target(target, info) < c.sense_view) {
      c.hunt(target, info) ; 
      c.kill(target, info) ;
    } else c.hunt_stop() ;
  }




  // Local method : Find target is the Big Carnivore Brother is watching you !
  void find_target_carnivore(Carnivore c, ArrayList<Herbivore> list_herbivore_target, boolean info) {
    // float [] dist_list = new float[0] ;
    ArrayList <Vec3> closest_target = new ArrayList<Vec3>() ;
    // find the closest target 
    for(Herbivore target : list_herbivore_target) {
      if(c.dist_to_target(target, info) < c.sense_view) {
        float dist = c.dist_to_target(target, info) ;
        /*catch distance to compare with the last one
        plus catch index in the list and the ID target
        and add in the nice target list
        */
        Vec3 new_target = Vec3(dist, list_herbivore_target.indexOf(target), target.ID) ;
        closest_target.add(new_target) ;
        // compare the target to see which one is the closest.
        if(closest_target.size() > 1) if (closest_target.get(1).x <= closest_target.get(0).x ) closest_target.remove(0) ; else closest_target.remove(1) ;
      } 
    }
    // Start the hunt party with the selected target
    if(closest_target.size() > 0 ) {
      Herbivore target = list_herbivore_target.get((int)closest_target.get(0).y) ;
      c.hunt(target, info) ;
      c.kill(target, info) ;
      if(c.tracking) c.ID_target.set(list_herbivore_target.indexOf(target),target.ID) ;
    }
  }
  /**
  End carnivore update
  */











  /**
  Bacterium update 0.1.0
  */
  void bacterium_update(ArrayList<Bacterium> list_bacterium, ArrayList<Agent_dynamic> list_dead_body, boolean info, int which_costume) {
    bacterium_dead_update(list_bacterium) ;
    bacterium_motion_update(list_bacterium) ;
    bacterium_aspect_update(list_bacterium, info, which_costume) ;
    bacterium_statement_update(list_bacterium) ;
    bacterium_feed_update(list_bacterium, list_dead_body, info) ;
  }

  /**
  Bacterium update
  */

  void bacterium_dead_update(ArrayList<Bacterium> list_b) {
    for(Bacterium b : list_b) {
      if(b.size < 0 ) {
        list_b.remove(b) ;
        break ;
      }
    }
  }

  void bacterium_motion_update(ArrayList<Bacterium> list_b) {
    for(Bacterium b : list_b) {
      b.rebound(LIMIT, REBOUND) ;
      b.motion() ;
      b.set_position() ;
    }
  }

  void bacterium_aspect_update(ArrayList<Bacterium> list_b, boolean info, int which_costume) {
    for(Bacterium b : list_b) {
      if(original_bacterium_aspect) b.aspect(b.colour_fill, b.colour_stroke, 1) ; else b.aspect(fill_colour_bacterium, stroke_colour_bacterium, thickness_bacterium) ;
      if(!info) b.costume_agent(which_costume) ; 
      else b.info(b.colour_fill, SIZE_TEXT_INFO) ;
    }
  }


  void bacterium_statement_update(ArrayList<Bacterium> list_b) {
    for(Bacterium b : list_b) {
      b.statement() ;
    }
  }

  void bacterium_feed_update(ArrayList<Bacterium> list_b, ArrayList<Agent_dynamic> list_dead_body, boolean info) {
    for(Bacterium b : list_b) {
      b.set_starving(2) ;
      if(!b.calm) hunt_static_agent(b, list_dead_body, info) ;
      if(list_dead_body.size() >= 0 ) eat_corpse(b, list_dead_body, info) ; else b.eating = false ;
      b.hunger() ;
    }
  }


  /**
  local method
  */
  void eat_corpse(Bacterium b, ArrayList<Agent_dynamic> list_corpse_target, boolean info) {
  // first eat the agent who eat just before without look in the list
    if(b.eating) {
      int pointer = (int)b.ID_target.x ;
      int ID_target = (int)b.ID_target.y ;
      /* here we point directly in a specific point of the list, 
      if the pointer is superior of the list, 
      because if it's inferior a corpse can be eat by an other Agent */
      if(pointer < list_corpse_target.size() ) {
        Agent_dynamic target = list_corpse_target.get((int)b.ID_target.x) ;
        /* if the entry point of the list return an agent 
        with a same ID than a ID_target corpse eat just before, 
        the Carnivore can continue the lunch */
        if (target.ID == ID_target ) b.eat(target, info) ; 
        else {
          /* If the ID returned is different, a corpse was leave from the list, 
          and it's necessary to check in the full ist to find if any corpse have a seme ID */
          for(Agent_dynamic target_in_list : list_corpse_target) {
            if (target_in_list.ID == ID_target ) b.eat(target_in_list, info) ; else b.eating = false ;
          }
        }
      }
    /* If the last research don't find the corpse, may be this one is return to dust ! */
    } else {
      for(Agent_dynamic target : list_corpse_target) {
        b.eat(target, info) ;
        if(b.eating) {
          b.ID_target.set(list_corpse_target.indexOf(target),target.ID) ;
          break ;
        }
      }
    }
  }


  void hunt_static_agent(Bacterium b, ArrayList<Agent_dynamic> list_target, boolean info) {
    for(Agent_dynamic target : list_target) {
      b.watch(target, info) ;
      b.pick(target) ;
      if(b.picking()) break ;
    }
  }
  /**
  End bacterium
  */













  /**
  CORPSE || DEAD BODY update 0.0.3
  */
  void corpse_update(ArrayList<Agent_dynamic> list_dead_body, boolean info, int which_costume) {
    corpse_dead_update(list_dead_body) ;
    corpse_aspect_update(list_dead_body, info, which_costume) ;
  }
  /**
  update dead body / corpse
  */
  void corpse_dead_update(ArrayList<Agent_dynamic> list_d) {
    for(Agent_dynamic corpse : list_d) {
      if(corpse.size < 0) {
        list_d.remove(corpse) ;
        break ;
      }
    }
  }


  void corpse_aspect_update(ArrayList<Agent_dynamic> list_d, boolean info, int which_costume) {
    for(Agent_dynamic corpse : list_d) {
      // set colour
      Vec4 colour_of_death = Vec4(0,0,30,g.colorModeA); 
      corpse.set_fill(colour_of_death) ;
      corpse.set_stroke(colour_of_death) ;
      corpse.carrion() ;
      // aspect
      if(original_corpse_aspect) corpse.aspect(corpse.colour_fill, corpse.colour_stroke, 1) ; else corpse.aspect(fill_colour_corpse, stroke_colour_corpse, thickness_corpse) ;
      if(!info) corpse.costume_agent(which_costume) ; 
      else {
        corpse.info_visual(corpse.colour_fill) ;
        corpse.info_text(corpse.colour_fill, SIZE_TEXT_INFO) ;
      }
    }
  }

  /**
  END CORPSE || DEAD BODY update
  */









   /**
   SCALE 0.0.1
   */
  void scale_flora(ArrayList<Flora> list_f, float scale) {
    for(Flora f : list_f) {
      f.size = f.size_ref ;
      f.size *= scale ;
    }
  }
  void scale_herbivore(ArrayList<Herbivore> list_h, float scale) {
    for(Herbivore h : list_h) {
      h.size = h.size_ref ;
      h.size *= scale ;
    }
  }
  void scale_carnivore(ArrayList<Carnivore> list_c, float scale) {
    for(Carnivore c : list_c) {
      c.size = c.size_ref ;
      c.size *= scale ;
    }
  }
  void scale_bacterium(ArrayList<Bacterium> list_b, float scale) {
    for(Bacterium b : list_b) {
      b.size = b.size_ref ;
      b.size *= scale ;
    }
  }

  void scale_corpse(ArrayList<Agent_dynamic> list_body, float scale) {
    for(Agent_dynamic body : list_body) {
      body.size = body.size_ref ;
      body.size *= scale ;
    }
  }














  /**
  SET – UPDATE – ASPECT AGEBT

  */
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
   set colour herbivore
   */
  boolean original_herbivore_aspect = true ;
  Vec4 fill_colour_herbivore, stroke_colour_herbivore ;
  float thickness_herbivore ; 
  void set_aspect_herbivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
    original_herbivore_aspect = false ;
    if(fill_colour_herbivore == null) fill_colour_herbivore = Vec4(fill_colour) ; else fill_colour_herbivore.set(fill_colour) ;
    if(stroke_colour_herbivore == null) stroke_colour_herbivore = Vec4(stroke_colour) ; else stroke_colour_herbivore.set(stroke_colour) ;
    thickness_herbivore = thickness ;
  }
  /**
  set colour carnivor
  */
  boolean original_carnivore_aspect = true ;
  Vec4 fill_colour_carnivore, stroke_colour_carnivore ;
  float thickness_carnivore ; 
  void set_aspect_carnivore(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
    original_carnivore_aspect = false ;
    if(fill_colour_carnivore == null) fill_colour_carnivore = Vec4(fill_colour) ; else fill_colour_carnivore.set(fill_colour) ;
    if(stroke_colour_carnivore == null) stroke_colour_carnivore = Vec4(stroke_colour) ; else stroke_colour_carnivore.set(stroke_colour) ;
    thickness_carnivore = thickness ;
  }

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

  /**
  set colour bacterium
  */
  boolean original_bacterium_aspect = true ;
  Vec4 fill_colour_bacterium, stroke_colour_bacterium ;
  float thickness_bacterium ; 
  void set_aspect_bacterium(Vec4 fill_colour, Vec4 stroke_colour, float thickness) {
    original_bacterium_aspect = false ;
    if(fill_colour_bacterium == null) fill_colour_bacterium = Vec4(fill_colour) ; else fill_colour_bacterium.set(fill_colour) ;
    if(stroke_colour_bacterium == null) stroke_colour_bacterium = Vec4(stroke_colour) ; else stroke_colour_bacterium.set(stroke_colour) ;
    thickness_bacterium = thickness ;
  }
  /**
  End set aspect
  */

  /**
  END UPDATE ECOSYSTEME
  */