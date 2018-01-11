   /**
   SUB CLASS FLORA 0.1.0
   */

   class Flora extends Agent_static {
   	int speed_growth = 1 ;
   	int life, life_max ;

   	int nutrient_quality = 1  ;
   	float need = 1. ;

   	Flora(Vec3 pos, int size, String name) {
         super(pos, size, name) ;
         this.life = this.life_max = size ;
      }
      /**
      Set Flora
      */
      void set_Flora_quality(int nutrient_quality) {
      	this.nutrient_quality =  nutrient_quality ;
      }

      void set_growth(int speed) {
      	this.speed_growth = speed ;
      }

      void set_need(float need) {
      	this.need = need ;
      }


      // Statement
      void statement() {
        if(size > size_max) size = size_max ;
        if(life > life_max) life = life_max ;
      }

      // update
      void growth() {
      	if(frameCount%(180 *CLOCK) == 0 ) {
      		this.size += speed_growth ;
      		this.life += speed_growth ;
      		HUMUS -= need ;
      	} 
      }

      // print
      /**
      // info
      */
      void info_visual_text(Vec4 colour, int size_text) {
         aspect(colour,colour, 1) ;
         textSize(size_text) ;
         textAlign(CENTER) ;
         
         Vec2 pos_text = Vec2(0) ;

         matrix_start() ;
         translate(pos) ;
         text(name, pos_text.x, pos_text.y) ;
         text(life, pos_text.x, pos_text.y +(size_text *1.2) ) ;
         matrix_end() ;
      }
      
      void info_print_flora() {
      	println("INFO",this.name) ;
         println("No particular info for the moment") ;
      }
   }
   /**
   END SUB CLASS FLORA
   */