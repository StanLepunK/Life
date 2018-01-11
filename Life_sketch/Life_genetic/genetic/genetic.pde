

void setup() {
  size(300,300) ;
  // used to load DNA sequence table
  load_nucleotide_table("code.csv") ;


  float [] data_float = new float[5] ;
  float [] data_float_mother = new float[5] ;
  float [] data_float_father = new float[5] ;
  for(int i = 0 ; i < data_float.length ;i++) {
     data_float[i] = random(10,40) ;
     data_float_mother[i] = random(10,40) ;
     data_float_father[i] = random(10,40) ;
  }
  Genome genome_float = archetype(data_float) ;
  int gender = 0 ;
  Genome genome_float_female = archetype(data_float_mother, gender) ;
  gender = 1 ;
  Genome genome_float_male = archetype(data_float_father, gender) ;


  String info_gene = "blue, orange, green, yellow" ;
  String [] data_string ;
  data_string = info_gene.split(",") ;
  Genome genome_string = archetype(data_string) ;


  String name_gene = "gene A,gene B,gene C,gene D,gene F,gene G,gene H,gene I,gene J,gene K,gene L" ;
  String [] list_gene_name ;
  list_gene_name = name_gene.split(",") ;
 // Genome genome_plus_name = archetype(data_string, list_gene_name) ;
  // Genome genome_plus_name = archetype(data_float, list_gene_name) ;



  Genome genome = archetype(data_float, data_string, list_gene_name) ;
  Genome genome_child = genotype(genome_float_female,genome_float_male) ;



  // Genome genome = build_genome() ;
  /*
  println(genome.get_chromosome_num()) ;
  println(genome.get_chromosome_name()) ;
  
  int num_chromosome = genome.get_chromosome_num() ;
  for(int i = 0 ; i < num_chromosome ; i++ ) {
    println(genome.get_gene_map(i)) ;
    println(genome.get_gene_product(i)) ;
  }
  */
  /*
  println(genome_float.get_gene_product()) ;
  println(genome_string.get_gene_product()) ;
  println(genome_plus_name.get_gene_product()) ;
  println(genome.get_gene_product()) ;
  println(genome_float_female.get_gene_product()) ;
  println(genome_float_male.get_gene_product()) ;
  */

 println(genome_child.num_gene()) ;


/**
Mutation example
*/
/*
  println("before mutation") ;
  println(genome.get_genotype()) ;


  genome.mutation_data("eye", "1", true, true) ;
  int which_chromosome = 1 ;
  int locus = 2 ;
  String new_data = "1" ;
  genome.mutation_data( which_chromosome, locus, new_data, true, true) ;
  
  genome.mutation_dominance("eye", 1.5, true, true) ;
  float new_dominance = 1.3 ;
  genome.mutation_dominance( which_chromosome, locus, new_dominance, true, true) ;
  println(" ") ;
  println("after mutation") ;
    */
  println(genome_child.get_genotype()) ;




/**
Gen map example
*/

  for(Info i : genome.gene_map) {
// println(i) ;
  }


/**
get example
*/
  //println(genome.get_DNA("Chromosome Float", "size", 0)) ;
  // println(genome.get_DNA("Chromosome Float", 1, 0)) ;
  // println(genome.get_DNA(0, 0, 0)) ;
  //println(genome.get_gene(which_gene).chromosome_name) ;
  // println(genome_float_female.get_gene_product("XY")) ;

  // println(genome.get_gene_product("Size X")) ;
  // println(genome.get_gene_product("Float", "Size X")) ;

   // println(genome.get_gene_product(0, 0)) ;
   println("mother", genome_float_female.get_gene_product(0, 0)) ;
   println("father", genome_float_male.get_gene_product(0, 0)) ;
   println("child", genome_child.get_gene_product(0, 0)) ;
  
  // float size = genome.get_gene_product("Size X").f_a ;
  // ellipse(width/2,height/2,size, size) ;


}









/**
Example to build a specific Genome
Method to create a genome with a lot of attention !
*/
Genome build_genome() {
  String [] chromosome_name = new String[3] ;
  int num_info = 8 ;
  String [] gene_name = new String[num_info] ;
  Gene [] gene_data_mother = new Gene[num_info] ;
  Gene [] gene_data_father = new Gene[num_info] ;

  chromosome_name[0] = "Physical" ;
  gene_name [0] = "Size X" ;
  gene_data_mother [0] = new Gene(chromosome_name[0],gene_name [0], 11,15, .01,.04) ;
  gene_data_father [0] = new Gene(chromosome_name[0],gene_name [0], 13,19, .01,.04) ;

  gene_name [1] = "Size Y" ;
  gene_data_mother [1] = new Gene(chromosome_name[0],gene_name [1], 3,15, .01,.04) ;
  gene_data_father [1] = new Gene(chromosome_name[0],gene_name [1], 10,12, .01,.04) ;

  gene_name [2] = "Size Z" ;
  gene_data_mother [2] = new Gene(chromosome_name[0],gene_name [2], 3,15, .08,.04) ;
  gene_data_father [2] = new Gene(chromosome_name[0],gene_name [2], 6,13, .01,.04) ;


  chromosome_name[1] = "Aspect" ;
  gene_name [3] = "Fill X" ;
  gene_data_mother [3] = new Gene(chromosome_name[1],gene_name [3], .5,1, .01,.04) ;
  gene_data_father [3] = new Gene(chromosome_name[1],gene_name [3], .6,.8, .01,.04) ;

  gene_name [4] = "Fill Y" ;
  gene_data_mother [4] = new Gene(chromosome_name[1],gene_name [4], .2,.7, .01,.04) ;
  gene_data_father [4] = new Gene(chromosome_name[1],gene_name [4], .05,.3, .01,.04) ;

  gene_name [5] = "Fill Z" ;
  gene_data_mother [5] = new Gene(chromosome_name[1],gene_name [5], .1,.3, .01,.04) ;
  gene_data_father [5] = new Gene(chromosome_name[1],gene_name [5], .5,.6, .01,.04) ;

  gene_name [6] = "Fill W" ;
  gene_data_mother [6] = new Gene(chromosome_name[1],gene_name [6], .5,1, .01,.03) ;
  gene_data_father [6] = new Gene(chromosome_name[1],gene_name [6], 1,1, .01,.04) ;


  chromosome_name[2] = "Blood" ;
  gene_name [7] = "Blood group" ;
  // try to create a dominant and recessive gene with 0 and 1 value, just a track ????
  gene_data_mother [7] = new Gene(chromosome_name[2], gene_name [7], "A","O", 1,0) ;
  gene_data_father [7] = new Gene(chromosome_name[2], gene_name [7], "O","B", 0,1) ;



  return new Genome(chromosome_name, gene_name, gene_data_mother, gene_data_father) ;
  
}