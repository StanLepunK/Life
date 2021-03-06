/**
DECORUM

*/





void set_host() {
  vec3 size = vec3(int(height *1.5)) ;
  vec3 canvas = vec3(abs(HORIZON) / 8, height *1.5, abs(HORIZON) / 8) ;
  vec3 radius = canvas.copy() ;
  vec3 pos = vec3(width / 2, height/2, -radius.x) ;
  int num = 100 ;
  create_host(num, pos, size, canvas, radius) ; 
}


void show_host(boolean info_agent) {
  show_host(speed_host, direction_host, ELLIPSE, motion_bool_host, info_agent) ;
}




/**
HOST 0.1.1

*/
/**
CREATE
*/
void create_host(int num, vec3 pos, vec3 size, vec3 canvas, vec3 radius) {
  // host
  pos_host(pos) ;
  size_host(size) ;
  canvas_host(canvas) ;
  radius_host(radius) ;

  int height_dna = (int)canvas.y ;
  int radius_dna = (int)radius.x ;
  int num_nucleotide = num ;
  int num_helix = 2 ; 

  init_host_target(num *num_helix) ;
  create_dna(num_helix, num_nucleotide, pos, size, height_dna, radius_dna) ;
}


void init_symbiosis() {
  init_symbiosis_area(strand_DNA.num()) ;
  set_symbiosis_area(strand_DNA.get_nuc_pos()) ;
}


/**
UPDATE SYMBIOSIS
*/
void update_symbiosis() {
  update_symbiosis_area(strand_DNA.get_nuc_pos()) ;
}


void sync_symbiosis() {
  sync_symbiosis(FLORA_LIST) ;
}











/**
DNA
*/
// DNA host
vec3 color_strand_a = vec3(30, 10, 80) ;
vec3 color_strand_b = vec3(0, 10, 20) ;

Helix strand_DNA ;



void create_dna(int num_helix, int num, vec3 pos, vec3 size, int height_dna, int radius_dna) {
  int revolution = 60 ;
  int nucleotide = num ;

  int num_strand = num_helix ;



  strand_DNA = new Helix(num_strand, nucleotide, revolution) ;
  strand_DNA.set_radius(radius_dna) ;
  strand_DNA.set_height(height_dna) ;
  strand_DNA.set_final_pos(pos) ;
}


/**
SHOW
*/

void show_host(float speed_rotation_host, int direction_host, int which_costume, boolean motion_bool_host, boolean info) {
  
  int height_dna = (int)get_canvas_host().y ;
  int radius_dna = (int)get_radius_host().x ;
  vec3 pos = get_pos_host().copy() ;
  show_dna(pos, height_dna, radius_dna, speed_rotation_host, direction_host, which_costume, motion_bool_host, info) ;
}



float rotation_dna = 0 ;
void show_dna(vec3 pos, int height_dna, int radius_dna, float speed_host, int direction_host, int which_costume, boolean rotation_bool_dna, boolean info) {
  // show DNA
  if(height_dna > 0 ) {
    if(rotation_bool_dna) {
      rotation_dna += abs(speed_host) *direction_host ;
      strand_DNA.rotation(rotation_dna) ;
      strand_DNA.set_radius(radius_dna) ;
      strand_DNA.set_height(height_dna) ;
      strand_DNA.set_final_pos(pos) ;
    }  

    for(int i = 0 ; i < strand_DNA.length() ; i++) {
      costume_DNA(strand_DNA, i, pos, which_costume, info) ;
    }
  }
}



void costume_DNA(Helix strand, int target, vec3 pos, int which_costume, boolean info) {
  /**
  printTempo(60, "costume_DNA(Helix_DNA strand, int target, vec3 pos, int which_costume, boolean info)") ;
  if(frameCount%60== 0 ) {
    printArray(strand.get_nuc_pos()) ;
  }
  */
  vec3 pos_a = strand.get_nuc_pos(0)[target] ;
  vec3 pos_b = strand.get_nuc_pos(1)[target] ;

  int size = 36 ;
  int size_link = 1 ;

  float radius = strand.get_radius().x ;
  float alpha_min = .01 ;
  float alpha_max = .8 ;

  stroke(80, 8) ;
  strokeWeight(size_link) ;
  line(pos_a, pos_b) ;

  float ratio_a = map(pos_a.z -pos.z , -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_a = g.colorModeA * ratio_a ;
  

  float ratio_b = map(pos_b.z -pos.z, -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_b = g.colorModeA *ratio_b ;


  if(info) {
    fill(color_strand_a, alpha_a) ;
    String nuc_a = "" +strand.get_DNA(0).sequence_a.get(target).nac ;
    costume(pos_a,size,nuc_a) ;
    fill(color_strand_b, alpha_b) ;
    String nuc_b = "" +strand.get_DNA(0).sequence_a.get(target).nac ;
    costume(pos_b,size,nuc_b) ;
  } else {
    noFill() ;
    stroke(color_strand_a, alpha_a) ;
    costume(pos_a,size,which_costume) ;
    noFill() ;
    stroke(color_strand_b, alpha_b) ;
    costume(pos_b,size,which_costume) ;
  }
}


