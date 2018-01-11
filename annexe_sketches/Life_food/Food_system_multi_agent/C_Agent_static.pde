  /**
  Agent Static 0.0.2
  */
  class Agent_static implements RULES_ECOSYSTEME {
    String name ;
    int ID = 0 ;

    Vec3 pos ;
    int size, size_ref, size_max ;

    Vec4 colour_fill = new Vec4(0,0,0,g.colorModeA) ;
    Vec4 colour_stroke = new Vec4(0,0,0,g.colorModeA) ;
    float thickness = 1 ;

    /**
    Constructor
    */
    Agent_static(Vec3 pos, int size, String name) {
      this.name = name ;
      this.ID = int(random(1000000)) ;
      this.size = this.size_ref = this.size_max  = size ;
      this.pos = pos ;
    }
    
    /**
    Set Agent Static
    */
    void set_aspect(Vec4 colour_fill, Vec4 colour_stroke, float thickness) {
      this.colour_fill.set(colour_fill) ;
      this.colour_stroke.set(colour_stroke) ;
      this.thickness = thickness ;
    }
    void set_fill(Vec4 colour_fill) {
      this.colour_fill.set(colour_fill) ;
    }

    void set_stroke(Vec4 colour_stroke) {
      this.colour_stroke.set(colour_stroke) ;
    }

    void set_thickness(float thivkness) {
      this.thickness = thickness ;
    }

    /**
    Set misc
    */
    void set_size(int size) {
      this.size = size ;
    }




    /**
    Aspect
    */
    void aspect(float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(colour_fill) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(colour_stroke) ;
        fill(colour_fill) ;
      }
    }
    
    void aspect(Vec4 c_fill, Vec4 c_stroke, float thickness) {
      if(thickness <= 0) { 
        noStroke() ;
        fill(c_fill) ;
      } else { 
        strokeWeight(thickness) ;
        stroke(c_stroke) ;
        fill(c_fill) ;
      }
    }


    /**
    // costume
    */
    void costume_agent(int ID_costume) {
      costume(pos, size, ID_costume) ;
    }
  }
  /**
  END Agent Static
  */
