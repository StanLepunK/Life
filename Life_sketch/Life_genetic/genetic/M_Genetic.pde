/**
Methode Genetic 0.1.0
* Start June 2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Digital-Vivant-Digital-Life/tree/master/GENETIC
*/

/**
Genotype
methode to generate a new genome from the mother and father genome
*/
Genome genotype(Genome mother, Genome father) {
  if(mother.num_chromosome() == father.num_chromosome() && mother.num_gene() == father.num_gene()) {
    // may be remove "1" for the gender chromosome ????
    String [] chromosome_name = new String[mother.num_chromosome() -1] ;
    for(int i = 0 ; i < chromosome_name.length ; i++) {
      chromosome_name[i] = mother.get_chromosome_name()[i] ;
    }
    String [] gene_name = new String[mother.num_gene() -1] ;
    Gene [] gene_data_mother = new Gene[mother.num_gene() -1] ;
    Gene [] gene_data_father = new Gene[mother.num_gene() -1] ;
    for(int i = 0 ; i < gene_name.length ; i++) {
      gene_name[i] = mother.get_genotype()[i].gene_name ;
      gene_data_mother[i] = mother.get_genotype()[i] ;
      gene_data_father[i] = father.get_genotype()[i] ;

    }
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;

  } else {
    return null ;
  }
}



/**
Archetype
method to generate a quick genome from a simple data
The method create two chromosome, one for the data value, one for the String data
int this method the first genome is used for the float data and the second for the String data
*/
Genome archetype(float [] float_data) {
  String [] string_data = new String[0] ;
  String [] data_name = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data) {
  float [] float_data = new float[0] ;
  String [] data_name = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] data_name) {
  String [] string_data = new String[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data, String [] data_name) {
  float [] float_data = new float[0] ;
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] string_data, String [] data_name) {
  int gender = MAX_INT ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, int gender) {
  String [] string_data = new String[0] ;
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(String [] string_data, int gender) {
  float [] float_data = new float[0] ;
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}

Genome archetype(float [] float_data, String [] string_data, int gender) {
  String [] data_name = new String[0] ;
  return archetype(float_data, string_data, data_name, gender) ;
}






Genome archetype(float [] float_data, String [] string_data, String [] data_name, int gender) {
  int num_chromosome = 2 ;
  if(float_data.length < 1 || string_data.length < 1) {
    num_chromosome = 1 ;
  }
  String [] chromosome_name = new String[num_chromosome] ;

  int num_info = float_data.length + string_data.length ;
  Gene [] gene_data_mother = new Gene[num_info] ;
  Gene [] gene_data_father = new Gene[num_info] ;
  String [] gene_name = new String[num_info] ;
  // init var
  for(int i = 0 ; i < gene_name.length ; i++) { 
    gene_name[i] = Integer.toString(i) ;
  }

  int num_naming = 0 ;
  if (gene_name.length <= data_name.length) {
    num_naming = gene_name.length ; 
  } else { 
    num_naming = data_name.length ;
  }
  // loop on the smalest list to don't have out bound
  for(int i = 0 ; i < num_naming ; i++) {
    gene_name [i] = data_name[i] ;
  }


  // make chromosome
  int pointer = 0 ;

  if(float_data.length > 0) {
    chromosome_name[0] = "Float" ;
    for(int i = 0 ; i < float_data.length ; i++) {
      int locus = i ;
      Vec2 mother = Vec2(float_data[i]) ;
      Vec2 father = Vec2(float_data[i]) ;
      Vec2 mother_dominance = Vec2("RANDOM ZERO", 1) ;
      Vec2 father_dominance = Vec2("RANDOM ZERO", 1) ;
      gene_data_mother [i] = new Gene(chromosome_name[0], gene_name [pointer], locus, mother, mother_dominance) ;
      gene_data_father [i] = new Gene(chromosome_name[0], gene_name [pointer], locus, father, father_dominance) ;
      pointer++ ;
    }
  }
  if(string_data.length > 0) {
    int ID_chromosome = 1 ;
    if(float_data.length < 1) ID_chromosome = 0 ;
    chromosome_name[ID_chromosome] = "String" ;
    for(int i = 0 ; i < string_data.length ; i++) {
      int locus = i ;
      String mother_left = string_data[i] ;
      String mother_right = string_data[i] ;
      String father_left = string_data[i] ;
      String father_right = string_data[i] ;
      Vec2 mother_dominance = Vec2("RANDOM ZERO", 1) ;
      Vec2 father_dominance = Vec2("RANDOM ZERO", 1) ;
      gene_data_mother [pointer] = new Gene(chromosome_name[ID_chromosome], gene_name [pointer], locus, mother_left, mother_right, round(mother_dominance.x), round(mother_dominance.y))  ;
      gene_data_father [pointer] = new Gene(chromosome_name[ID_chromosome], gene_name [pointer], locus, father_left, father_right, round(father_dominance.x), round(father_dominance.y))  ;
      pointer++ ;
    }
  }
  

  // finalize
  if(gender == 0 || gender == 1) {
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father, gender) ;
  } else {
    return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
  }
}