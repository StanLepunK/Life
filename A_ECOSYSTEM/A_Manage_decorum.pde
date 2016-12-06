/**
DECORUM

*/
Vec4 color_flora = Vec4(0, 100, 80, 100) ;
Vec4 color_herbivore = Vec4(110, 100, 70, 100) ;

Vec3 color_strand_a = Vec3(30, 10, 80) ;
Vec3 color_strand_b = Vec3(0, 10, 20) ;








boolean new_costume_virus = false ;
void set_virus_costume() {
  Vec4 fill_flora = Vec4(color_flora) ;
  Vec4 stroke_flora = Vec4(color_flora) ;
  float change_hue = random(50) ;
  float change_alpha = random(100) ;
  fill_flora.x += change_hue ;
  stroke_flora.x += change_hue ;
  fill_flora.a -= change_alpha ;
  stroke_flora.a -= change_alpha ;


  int costume = VIRUS_3_4_64_ROPE ;
  int new_costume = floor(random(8)) ;
  if(new_costume == 0 ) {
    costume = VIRUS_3_4_32_ROPE ;
  } else if(new_costume == 1 ) {
    costume = VIRUS_3_4_64_ROPE ;
  } else if(new_costume == 2 ) {
    costume = VIRUS_3_4_128_ROPE ;
  } else if(new_costume == 3 ) {
    costume = VIRUS_2_2_16_ROPE ;
  } else if(new_costume == 4 ) {
    costume = VIRUS_3_8_16_ROPE ;
  } else if(new_costume == 5 ) {
    costume = VIRUS_2_2_32_ROPE ;
  } else if(new_costume == 6 ) {
    costume = VIRUS_3_8_64_ROPE ;
  } else if(new_costume == 7 ) {
    costume = VIRUS_3_8_16_ROPE ;
  }




  float thickness = 1. ;


  Vec3 alpha_behavior_flora = Vec3(pos_final_dna.z, -.4, .8) ;
  style_flora = new Info_obj("Flora Aspect", costume, fill_flora, stroke_flora, thickness, alpha_behavior_flora) ;  
}






/**
ADN

*/

Vec3 [] drop_zone_flora_list ;
Helix_DNA strand_DNA ;
Vec3 pos_final_dna ;
int radius_dna ;
int size_dna ;
int [] target_nucleotide ;

void create_decorum() {
  //flora
  int revolution = 60 ;
  int nucleotide = num_flora *2 ;
  size_dna = int(height *1.5) ;
  radius_dna = abs(HORIZON) / 8 ;
  int num_strand = 2 ;

  pos_final_dna = Vec3(width / 2, -size_dna/3, -radius_dna) ;

  strand_DNA = new Helix_DNA(num_strand, nucleotide, revolution) ;
  strand_DNA.set_radius(radius_dna) ;
  strand_DNA.set_height(size_dna) ;
  strand_DNA.set_pos(pos_final_dna) ;

  drop_zone_flora_list = new Vec3[num_flora] ;
  target_nucleotide = new int[num_flora] ;

  for(int i = 0 ; i < drop_zone_flora_list.length ; i++) {
    drop_zone_flora_list[i] = Vec3() ;
    int where = (int)random(strand_DNA.get_pos().length) ;
    target_nucleotide[i] = where ;
    drop_zone_flora_list[i].set(strand_DNA.get_pos()[where]) ;
  }
}





void update_flora_position_from_adn() {
  for(int i = 0 ; i < FLORA_LIST.size() ; i++) {
    Agent flora = FLORA_LIST.get(i) ;
    flora.set_pos(strand_DNA.get_pos()[target_nucleotide[i]]) ;
  }
}


float rotation_dna = 0 ;
boolean rotation_bool_dna = false ;

void show_decorum(float speed_rotation_dna, int direction_dna, boolean info) {

  // show DNA
  if(size_dna > 0 ) {
    if(rotation_bool_dna) {
      rotation_dna += abs(speed_rotation_dna) *direction_dna ;
      // rotation_dna = abs(rotation_dna) *direction_dna ;
      strand_DNA.rotation(rotation_dna) ;
      strand_DNA.set_radius(radius_dna) ;
      strand_DNA.set_height(size_dna) ;
      strand_DNA.set_pos(pos_final_dna) ;
    }  

    for(int i = 0 ; i < strand_DNA.length() ; i++) {
      costume_DNA(strand_DNA, i, pos_final_dna, info) ;
    }
  }
}

void costume_DNA(Helix_DNA helix, int target, Vec3 pos_final, boolean info) {
  Vec3 pos_a = helix.get_pos(0)[target] ;
  Vec3 pos_b = helix.get_pos(1)[target] ;

  int size = 36 ;
  int size_link = 1 ;

  float radius = helix.get_radius().x ;
  float alpha_min = .01 ;
  float alpha_max = .8 ;

  stroke(80, 8) ;
  strokeWeight(size_link) ;
  line(pos_a, pos_b) ;

  float ratio_a = map(pos_a.z -pos_final_dna.z , -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_a = g.colorModeA * ratio_a ;
  
  


  float ratio_b = map(pos_b.z -pos_final_dna.z, -radius, radius, 0 +alpha_min, alpha_max) ;
  float alpha_b = g.colorModeA *ratio_b ;


  if(info) {
    fill(color_strand_a, alpha_a) ;
    String nuc_a = "" +helix.get_DNA(0).sequence_a.get(target).nac ;
    costume_rope(pos_a, size, nuc_a) ;
    fill(color_strand_b, alpha_b) ;
    String nuc_b = "" +helix.get_DNA(0).sequence_a.get(target).nac ;
    costume_rope(pos_b, size, nuc_b) ;
  } else {
    noFill() ;
    stroke(color_strand_a, alpha_a) ;
    costume_rope(pos_a, size, POINT_ROPE) ;
    noFill() ;
    stroke(color_strand_b, alpha_b) ;
    costume_rope(pos_b, size, POINT_ROPE) ;
  }
  
}


